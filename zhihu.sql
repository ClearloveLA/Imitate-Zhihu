/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : zhihu

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 04/11/2024 15:14:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, '', '');
INSERT INTO `admin_user` VALUES (2, 'admin', '123456789');
INSERT INTO `admin_user` VALUES (3, 'admin333', '123456789');
INSERT INTO `admin_user` VALUES (4, 'admin11', '123456789');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user_id` int(255) NULL DEFAULT NULL COMMENT '用户id',
  `concent_id` int(255) NULL DEFAULT NULL COMMENT '内容id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (15, 7, 1);
INSERT INTO `collect` VALUES (16, 7, 2);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, '感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！呵呵。感谢分享，受益匪浅！', 2, 1, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (2, '这篇文章写得很好，学习了。', 3, 1, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (3, '请问有推荐的学习资料吗？', 4, 1, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (4, '我也在研究数据库优化，一起交流。', 1, 2, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (5, '有些部分不是很明白，能详细说明吗？', 5, 2, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (6, '我更喜欢 Vue，感觉更轻量。', 2, 3, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (7, 'React 的生态圈更丰富。', 4, 3, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (8, 'Angular 的学习曲线有点陡。', 5, 3, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (9, '各有优劣，主要看项目需求。', 1, 3, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (10, '正好在学 Express，感谢！', 3, 4, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (11, 'Sequelize 用起来确实方便。', 2, 5, '2024-10-30 12:48:34');
INSERT INTO `comments` VALUES (12, '有没有关于 Sequelize 事务的教程？', 4, 5, '2024-10-30 12:48:34');

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `userid` int(255) NULL DEFAULT NULL,
  `comentid` int(255) NULL DEFAULT NULL,
  `author` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of follow
-- ----------------------------
INSERT INTO `follow` VALUES (12, 7, 1, 1);
INSERT INTO `follow` VALUES (13, 7, 2, 2);

-- ----------------------------
-- Table structure for give
-- ----------------------------
DROP TABLE IF EXISTS `give`;
CREATE TABLE `give`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `userid` int(255) NULL DEFAULT NULL COMMENT '用户id',
  `cocmentid` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of give
-- ----------------------------
INSERT INTO `give` VALUES (9, 7, 2);
INSERT INTO `give` VALUES (8, 7, 1);

-- ----------------------------
-- Table structure for hotlist
-- ----------------------------
DROP TABLE IF EXISTS `hotlist`;
CREATE TABLE `hotlist`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `userid` int(255) NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `likes` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `coment` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotlist
-- ----------------------------
INSERT INTO `hotlist` VALUES (1, '西班牙 8 小时下完 1 年的雨，暴雨致 211 人死亡，造成暴雨的原因有哪些？对西班牙带来哪些影响？', 1, 'https://picx.zhimg.com/80/v2-b8a27a410a7765c62c49fdd6cea6396f_400x224.webp?source=1def8aca', '100', '当地时间11月2日，西班牙政府最新的统计数据显示，该国洪灾遇难人数上升至211人，其中208名遇难者来自巴伦西亚。西班牙政府已宣布为遇难者举行为期3天的官方哀悼。');
INSERT INTO `hotlist` VALUES (2, '四部门发文，11 月 1 日起不符合新规电动自行车将被禁，这对居民出行有何改变？', 1, 'https://picx.zhimg.com/v2-fda98edea203516f1901042fde7fe617_400x224.jpg?source=57bbeac9', '90', '市场监管总局、工业和信息化部、公安部、国家消防救援局 10 月 8 日发布关于加强电动自行车产品准入及行业规范管理的公告。现行的电动自行车安全强制性国家标准包括 GB 17761—2018《电动自行车安全技术规范》、GB 42295—2022《电动自行车电气安全要求》、GB 42296—2022《电动自行车用充电器安全技术要求》、GB 43854—2024《电动自行车用锂离子蓄电池安全技术规范》等。');
INSERT INTO `hotlist` VALUES (3, '大家如何看待发现鳌太线帐篷里尸体的探险博主又一次在崛围山发现尸体？', 1, 'https://picx.zhimg.com/80/v2-555c982f401f82db4744017d76f2c54b_400x224.png', '80', '11月1日， #太原警方回应博主在深山发现遗体#话题，冲上微博热搜。');
INSERT INTO `hotlist` VALUES (4, '女孩收 200 万分手费因敲诈勒索获刑，分手费多少算敲诈？有哪些警示作用？', 1, '	https://picx.zhimg.com/v2-4fd5d8963693b4a87d0ac4681d99f925_400x224.jpg?source=57bbeac9', '77', '阿蕊因犯敲诈勒索罪被判有期徒刑十年');
INSERT INTO `hotlist` VALUES (5, '如何看待 Faker 选手夺得第五座全球总决赛冠军？', 1, 'https://picx.zhimg.com/80/v2-4786aae39073c2f2b7f55dcaa76b9bed_400x224.webp?source=1def8aca', '72', '11年！\r\n\r\n职业选手！');
INSERT INTO `hotlist` VALUES (6, '用一万台无人机搭载炸弹，攻击航母，会对航母产生怎样的影响？如果这些无人机有视觉识别能力呢？', 1, 'https://pic1.zhimg.com/80/v2-e79264253a223b5e4468a1f8f392551f_400x224.webp?source=1def8aca', '71', 'rt');
INSERT INTO `hotlist` VALUES (7, '合肥市监局确认三只羊已全额缴纳 6894 万元罚款，旗下主播开始预约直播，未来会全面恢复直播带货吗？', 1, 'https://picx.zhimg.com/80/v2-bca28edad489647a3a007c45c565d36d_400x224.webp?source=1def8aca', '70', '9月26日，合肥市联合调查组发布通报称，因合肥三只羊网络科技有限公司（以下简称“三只羊公司”）存在直播中进行虚假宣传等行为，拟决定对三只羊公司没收违法所得、罚款共计6894.91万元。10月30日，有媒体报道称，针对此事拨打了安徽合肥市场监督管理局的12315电话询问最新进展，接线人员表示，“我们这边目前并没有收到相关通知是否有交，没交就没有收到相关通知。');
INSERT INTO `hotlist` VALUES (8, '黄鳝平时钻进水稻田的泥土里，草也不吃，它们是吃什么长大的？', 1, 'https://picx.zhimg.com/v2-976c80ee0e03c5eb338054e597063129_400x224.jpg?source=57bbeac9', '62', '黄鳝，又称“鳝鱼”“长鱼”，高蛋白，低脂肪，是农村人心目中的大补之物，也是农村的一道特色美味佳肴。');
INSERT INTO `hotlist` VALUES (9, '如何通俗地理解特朗普和哈里斯的政治主张？哪种主张更有利于解决当下美国面临的问题？', 1, 'https://picx.zhimg.com/80/v2-24d785f11c8d13240911c52a1d307599_400x224.webp?source=1def8aca', '60', '据环球时报报道，美国广播公司1日报道称，当天晚上美国民主党总统候选人、副总统哈里斯和共和党总统候选人、前总统特朗普将在威斯康星州密尔沃基县举行对决集会，双方集会地点相距7英里。这是二人在这个摇摆州最大县争取选票最后努力的一部分。此前一天，特朗普和哈里斯在内华达州的不同城市举行了竞选集会，双方的竞选团队都认为必须赢得该州。');
INSERT INTO `hotlist` VALUES (10, 'BLG 今年的阵容 2025 年还有可能继续保持吗？', 1, 'https://picx.zhimg.com/80/v2-d3a08a98bed70388eb2f200da6a28afe_400x224.webp?source=1def8aca', '58', NULL);
INSERT INTO `hotlist` VALUES (11, '你赞成努力在天赋面前一文不值这句话吗？', 1, 'https://pic3.zhimg.com/50/v2-ea33542c7356a58603ecc55f09ccf026_400x224.jpg', '52', '有什么具体事例可以讲述吗？');

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `likes` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '0',
  `comments_count` int(11) NULL DEFAULT 0,
  `images` json NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (1, '为什么卖股票要留100股？', '20年前贵州茅台“卖了99%，留100股作为了纪念。20年后穷困潦倒，忽然想起自己还有一百股茅台，打开账户100股经过送转变成500多股，还有几万红利，卖出股份，100多万到账，你又过上了富足的晚年生活66653838。', 1, '3', 0, '[\"/uploads/post1-1.png\", \"/uploads/post1-2.png\"]', '2024-10-30 12:48:34');
INSERT INTO `posts` VALUES (2, 'MySQL 数据库优化技巧', '优化 MySQL 数据库可以提高应用性能。', 2, '4', 0, '[\"/uploads/post2.png\"]', '2024-10-30 12:48:34');
INSERT INTO `posts` VALUES (3, '前端框架对比：React、Vue 和 Angular', '选择合适的前端框架取决于项目需求。', 3, '3', 0, NULL, '2024-10-30 12:48:34');
INSERT INTO `posts` VALUES (4, 'Express.js 入门指南', 'Express 是一个简洁而灵活的 Node.js Web 应用框架。', 4, '4', 0, '[\"/uploads/post4.png\"]', '2024-10-30 12:48:34');
INSERT INTO `posts` VALUES (5, '使用 Sequelize 进行数据库操作', 'Sequelize 是一个基于 Promise 的 Node.js ORM。', 5, '6', 0, '[\"/uploads/post5-1.png\", \"/uploads/post5-2.png\"]', '2024-10-30 12:48:34');
INSERT INTO `posts` VALUES (6, 'ff', 'dd', 6, '1', 0, '[\"/uploads/1730290795385-476817844-code.png\"]', '2024-10-30 20:19:55');
INSERT INTO `posts` VALUES (7, '如何看待现在的前端？', '这几年，为了 SEO 和加载速度，人们又开始选择 SSR。于是 react.js 变成了 next.js，vue.js 变成了 nuxt.js。但是事实上，还有 nust.js 和 nest.js。', 7, '0', 0, '[\"/uploads/1730643236235-697285311-1.jpg\"]', '2024-11-03 22:13:56');
INSERT INTO `posts` VALUES (8, '拥有外卖界半壁江山的美团亏损了1155亿？ 到底在愚弄谁?', '你们是不是很奇怪，为什么美国公司的利润这么高，而中国公司哪怕十倍于美国的规模，但利润很低，甚至还亏钱？', 7, '0', 0, '[]', '2024-11-03 22:15:11');
INSERT INTO `posts` VALUES (9, '我国的军力有多牛？', '我国的军力有多牛 现状引发全球关注', 7, '0', 0, '[]', '2024-11-03 22:15:44');
INSERT INTO `posts` VALUES (10, '如果细胞分裂速度突然加快100倍，生物体的寿命是更长还是更短了？', '如果用最直观的方法理解，细胞分裂速度加快100倍，人体就像开启了100倍播放速度，生命的长度将变成百分之一。', 7, '0', 0, '[\"/uploads/1730643400487-290518550-v2-aa3c07d7e920f43cee29209971e97d6f_200x0.jpg\"]', '2024-11-03 22:16:40');
INSERT INTO `posts` VALUES (11, '为什么现在的人难找工作？', '是工作变少了还是自己想法变多了？现在找个工作怎么变得这么难了呢？', 7, '0', 0, '[]', '2024-11-03 22:17:03');
INSERT INTO `posts` VALUES (12, '为什么说，运维是IT行业里技术含量最低的？', 'IT里的其他行业，无论是开发，测试，网络，等等，这些最终都是可以让公司挣钱或者帮助公司达成挣钱的目前，但唯独，运维是烧钱的，而且按照所谓的边际效应，聪明的人类发现最少的运维投入可以达成所谓的最优解，于是，他们不予余力的开始压低运维的投入与压榨运维的产出，于是，各类运维成为了人们口中的技术含量最低。', 7, '0', 0, '[]', '2024-11-03 22:17:39');
INSERT INTO `posts` VALUES (13, 'S14 总决赛 T1 3:2 击败 BLG 夺得队史第五座冠军并蝉联全球总冠军，如何评价这场比赛？', '古人作战讲究一鼓作气，再而衰，三而竭，第四局拿个大后期的阵容，教练BP是要背锅的，就应该乘他病要他命，拿个前期能拿资源的阵容，施以压力，更有机会。', 7, '0', 0, '[]', '2024-11-03 22:18:21');
INSERT INTO `posts` VALUES (14, 'CSS 有什么奇技淫巧？', '不是什么奇技淫巧，但是一行css代码可能让你省下js代码，作为前端的你变得更加专业', 7, '0', 0, '[\"/uploads/1730643560691-22595047-v2-c47b46ce1894db32d36c1d9f13216e25_200x0.jpg\"]', '2024-11-03 22:19:20');
INSERT INTO `posts` VALUES (15, '如何看待 OPPO Find X8 系列变得果味十足，不再那么像是 Android 手机？', '实际使用了OPPO Find X8 Pro一段时间，发觉也不只是单纯有果味，甚至还有很多超越果味的地方。', 7, '0', 0, '[\"/uploads/1730643606671-55732281-v2-2c3cb90af4de0bb7d4c2bbfb6621de21_200x0.jpg\"]', '2024-11-03 22:20:06');
INSERT INTO `posts` VALUES (16, '有人能给我讲个笑话吗，快坚持不住了?', '去年在家二战考研，差三分以失败告终，今年参加免面试的事业单位笔试（录取笔试第一），考第二，去面试政府见习生，两千块的岗来了两百个人，又失败了，找工作投简历，因为gap一年，根本找不到，好像做什么都是差一点。', 7, '0', 0, '[\"/uploads/1730643660614-921359882-v2-117812b48d9717abe7195a2c000283cc_200x0.jpg\"]', '2024-11-03 22:21:00');
INSERT INTO `posts` VALUES (17, '独立开发者都使用了哪些技术栈？', '国外技术栈：\r\n\r\nNextJS、TailWindCss、MongoDb、Stripe一条龙。\r\n国内技术栈：\r\n\r\nNextJS、TailWindCss、MongoDb、微信支付一条龙。', 7, '0', 0, '[]', '2024-11-03 22:22:30');
INSERT INTO `posts` VALUES (18, '前端高级开发需要知道的JavaScript 单行代码', '1. 不使用临时变量来交换变量的值\r\n例如我们想要将 a 于 b 的值交换\r\n\r\nlet a = 1, b = 2;\r\n\r\n// 交换值\r\n[a, b] = [b, a];', 7, '0', 0, '[\"/uploads/1730643879633-633475218-v2-7bc1ef2c523b6a30ded1ad7779505e96_1440w.jpg\"]', '2024-11-03 22:24:39');
INSERT INTO `posts` VALUES (19, 'HTML怎么防止用户复制？', '谷歌内核浏览器为用户方便的提供了动态的禁用JS功能，用户在禁止复制的页面按F12然后按F1，然后勾选“Disabled JavaScript”就可以任意复制了，复制完成后取消勾选，网页功能恢复正常。问题就是只要勾选了这个选项，JS全部功能都失效。', 7, '0', 0, '[]', '2024-11-03 22:25:20');
INSERT INTO `posts` VALUES (20, '有没有一张图片让你明白了什么叫杀气？', 'rt，很好奇杀气到底怎样练成的', 7, '0', 0, '[]', '2024-11-03 22:25:43');
INSERT INTO `posts` VALUES (21, '前端是不是快没了？', '美团和去哪的网页版都没了\r\n\r\nc站网页版的流量占比也就3%\r\n\r\n你猜前端还剩下什么？\r\n\r\n后台管理系统：到', 7, '0', 0, '[]', '2024-11-03 22:26:01');
INSERT INTO `posts` VALUES (22, '什么，你连一个Node.js脚本都不会写！！！', '有些人可能会误解 Node.js 脚本，认为它是用 Node.js 编写的。他们可能会觉得如果不懂 Node.js 的语法就无法编写 Node.js 脚本，感觉会写 Node.js 脚本就很神秘。实际上，Node.js 脚本只是在 Node.js 环境中运行的 JavaScript 脚本而已。', 7, '0', 0, '[]', '2024-11-03 22:26:38');
INSERT INTO `posts` VALUES (23, '为什么说西医让你明明白白的死？', '在网上流传一句话，中医让你稀里糊涂的活，现代医学让你明明白白的死，对于这句很疑惑，对于活和死的理解有些头大', 7, '0', 0, '[]', '2024-11-03 22:27:31');
INSERT INTO `posts` VALUES (24, '美国会不会重启F22生产线？', '还“重启”生产线……', 7, '0', 0, '[\"/uploads/1730644090753-947676507-v2-0a7e72abd98edb297b11c3ab6bfeed68_720w.webp\"]', '2024-11-03 22:28:10');
INSERT INTO `posts` VALUES (25, '什么叫洗钱？', '能够举例说明么？', 7, '0', 0, '[]', '2024-11-03 22:28:33');
INSERT INTO `posts` VALUES (26, 'Vue明明学习成本很高，为什么还要宣称门槛低？', '我们是一家金融公司，招聘要求最低211。我们领导说Vue太难了，学习成本很高。', 7, '0', 0, '[]', '2024-11-03 22:28:54');
INSERT INTO `posts` VALUES (27, '钱学森弹道为什么只有中国能掌握？', '话说现在钱学森弹道也算是公开了原理，但是为啥还是只有中国在应用？别的国家不去尝试么？\r\n\r\n\r\n', 7, '0', 0, '[]', '2024-11-03 22:29:18');
INSERT INTO `posts` VALUES (28, '前端真的已经死了嘛?', '初级找前端工作全都是已读不回', 7, '0', 0, '[]', '2024-11-03 22:29:52');
INSERT INTO `posts` VALUES (29, '美国要是把中国买的美国国债全部冻结，或者赖账，中国怎么办？', '兔子一大早看到新闻：鹰酱冻结了兔子美债。\r\n\r\n兔子立刻从床上跳了起来问部下：卧底成功了？\r\n\r\n部下：不是卧底干的，好像是他们自己这么做的。\r\n\r\n兔子：有此卧龙凤雏，何愁天下不定！', 7, '0', 0, '[]', '2024-11-03 22:30:08');
INSERT INTO `posts` VALUES (30, '前端部署真的简单么?', '首先，通过脚手架提供的命令npm run build打包前端代码，生成dist文件夹；最后，将dist文件夹丢给后台开发人员放在他们的工程里面，随后台一起部署；现在普遍是前后端分开部署，因此，利用nginx起一个web服务器，将dist文件夹放到指定的路径下，配置下nginx访问路径，对于请求接口使用proxy_pass进行转发，解决跨域的问题。更加高端一点的操作，是利用CI/CD + Docker进行自动化部署。进行到这里，是不是觉得还是很简单的。别急，进阶一下试试~', 7, '0', 0, '[\"/uploads/1730644263619-96551094-v2-4447a05fa84ccfec202fef5ff67d4ac3_1440w.png\"]', '2024-11-03 22:31:03');
INSERT INTO `posts` VALUES (31, '为什么 JavaScript 在国外逐渐用于前端+后端开发，而国内还是只用它做前端？', '在美留学生一枚，跟几个梦里学长聊了，他们普遍认为 Java 现在逐渐开始走下坡路，大部分国外的开发者都开始使用 NodeJS 写后端。一些 youtube 教程里的学习路线在介绍后端框架的时候 Spring 甚至没有出现过。他们最主流的技术栈为MERN (MongoDB, Express, React, Node)，与国内的Spring+Vue+MYSQL完全不一样。国内外差异现在这么大了吗', 7, '0', 0, '[]', '2024-11-03 22:31:34');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `userid` int(255) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 1, 'ChatGPT 上线搜索功能');
INSERT INTO `record` VALUES (2, 1, '大学生毕业做保洁第一个月收入 8 千');
INSERT INTO `record` VALUES (3, 1, 'OpenAI 收入来源揭秘');
INSERT INTO `record` VALUES (4, 1, '520乌梅子酱玫瑰花束');
INSERT INTO `record` VALUES (5, 1, '雷军发布纽北纪录片');
INSERT INTO `record` VALUES (6, 1, 'GIf动图中的FPS是什么意思？');
INSERT INTO `record` VALUES (7, 1, '特朗普与哈里斯决战摇摆州');
INSERT INTO `record` VALUES (8, 1, '装修宿舍有哪些经济实惠的方法？');
INSERT INTO `record` VALUES (9, 1, '毕设材料没交齐能答辩吗？');
INSERT INTO `record` VALUES (10, 1, 'FPS游戏推荐');
INSERT INTO `record` VALUES (11, 1, '人工智能计算为何要用AI芯片？');
INSERT INTO `record` VALUES (12, 1, '芯片在制造过程中，需要经历哪些复杂工艺？');
INSERT INTO `record` VALUES (13, 1, '什么都不会去应聘自媒体能做什么');
INSERT INTO `record` VALUES (14, 1, '任正非：今天还不能说华为能活下来');
INSERT INTO `record` VALUES (15, 1, '事业单位编制考试一般几天出成绩');
INSERT INTO `record` VALUES (16, 1, '微信删除的文件在哪里找回');
INSERT INTO `record` VALUES (17, 1, '现货市场与期货市场有何区别？');
INSERT INTO `record` VALUES (18, 1, '如何将旧手机变成智能家居控制器？');
INSERT INTO `record` VALUES (19, 1, '新办的手机卡多久能激活银行卡');
INSERT INTO `record` VALUES (20, 1, '职场办公必备的软件有哪些？');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `verification_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone_number`(`phone_number`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '15132510000', '伊人空空', 'alice@example.com', 'password123', NULL, '2024-10-30 12:48:34');
INSERT INTO `users` VALUES (2, '15132520000', '秋天是倒放的冬天', 'bob@example.com', 'password456', NULL, '2024-10-30 12:48:34');
INSERT INTO `users` VALUES (3, '15132530000', '夏天雨', 'charlie@example.com', 'password789', NULL, '2024-10-30 12:48:34');
INSERT INTO `users` VALUES (4, '15132540000', 'yihe', 'david@example.com', 'passwordabc', NULL, '2024-10-30 12:48:34');
INSERT INTO `users` VALUES (5, '15132550000', '星海之星', 'eve@example.com', 'passworddef', NULL, '2024-10-30 12:48:34');
INSERT INTO `users` VALUES (6, '13142059246', NULL, NULL, '123456789', NULL, '2024-10-30 20:14:48');
INSERT INTO `users` VALUES (7, '18144824216', NULL, NULL, '$2a$10$5ONlZnyXp9.VyeQVYHb2y.7hqglybrFW6AmFPudQyrYnh85aqXM9u', NULL, '2024-10-30 23:29:48');

SET FOREIGN_KEY_CHECKS = 1;
