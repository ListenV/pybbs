/*
 Navicat Premium Data Transfer

 Source Server         : 本地连接
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : pybbs

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 29/12/2021 16:51:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL COMMENT '注册时间',
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `admin_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'admin', '$2a$10$0F6RXnrQDF8SsOudYk7uhuWlqq3kjPuPm4UGeDCj0gvO8xj2pbZ4y', '2021-12-25 16:44:14', 1);

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `expire_time` datetime NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `used` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of code
-- ----------------------------

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  INDEX `topic_id`(`topic_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `style` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'MD',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  `comment_id` int(11) NULL DEFAULT NULL,
  `up_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `topic_id`(`topic_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `comment_in_time`(`in_time`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `read` bit(1) NOT NULL DEFAULT b'0',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `topic_id`(`topic_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `target_user_id`(`target_user_id`) USING BTREE,
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `oauth_user`;
CREATE TABLE `oauth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `login` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `bio` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `refresh_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `union_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expires_in` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `oauth_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `value`(`value`) USING BTREE,
  INDEX `permission_pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '首页', 'index', 0);
INSERT INTO `permission` VALUES (2, '话题', 'topic', 0);
INSERT INTO `permission` VALUES (3, '评论', 'comment', 0);
INSERT INTO `permission` VALUES (4, '通知', 'notification', 0);
INSERT INTO `permission` VALUES (5, '用户', 'user', 0);
INSERT INTO `permission` VALUES (6, '验证码', 'code', 0);
INSERT INTO `permission` VALUES (7, '标签', 'tag', 0);
INSERT INTO `permission` VALUES (8, '权限', 'permission', 0);
INSERT INTO `permission` VALUES (9, '系统', 'system', 0);
INSERT INTO `permission` VALUES (10, '后台用户', 'admin_user', 0);
INSERT INTO `permission` VALUES (11, '仪表盘', 'index:index', 1);
INSERT INTO `permission` VALUES (12, '话题列表', 'topic:list', 2);
INSERT INTO `permission` VALUES (13, '话题编辑', 'topic:edit', 2);
INSERT INTO `permission` VALUES (14, '话题删除', 'topic:delete', 2);
INSERT INTO `permission` VALUES (15, '话题加精', 'topic:good', 2);
INSERT INTO `permission` VALUES (16, '话题置顶', 'topic:top', 2);
INSERT INTO `permission` VALUES (17, '评论列表', 'comment:list', 3);
INSERT INTO `permission` VALUES (18, '评论编辑', 'comment:edit', 3);
INSERT INTO `permission` VALUES (19, '评论删除', 'comment:delete', 3);
INSERT INTO `permission` VALUES (20, '通知列表', 'notification:list', 4);
INSERT INTO `permission` VALUES (21, '通知删除', 'notification:delete', 4);
INSERT INTO `permission` VALUES (22, '用户列表', 'user:list', 5);
INSERT INTO `permission` VALUES (23, '用户编辑', 'user:edit', 5);
INSERT INTO `permission` VALUES (24, '用户删除', 'user:delete', 5);
INSERT INTO `permission` VALUES (25, '验证码列表', 'code:list', 6);
INSERT INTO `permission` VALUES (26, '标签列表', 'tag:list', 7);
INSERT INTO `permission` VALUES (27, '标签编辑', 'tag:edit', 7);
INSERT INTO `permission` VALUES (28, '标签删除', 'tag:delete', 7);
INSERT INTO `permission` VALUES (29, '标签同步', 'tag:async', 7);
INSERT INTO `permission` VALUES (30, '权限列表', 'permission:list', 8);
INSERT INTO `permission` VALUES (31, '权限编辑', 'permission:edit', 8);
INSERT INTO `permission` VALUES (32, '权限删除', 'permission:delete', 8);
INSERT INTO `permission` VALUES (33, '角色', 'role', 0);
INSERT INTO `permission` VALUES (34, '日志', 'log', 0);
INSERT INTO `permission` VALUES (35, '角色列表', 'role:list', 33);
INSERT INTO `permission` VALUES (36, '角色编辑', 'role:edit', 33);
INSERT INTO `permission` VALUES (37, '角色删除', 'role:delete', 33);
INSERT INTO `permission` VALUES (38, '系统设置', 'system:edit', 9);
INSERT INTO `permission` VALUES (39, '后台用户列表', 'admin_user:list', 10);
INSERT INTO `permission` VALUES (40, '后台用户编辑', 'admin_user:edit', 10);
INSERT INTO `permission` VALUES (41, '后台用户创建', 'admin_user:add', 10);
INSERT INTO `permission` VALUES (42, '日志列表', 'log:list', 34);
INSERT INTO `permission` VALUES (43, '用户刷新Token', 'user:refresh_token', 5);
INSERT INTO `permission` VALUES (44, '权限添加', 'permission:add', 8);
INSERT INTO `permission` VALUES (45, '索引单个话题', 'topic:index', 2);
INSERT INTO `permission` VALUES (46, '索引全部话题', 'topic:index_all', 2);
INSERT INTO `permission` VALUES (48, '删除索引', 'topic:delete_index', 2);
INSERT INTO `permission` VALUES (49, '删除所有话题索引', 'topic:delete_all_index', 2);
INSERT INTO `permission` VALUES (50, '敏感词', 'sensitive_word', 0);
INSERT INTO `permission` VALUES (51, '敏感词列表', 'sensitive_word:list', 50);
INSERT INTO `permission` VALUES (52, '敏感词添加', 'sensitive_word:add', 50);
INSERT INTO `permission` VALUES (53, '敏感词编辑', 'sensitive_word:edit', 50);
INSERT INTO `permission` VALUES (54, '敏感词删除', 'sensitive_word:delete', 50);
INSERT INTO `permission` VALUES (55, '敏感词导入', 'sensitive_word:import', 50);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (2, '审核员');
INSERT INTO `role` VALUES (1, '超级管理员');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `permission_id`(`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (2, 11);
INSERT INTO `role_permission` VALUES (2, 12);
INSERT INTO `role_permission` VALUES (2, 13);
INSERT INTO `role_permission` VALUES (2, 14);
INSERT INTO `role_permission` VALUES (2, 15);
INSERT INTO `role_permission` VALUES (2, 16);
INSERT INTO `role_permission` VALUES (2, 17);
INSERT INTO `role_permission` VALUES (2, 18);
INSERT INTO `role_permission` VALUES (2, 19);
INSERT INTO `role_permission` VALUES (2, 26);
INSERT INTO `role_permission` VALUES (2, 27);
INSERT INTO `role_permission` VALUES (2, 28);
INSERT INTO `role_permission` VALUES (2, 29);
INSERT INTO `role_permission` VALUES (1, 11);
INSERT INTO `role_permission` VALUES (1, 12);
INSERT INTO `role_permission` VALUES (1, 13);
INSERT INTO `role_permission` VALUES (1, 14);
INSERT INTO `role_permission` VALUES (1, 15);
INSERT INTO `role_permission` VALUES (1, 16);
INSERT INTO `role_permission` VALUES (1, 45);
INSERT INTO `role_permission` VALUES (1, 46);
INSERT INTO `role_permission` VALUES (1, 48);
INSERT INTO `role_permission` VALUES (1, 49);
INSERT INTO `role_permission` VALUES (1, 17);
INSERT INTO `role_permission` VALUES (1, 18);
INSERT INTO `role_permission` VALUES (1, 19);
INSERT INTO `role_permission` VALUES (1, 20);
INSERT INTO `role_permission` VALUES (1, 21);
INSERT INTO `role_permission` VALUES (1, 22);
INSERT INTO `role_permission` VALUES (1, 23);
INSERT INTO `role_permission` VALUES (1, 24);
INSERT INTO `role_permission` VALUES (1, 43);
INSERT INTO `role_permission` VALUES (1, 25);
INSERT INTO `role_permission` VALUES (1, 26);
INSERT INTO `role_permission` VALUES (1, 27);
INSERT INTO `role_permission` VALUES (1, 28);
INSERT INTO `role_permission` VALUES (1, 29);
INSERT INTO `role_permission` VALUES (1, 30);
INSERT INTO `role_permission` VALUES (1, 31);
INSERT INTO `role_permission` VALUES (1, 32);
INSERT INTO `role_permission` VALUES (1, 44);
INSERT INTO `role_permission` VALUES (1, 38);
INSERT INTO `role_permission` VALUES (1, 39);
INSERT INTO `role_permission` VALUES (1, 40);
INSERT INTO `role_permission` VALUES (1, 41);
INSERT INTO `role_permission` VALUES (1, 35);
INSERT INTO `role_permission` VALUES (1, 36);
INSERT INTO `role_permission` VALUES (1, 37);
INSERT INTO `role_permission` VALUES (1, 42);
INSERT INTO `role_permission` VALUES (1, 51);
INSERT INTO `role_permission` VALUES (1, 52);
INSERT INTO `role_permission` VALUES (1, 53);
INSERT INTO `role_permission` VALUES (1, 54);
INSERT INTO `role_permission` VALUES (1, 55);

-- ----------------------------
-- Table structure for sensitive_word
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_word`;
CREATE TABLE `sensitive_word`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '敏感词',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sensitive_word`(`word`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensitive_word
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `option` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reboot` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `system_config_key`(`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'admin_remember_me_max_age', '30', '登录后台记住我功能记住时间，单位：天', 23, 'number', NULL, 1);
INSERT INTO `system_config` VALUES (2, 'base_url', 'http://localhost:8080', '网站部署后访问的域名，注意这个后面没有 \"/\"', 23, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (3, 'comment_layer', '1', '评论盖楼形式显示', 23, 'radio', NULL, 0);
INSERT INTO `system_config` VALUES (4, 'cookie_domain', 'localhost', '存cookie时用到的域名，要与网站部署后访问的域名一致', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (5, 'cookie_max_age', '604800', 'cookie有效期，单位秒，默认1周', 23, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (6, 'cookie_name', 'user_token', '存cookie时用到的名称', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (7, 'create_comment_score', '5', '发布评论奖励的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (8, 'create_topic_score', '10', '创建话题奖励的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (9, 'delete_comment_score', '5', '删除评论要被扣除的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (10, 'delete_topic_score', '10', '删除话题要被扣除的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (11, 'intro', '<h5>属于Java语言的bbs</h5><p>在这里，您可以提问，回答，分享，诉说，这是个属于Java程序员的社区，欢迎您的加入！</p>', '站点介绍', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (12, 'mail_host', 'smtp.qq.com', '邮箱的smtp服务器地址', 24, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (13, 'mail_password', 'gcyhpoupowrsbdjd', '发送邮件的邮箱密码', 24, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (14, 'mail_username', 'sky03.sen@qq.com', '发送邮件的邮箱地址', 24, 'email', NULL, 0);
INSERT INTO `system_config` VALUES (15, 'name', '朋也社区', '站点名称', 23, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (16, 'page_size', '20', '分页每页条数', 23, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (17, 'websocket', '0', '是否开启websocket功能', 45, 'radio', NULL, 1);
INSERT INTO `system_config` VALUES (18, 'static_url', 'http://localhost:8080/static/upload/', '静态文件访问地址，主要用于上传图片的访问，注意最后有个\"/\"', 25, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (19, 'up_comment_score', '3', '点赞评论奖励评论作者的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (20, 'upload_image_size_limit', '2', '上传头像文件大小，单位MB，默认2MB', 25, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (21, 'upload_path', '/Users/hh/git/github/pybbs/static/upload/', '上传文件的路径，注意最后有个\"/\"', 25, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (22, 'up_topic_score', '3', '点赞话题奖励话题作者的积分', 26, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (23, NULL, NULL, '基础配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (24, NULL, NULL, '邮箱配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (25, NULL, NULL, '上传配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (26, NULL, NULL, '积分配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (27, NULL, NULL, 'Redis配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (29, 'redis_host', '127.0.0.1', 'redis服务host地址', 27, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (30, 'redis_port', '6379', 'redis服务端口（默认: 6379）', 27, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (31, 'redis_password', '', 'redis服务密码', 27, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (32, 'redis_timeout', '2000', '网站连接redis服务超时时间，单位毫秒', 27, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (33, 'redis_database', '0', '网站连接redis服务的哪个数据库，默认0号数据库，取值范围0-15', 27, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (35, NULL, NULL, 'Elasticsearch配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (36, 'elasticsearch_host', '', 'elasticsearch服务的地址', 35, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (37, 'elasticsearch_port', '', 'elasticsearch服务的http端口', 35, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (38, 'elasticsearch_index', '', '索引的名字', 35, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (40, NULL, NULL, 'Github配置', 0, '', NULL, 0);
INSERT INTO `system_config` VALUES (41, 'oauth_github_client_id', '', 'Github登录配置项ClientId', 40, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (42, 'oauth_github_client_secret', '', 'Github登录配置项ClientSecret', 40, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (43, 'oauth_github_callback_url', '', 'Github登录配置项回调地址', 40, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (44, 'topic_view_increase_interval', '600', '同一个用户浏览同一个话题多长时间算一次浏览量，默认10分钟，单位秒（只有当配置了redis才会生效）', 23, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (45, NULL, NULL, 'WebSocket', 0, '', NULL, 0);
INSERT INTO `system_config` VALUES (46, 'websocket_url', '', 'websocket服务的连接地址', 45, 'text', NULL, 1);
INSERT INTO `system_config` VALUES (48, 'theme', 'default', '系统主题', 23, 'select', 'default', 0);
INSERT INTO `system_config` VALUES (49, NULL, NULL, '短信配置', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (50, 'sms_access_key_id', '', '创建短信连接的key', 49, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (51, 'sms_secret', '', '创建短信连接的密钥', 49, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (52, 'sms_sign_name', '', '短信签名，在阿里云申请的签名', 49, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (53, 'sms_template_code', '', '短信模板Code，在阿里云申请的模板Code', 49, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (54, NULL, NULL, 'WeChat配置', 0, '', NULL, 0);
INSERT INTO `system_config` VALUES (55, 'oauth_wechat_client_id', '', 'WeChat登录配置项AppId', 54, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (56, 'oauth_wechat_client_secret', '', 'WeChat登录配置项AppSecret', 54, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (57, 'oauth_wechat_callback_url', '', 'WeChat登录配置项回调地址', 54, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (58, 'sms_region_id', '', '短信服务所在区域 例如: cn-hangzhou', 49, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (59, 'upload_video_size_limit', '20', '上传视频文件大小，单位MB，默认20MB', 25, 'number', NULL, 0);
INSERT INTO `system_config` VALUES (60, NULL, NULL, 'Gitee配置', 0, '', NULL, 0);
INSERT INTO `system_config` VALUES (61, 'oauth_gitee_client_id', '', 'Gitee登录配置项AppId', 60, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (62, 'oauth_gitee_client_secret', '', 'Gitee登录配置项AppSecret', 60, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (63, 'oauth_gitee_callback_url', '', 'Gitee登录配置项回调地址', 60, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (64, NULL, NULL, '新浪微博配置', 0, '', NULL, 0);
INSERT INTO `system_config` VALUES (65, 'oauth_weibo_client_id', '', '新浪微博登录配置项AppId', 64, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (66, 'oauth_weibo_client_secret', '', '新浪微博登录配置项AppSecret', 64, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (67, 'oauth_weibo_callback_url', '', '新浪微博登录配置项回调地址', 64, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (68, NULL, NULL, '开源中国配置', 0, '', NULL, 0);
INSERT INTO `system_config` VALUES (69, 'oauth_oschina_client_id', '', '开源中国登录配置项AppId', 68, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (70, 'oauth_oschina_client_secret', '', '开源中国登录配置项AppSecret', 68, 'password', NULL, 0);
INSERT INTO `system_config` VALUES (71, 'oauth_oschina_callback_url', '', '开源中国登录配置项回调地址', 68, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (72, 'user_need_active', '1', '新注册用户需要激活', 23, 'radio', NULL, 0);
INSERT INTO `system_config` VALUES (73, 'content_style', 'MD', '发帖或者回复的输入框语法风格', 23, 'select', 'RICH,MD', 1);
INSERT INTO `system_config` VALUES (75, NULL, '', '云存储', 0, NULL, NULL, 0);
INSERT INTO `system_config` VALUES (76, 'cloud_storage_platform', 'LOCAL', '云存储平台', 75, 'select', 'LOCAL,QINIU,OSS', 0);
INSERT INTO `system_config` VALUES (77, 'oss_key', '', '阿里云存储key', 75, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (78, 'oss_secret', '', '阿里云存储secret', 75, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (79, 'oss_bucket', '', '阿里云存储bucket', 75, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (80, 'oss_end_point', 'http://oss-cn-hangzhou.aliyuncs.com', '阿里云存储上传地址（请根据文档来设置）', 75, 'url', NULL, 0);
INSERT INTO `system_config` VALUES (81, 'qiniu_key', '', '七牛云存储key', 75, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (82, 'qiniu_secret', '', '七牛云存储secret', 75, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (83, 'qiniu_bucket', '', '七牛云存储bucket', 75, 'text', NULL, 0);
INSERT INTO `system_config` VALUES (84, 'qiniu_domain', '', '七牛云存储访问域名(最后没有/)', 75, 'url', NULL, 0);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `topic_count` int(11) NOT NULL DEFAULT 0,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `tag_in_time`(`in_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `in_time` datetime NOT NULL,
  `modify_time` datetime NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `style` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'MD',
  `comment_count` int(11) NOT NULL DEFAULT 0,
  `collect_count` int(11) NOT NULL DEFAULT 0,
  `view` int(11) NOT NULL DEFAULT 0,
  `top` bit(1) NOT NULL DEFAULT b'0',
  `good` bit(1) NOT NULL DEFAULT b'0',
  `up_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `topic_in_time`(`in_time`) USING BTREE,
  CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES (1, '我是标题', '我是内容\n\n- 无序列表\n- 无序列表\n  - 子无序列表1', '2021-12-29 16:12:38', NULL, 1, 'MD', 0, 0, 3, b'0', b'0', NULL);

-- ----------------------------
-- Table structure for topic_tag
-- ----------------------------
DROP TABLE IF EXISTS `topic_tag`;
CREATE TABLE `topic_tag`  (
  `tag_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  INDEX `topic_id`(`topic_id`) USING BTREE,
  CONSTRAINT `topic_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `topic_tag_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic_tag
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `avatar` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bio` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `in_time` datetime NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `telegram_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email_notification` bit(1) NOT NULL DEFAULT b'0',
  `active` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `token`(`token`) USING BTREE,
  INDEX `user_email`(`email`) USING BTREE,
  INDEX `user_in_time`(`in_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'sky03', '$2a$10$nQ9Om2qswvO0c74M/Bo.y.iW1V/V65jsSSVLzEQTmB4VUBUfKjTmm', 'http://localhost:8080/static/upload/avatar/sky03/avatar.png', 'sky03.sen@qq.com', NULL, '我是主页', '我是个人简介', 10, '2021-12-29 15:56:11', 'd071dd4e-b613-43af-9285-cee354916212', '', b'0', b'1');

SET FOREIGN_KEY_CHECKS = 1;
