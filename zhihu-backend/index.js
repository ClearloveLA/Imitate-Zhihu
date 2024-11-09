const cors = require('cors');
const express = require('express');
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require('path');
const postRoutes = require('./postRoutes');
const userRoutes = require('./userRoutes');
const commentRoutes = require('./commentRoutes');

const app = express();
const PORT = 8000;

app.use(cors());
app.use(bodyParser.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads'))); // 设置静态资源文件夹
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/api', postRoutes);
app.use('/api', userRoutes);
app.use('/api', commentRoutes);

// 配置 multer，用于文件上传
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // 将文件存储在 'uploads' 文件夹中
  },
  // 上传文件的命名
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + '-' + file.originalname); // 自定义文件名
  }
});

const upload = multer({ storage: storage });

// 图片上传接口
app.post('/api/upload', upload.array('images', 3), (req, res) => {
  try {
    const filePaths = req.files.map(file => `/uploads/${file.filename}`);

    res.status(200).json({
      message: '图片上传成功',
      images: filePaths // 将上传的文件路径返回给前端
    });
  } catch (error) {
    res.status(500).json({ error: '图片上传失败' });
  }
});




app.get('/', (req, res) => {
  res.send('success');
});

app.listen(PORT, () => {
  console.log(`Server running on port http://localhost:${PORT}`);
});
