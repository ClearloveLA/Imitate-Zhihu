const express = require('express');
const db = require('./db');
const multer = require('multer');
const path = require('path');
const router = express.Router();

// 配置 multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, 'uploads/'),
  filename: (req, file, cb) => {
    const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1E9)}-${file.originalname}`;
    cb(null, uniqueSuffix);
  },
});

const upload = multer({ storage });

// 获取所有帖子（连表查询用户信息）
router.get('/posts', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT posts.*, users.username
      FROM posts
      JOIN users ON posts.user_id = users.id
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: '数据库查询失败' });
  }
});


// 获取单个帖子（连表查询用户信息）
router.get('/posts/:id', async (req, res) => {
  const postId = req.params.id;
  try {
    const [rows] = await db.query(`
      SELECT posts.*, users.username
      FROM posts
      JOIN users ON posts.user_id = users.id
      WHERE posts.id = ?
    `, [postId]);
    
    if (rows.length === 0) {
      return res.status(404).json({ error: '帖子不存在' });
    }
    
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: '数据库查询失败' });
  }
});


// 创建帖子，包含图片上传
router.post('/posts', upload.array('images', 3), async (req, res) => {
  const { title, content, user_id } = req.body;

  // 如果 `req.files` 存在，则映射路径，否则为空数组
  const imagePaths = req.files ? req.files.map(file => `/uploads/${file.filename}`) : [];

  try {
    const [result] = await db.query(
      'INSERT INTO posts (title, content, user_id, images) VALUES (?, ?, ?, ?)',
      [title, content, user_id, JSON.stringify(imagePaths)]
    );
    res.status(201).json({ id: result.insertId, title, content, user_id, images: imagePaths });
  } catch (err) {
    console.error('数据库插入失败:', err);
    res.status(500).json({ error: '数据库插入失败' });
  }
});

// 更新帖子，包含图片上传功能
router.put('/posts/:id', upload.array('images', 3), async (req, res) => {
  const postId = req.params.id;
  const { title, content } = req.body;

  // 处理新上传的图片路径
  const newImages = req.files ? req.files.map(file => `/uploads/${file.filename}`) : [];

  // 解析 existingImages JSON 字符串
  const existingImages = req.body.existingImages ? JSON.parse(req.body.existingImages) : [];

  // 合并图片
  const combinedImages = [...existingImages, ...newImages];

  try {
    const [result] = await db.query(
      'UPDATE posts SET title = ?, content = ?, images = ? WHERE id = ?',
      [title, content, JSON.stringify(combinedImages), postId]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: '帖子不存在' });
    }

    res.json({ message: '帖子更新成功' });
  } catch (err) {
    console.error('数据库更新失败：', err);
    res.status(500).json({ error: '数据库更新失败' });
  }
});


const fs = require('fs');

// 删除帖子
router.delete('/posts/:id', async (req, res) => {
  const postId = req.params.id;
  
  try {
    // 获取帖子信息以便删除图片文件
    const [rows] = await db.query('SELECT images FROM posts WHERE id = ?', [postId]);
    
    if (rows.length === 0) {
      return res.status(404).json({ error: '帖子不存在' });
    }

    // 解析图片路径
    const images = JSON.parse(rows[0].images) || [];

    // 删除数据库中的帖子
    const [result] = await db.query('DELETE FROM posts WHERE id = ?', [postId]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: '帖子删除失败' });
    }

    // 删除图片文件（如果存在）
    images.forEach(imagePath => {
      const fullPath = path.join(__dirname, '..', imagePath);
      fs.unlink(fullPath, (err) => {
        if (err) console.error(`删除文件失败: ${fullPath}`, err);
      });
    });

    res.json({ message: '帖子删除成功' });
  } catch (err) {
    console.error('删除帖子失败：', err);
    res.status(500).json({ error: '删除帖子失败' });
  }
});


module.exports = router;
