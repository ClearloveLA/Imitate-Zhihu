const express = require('express');
const router = express.Router();  
const db = require('./db');
const bcrypt = require('bcryptjs'); // 密码加密
const jwt = require('jsonwebtoken'); // JWT生成与验证

// 用户登录接口
router.post('/login', async (req, res) => {
  const { phoneNumber, password } = req.body;

  if (!phoneNumber || !password) {
    return res.status(400).json({ message: '手机号或密码不能为空' });
  }

  try {
    const [user] = await db.query('SELECT * FROM users WHERE phone_number = ?', [phoneNumber]);

    if (!user || user.length === 0) {
      const hashedPassword = await bcrypt.hash(password, 10);
      const [result] = await db.query('INSERT INTO users (phone_number, password) VALUES (?, ?)', [phoneNumber, hashedPassword]);
      const token = jwt.sign({ id: result.insertId, phoneNumber }, 'secretKey', { expiresIn: '1h' });
      return res.status(201).json({ message: '注册并登录成功', token, user: { id: result.insertId, phoneNumber } });
    } else {
      const isPasswordValid = await bcrypt.compare(password, user[0].password);
      if (!isPasswordValid) {
        return res.status(400).json({ message: '密码不正确' });
      }

      const token = jwt.sign({ id: user[0].id, phoneNumber: user[0].phone_number }, 'secretKey', { expiresIn: '1h' });
      return res.status(200).json({ message: '登录成功', token, user: { id: user[0].id, phoneNumber: user[0].phone_number } });
    }
  } catch (err) {
    res.status(500).json({ message: '服务器错误' });
  }
});

// 获取所有用户
router.get('/users', async (req, res) => {
  try {
    console.log('获取users')
    const [rows] = await db.query('SELECT * FROM users')
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: '数据库查询失败' });
  }
});

// 更新用户信息
router.put('/users/:id', async (req, res) => {
  const userId = req.params.id;
  const { username, phone_number, email } = req.body; // 接收请求中的数据

  try {
    // 更新用户信息
    console.log('更新')
    await db.query('UPDATE users SET username = ?, phone_number = ?, email = ? WHERE id = ?', [username, phone_number, email, userId]);
    res.json({ message: '用户更新成功' });
  } catch (err) {
    console.error('更新用户失败:', err);
    res.status(500).json({ message: '服务器错误' });
  }
});

// 删除用户
router.delete('/users/:id', async (req, res) => {
  const userId = req.params.id;

  try {
    await db.query('DELETE FROM users WHERE id = ?', [userId]);
    res.json({ message: '用户删除成功' });
  } catch (err) {
    res.status(500).json({ message: '数据库删除失败' });
  }
});

// 获取单个用户信息
router.get('/users/:id', async (req, res) => {
  const userId = req.params.id;

  try {
    // 查询数据库获取单个用户信息
    const [user] = await db.query('SELECT * FROM users WHERE id = ?', [userId]);

    // 检查用户是否存在
    if (user.length === 0) {
      return res.status(404).json({ message: '用户不存在' });
    }

    res.json(user[0]); // 返回用户数据
  } catch (err) {
    console.error('获取用户信息失败:', err);
    res.status(500).json({ message: '服务器错误' });
  }
});


// 该接口用于获取用户关注的所有帖子及每个帖子的总关注数
router.get('/followedPosts', async (req, res) => {
  const { userId } = req.query;

  try {
    // 通过 LEFT JOIN 将 posts 表与 follow 表关联，查询出当前用户关注的所有帖子，并统计每个帖子的关注总数
    const [rows] = await db.query(
      `SELECT posts.id, posts.title, posts.images, COUNT(f2.userid) AS follow_count
       FROM posts
       LEFT JOIN follow AS f2 ON posts.id = f2.comentid
       WHERE posts.id IN (SELECT comentid FROM follow WHERE userid = ?)
       GROUP BY posts.id, posts.title, posts.images`,
      [userId]
    );

    if (rows.length > 0) {
      res.json(rows);
    } else {
      res.json([]); // 返回空数组表示没有关注的帖子
    }
  } catch (error) {
    console.error('获取关注的帖子失败:', error);
    res.status(500).json({ message: '服务器错误' });
  }
});


// 取消关注接口
router.post('/unfollow', async (req, res) => {
  const { user_id, post_id } = req.body; // 使用 `user_id` 和 `post_id` 解构

  try {
    const sql = 'DELETE FROM follow WHERE comentid = ? AND userid = ?';
    const [result] = await db.query(sql, [post_id, user_id]);

    if (result.affectedRows > 0) {
      res.status(200).json({ message: '取消关注成功' });
    } else {
      res.status(404).json({ message: '未找到关注记录' });
    }
  } catch (error) {
    console.error('取消关注失败:', error);
    res.status(500).json({ message: '取消关注失败' });
  }
});


// 关注
// 该接口用于添加关注记录，即用户关注一个帖子
router.post('/follow', (req, res) => {
  const { userid, comentid, author } = req.body;
  console.log(`用户 ${userid} 正在关注帖子 ${comentid}`);

  db.query(
    'INSERT INTO follow (userid, comentid, author) VALUES (?, ?, ?)',
    [userid, comentid, author],
    (error, result) => {
      if (error) {
        console.error('关注失败:', error);
        return res.status(500).json({ message: '关注失败' });
      }
      console.log('关注成功');
      return res.status(200).json({ message: '关注成功' });
    }
  );
});

// 该接口用于检查用户是否已关注某帖子
router.post('/getfollows', async (req, res) => {
  const { userid, comentid } = req.body;
  try {
    const [rows] = await db.query(
      'SELECT * FROM follow WHERE userid = ? AND comentid = ?',
      [userid, comentid]
    );
    const isFollowing = rows.length > 0;
    res.json({ isFollowing });
  } catch (error) {
    res.status(500).json({ error: '查询关注状态失败' });
  }
});

// 获取用户关注的总数量 即用户关注的帖子数
router.post('/getFollowCount', async (req, res) => {
  const { userid } = req.body;
  try {
    const [rows] = await db.query(
      'SELECT COUNT(*) AS followCount FROM follow WHERE userid = ?',
      [userid]
    );
    const followCount = rows[0].followCount;
    res.json({ followCount });
  } catch (error) {
    console.error('获取关注总数失败:', error);
    res.status(500).json({ error: '获取关注总数失败' });
  }
});

// 通过 LEFT JOIN 将 posts 表与 collect 表关联，查询出当前用户收藏的所有帖子，并统计每个帖子的收藏总数
router.get('/collectedPosts', async (req, res) => {
  const { userId } = req.query;

  try {
    const [rows] = await db.query(
      `SELECT posts.id, posts.title, posts.images, 
              (SELECT COUNT(*) FROM collect WHERE collect.concent_id = posts.id) AS collect_count
       FROM posts
       LEFT JOIN collect ON posts.id = collect.concent_id
       WHERE collect.user_id = ? 
       GROUP BY posts.id, posts.title, posts.images`,
      [userId]
    );

    if (rows.length > 0) {
      res.json(rows);
    } else {
      res.json([]); // 返回空数组表示没有收藏的帖子
    }
  } catch (error) {
    console.error('获取收藏的帖子失败:', error);
    res.status(500).json({ message: '服务器错误' });
  }
});


module.exports = router;
