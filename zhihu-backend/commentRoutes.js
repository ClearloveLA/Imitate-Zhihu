const express = require('express');
const db = require('./db');
const router = express.Router();

// 获取所有评论（用于后台管理）
router.get('/comments', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT comments.id, comments.content, comments.created_at, users.username, posts.title AS post_title
      FROM comments
      JOIN users ON comments.user_id = users.id
      JOIN posts ON comments.post_id = posts.id;
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: '数据库查询失败' });
  }
});


router.get('/posts/:postId/comments', async (req, res) => {
  const postId = req.params.postId;
  try {
    const [rows] = await db.query(`
      SELECT comments.id, comments.content, comments.created_at, users.username
      FROM comments
      JOIN users ON comments.user_id = users.id
      WHERE comments.post_id = ?;
    `, [postId]);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: '数据库查询失败' });
  }
});


// 创建评论
router.post('/posts/:postId/comments', async (req, res) => {
  const postId = req.params.postId;
  const { user_id, content } = req.body;
  try {
    const [result] = await db.query('INSERT INTO comments (post_id, user_id, content) VALUES (?, ?, ?)', [postId, user_id, content]);
    res.status(201).json({ id: result.insertId, post_id: postId, user_id, content });
  } catch (err) {
    res.status(500).json({ error: '数据库插入失败' });
  }
});

// 删除评论
router.delete('/comments/:id', async (req, res) => {
  const commentId = req.params.id;
  try {
    await db.query('DELETE FROM comments WHERE id = ?', [commentId]);
    res.json({ message: '评论删除成功' });
  } catch (err) {
    res.status(500).json({ error: '数据库删除失败' });
  }
});

router.put('/comments/:id', async (req, res) => {
  const commentId = req.params.id;
  const { content } = req.body;

  console.log(`更新评论ID: ${commentId}, 新评论内容: ${content}`);

  // 检查 commentId 是否为有效值
  if (!commentId || commentId === 'undefined') {
    console.log('无效的评论ID');
    return res.status(400).json({ error: '无效的评论ID' });
  }

  try {
    const [result] = await db.query('UPDATE comments SET content = ? WHERE id = ?', [content, commentId]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: '评论不存在' });
    }
    res.json({ message: '评论更新成功' });
  } catch (err) {
    console.error('数据库更新失败：', err);
    res.status(500).json({ error: '数据库更新失败' });
  }
});


// 搜索发现
// 路由：通过点赞数量排序获取帖子  
router.get('/sorted-by-likes', async (req, res) => {  
  try {  
    // const sortOrder = req.query.order === 'desc' ? 'DESC' : 'ASC'; // 根据请求参数决定排序顺序  
      const sortOrder = 'desc'
    const [rows] = await db.query(  
      'SELECT * FROM posts ORDER BY likes ' + sortOrder  
    );  
    res.status(200).json(rows);  
  } catch (error) {  
    console.error('Error executing query:', error);  
    res.status(500).json({ error: 'Internal Server Error' });  
  }  
}); 

// 猜你想搜索
router.get('/getSearch',async (req,res)=>{
 try{
  const [rows] = await db.query(  'SELECT * FROM posts ORDER BY RAND() LIMIT 5');  
   res.json(rows);  
 }catch(err){
  console.error('Error executing query:', error);  
  res.status(500).json({ error: 'Internal Server Error' });  
 }
})


// 收藏
router.post('/collect', async (req,res)=>{
  const user_id = req.body.user_id
  const concent_id = req.body.concent_id
  try{
    const [rows] = await db.query('INSERT INTO collect (user_id, concent_id) VALUES ( ?, ?)', [user_id, concent_id])
    res.status(200).json('susess');
  }catch(err){
    console.error('Error executing query:', error);  
    res.status(500).json({ error: 'Internal Server Error' });  
  }
})

// 路由：处理点赞请求  
router.post('/like',(req, res) => {  
  const { postId, userId } = req.body; // 假设请求体中包含 postId 和 userId  
  if (!postId || !userId) {  
    return res.status(400).json({ error: 'postId and userId are required' });  
  }  
  // 检查用户是否已经点赞（可选步骤，根据你的业务需求来决定是否需要）  
  // 这里我们假设没有点赞记录表，只是简单地更新 post 表中的 likes 字段 
  const query = 'UPDATE posts SET likes = likes + 1 WHERE id = ?';  
   db.query('INSERT INTO give (userid, cocmentid) VALUES ( ?, ?)', [userId, postId])
  db.query(query, [postId], (error, results, fields) => {  
    if (error) {  
      return res.status(500).json({ error: error.message });  
    }  
    res.json({ message: 'Post liked successfully', likes: results.affectedRows > 0 ? results.affectedRows : 0 });  
  });  
});  

// 取消收藏
router.post('/cancel-collection', async (req,res)=>{
    const concent_id = req.body.concent_id
    const sql = 'DELETE FROM collect WHERE concent_id = ?'
    const [row] = await db.query(sql,[concent_id])
    res.status(200)
})

// 读取当前是否收藏
router.post('/getUserCancel',async (req,res)=>{
  const user_id = req.body.user_id
  const concent_id = req.body.concent_id
  const sql = 'SELECT * FROM collect WHERE user_id = ? AND  concent_id = ?'
  const [row] = await db.query(sql,[user_id,concent_id])
    res.send(row)
})
// 取消点赞

router.post('/esclike',(req, res) => {  
  const { postId, userId } = req.body; // 假设请求体中包含 postId 和 userId  
  if (!postId || !userId) {  
    return res.status(400).json({ error: 'postId and userId are required' });  
  }  
  const query = 'UPDATE posts SET likes = likes - 1 WHERE id = ?';  
  db.query('DELETE FROM give WHERE cocmentid = ?',[postId])
  db.query(query, [postId], (error, results, fields) => {  
    if (error) {  
      return res.status(500).json({ error: error.message });  
    }  
    res.json({ message: 'Post liked successfully', likes: results.affectedRows > 0 ? results.affectedRows : 0 });  
  });  
}); 

// 判断是否点赞
router.post('/getgive',async (req,res)=>{
  const userid = req.body.userid
  const cocmentid = req.body.cocmentid
  
  const sql = 'SELECT * FROM give WHERE userid = ? AND  cocmentid = ?'
  const [row] = await db.query(sql,[userid,cocmentid])
    res.send(row)
})


// 读取热榜
router.get('/gethotlist',async (req,res)=>{
  const sql = 'SELECT * FROM posts ORDER BY likes DESC'
  const [row] = await db.query(sql)
  res.send(row)

})

// 读取问题直达数据

router.get('/record',async (req,res)=>{
  const sql = 'SELECT * FROM record '
  const [row] = await db.query(sql)
  res.send(row)

})


// 读取是否关注
router.post('/getFollow', async (req,res)=>{
  const userid = req.body.userid
  const comentid = req.body.comentid
  
  const sql = 'SELECT * FROM follow WHERE userid = ? AND  comentid = ?'
  const [row] = await db.query(sql,[userid,comentid])
    res.send(row)
  
})




// 读取关注数量

router.post('/getfollows',async (req,res)=>{
  const userid = req.body.userid
  const sql = 'SELECT * FROM follow WHERE userid = ?'
  const [row] = await db.query(sql,[userid])
  res.send(row)
})

// 读取收藏数量

router.post('/getlikesNum',async (req,res)=>{
  const user_id = req.body.user_id
  const sql = 'SELECT * FROM collect WHERE user_id = ?'
  const [row] = await db.query(sql,[user_id])
  res.send(row)
})

// 读取评论数量

router.post('/getcomments',async (req,res)=>{
  const post_id = req.body.post_id
  const sql = 'SELECT * FROM comments WHERE post_id = ?'
  const [row] = await db.query(sql,[post_id])
  res.send(row)
})

// 删除帖子
router.post('/delcoment',(req,res)=>{




})



// 后台管理系统登录

router.post('/adminlogin',async (req,res)=>{
    const username = req.body.username
    const password = req.body.password
    const sql = 'SELECT * FROM admin_user WHERE username = ? AND  password = ?'
    const row = await db.query(sql,[username,password])
    res.send(row[0])
})

// 后台管理系统注册

router.post('/adminreg',async (req,res)=>{
  const username = req.body.username
  const password = req.body.password
  const sql  = 'INSERT INTO admin_user (username, password) VALUES (?,?)'
  const row = await db.query(sql,[username,password])
  if(row.affectedRows === 1){
    res.send('注册成功')
  }else{
    res.send('注册失败')
  }
})





// 读取数据
router.post('/getData', async(req,res)=>{

    const sql1 = 'SELECT * FROM posts'  // 帖子总数

    const sql2 = 'SELECT * FROM comments'  // 评论总数

    const sql3 = 'SELECT * FROM users'  // 用户总数

    const res1 =  await db.query(sql1)
    const res2 = await db.query(sql2)
    const res3 = await db.query(sql3)

    res.send({
      'data1':res1,
      'data2':res2,
      'data3':res3,
    })
    


})



module.exports = router;
