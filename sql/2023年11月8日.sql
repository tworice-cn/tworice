/*
 Navicat Premium Data Transfer

 Source Server         : 本地MySQL8
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : tworice_admin

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 08/11/2023 12:36:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_department
-- ----------------------------
DROP TABLE IF EXISTS `system_department`;
CREATE TABLE `system_department`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `department_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_name`(`department_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_department
-- ----------------------------

-- ----------------------------
-- Table structure for system_deploy_log
-- ----------------------------
DROP TABLE IF EXISTS `system_deploy_log`;
CREATE TABLE `system_deploy_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人',
  `state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标用户编号',
  `deleted` tinyint NULL DEFAULT 0,
  `deploy_id` int NULL DEFAULT NULL COMMENT '部门编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '人事调动记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_deploy_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_dist
-- ----------------------------
DROP TABLE IF EXISTS `system_dist`;
CREATE TABLE `system_dist`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典名称',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典描述',
  `logo` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典标识',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_dist
-- ----------------------------
INSERT INTO `system_dist` VALUES (1, 1664092965734, '性别', '性别选项', 'SYSTEM_SEX', NULL, NULL, 0);
INSERT INTO `system_dist` VALUES (2, 1664097012604, '天气', '天气字典', 'SYSTEM_WEATHER', NULL, NULL, 0);
INSERT INTO `system_dist` VALUES (6, 1681227558864, '调动状态', '调动状态', 'RSDDZT', NULL, NULL, 0);

-- ----------------------------
-- Table structure for system_dist_value
-- ----------------------------
DROP TABLE IF EXISTS `system_dist_value`;
CREATE TABLE `system_dist_value`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `dist` int NULL DEFAULT NULL COMMENT '字典编号',
  `content` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典内容',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_dist_value
-- ----------------------------
INSERT INTO `system_dist_value` VALUES (1, 1664096943799, 1, '男', '性别男');
INSERT INTO `system_dist_value` VALUES (2, 1664097610129, 1, '女', '性别女');
INSERT INTO `system_dist_value` VALUES (3, 1664097743834, 2, '晴', '天气晴');
INSERT INTO `system_dist_value` VALUES (4, 1664097775454, 2, '阴', '天气阴');
INSERT INTO `system_dist_value` VALUES (5, 1664097842757, 2, '小雨', '天气小雨');
INSERT INTO `system_dist_value` VALUES (6, 1664097987000, 2, '大雨', '天气大雨');
INSERT INTO `system_dist_value` VALUES (7, 1664098087375, 2, '大风', '天气大风');
INSERT INTO `system_dist_value` VALUES (11, 1664098293463, 1, '未知', '性别未知');

-- ----------------------------
-- Table structure for system_file
-- ----------------------------
DROP TABLE IF EXISTS `system_file`;
CREATE TABLE `system_file`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL,
  `update_time` bigint NULL DEFAULT NULL,
  `path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` tinyint NULL DEFAULT 0,
  `type` int NULL DEFAULT 1 COMMENT '文件类型',
  `parent` int NULL DEFAULT NULL COMMENT '所属父目录',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `share` int NULL DEFAULT 0 COMMENT '1-分享 0-不分享',
  `level` int NULL DEFAULT 2,
  `pwd` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_file
-- ----------------------------
INSERT INTO `system_file` VALUES (1, NULL, NULL, '/', '根目录', NULL, 0, 2, NULL, NULL, 0, 2, NULL);
INSERT INTO `system_file` VALUES (2, 1676032532190, 1676032532190, '/upload/c6af713394834cfcaa18d3759f21f0ae.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (3, 1676032705749, 1676032705749, '/upload/b2cd86a736d749a6a6eacf93c9917979.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (4, 1676032918699, 1676032918699, '/upload/4cfb1c0523424ce8b5f147bd33240aa9.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (5, 1676033736482, 1676033736482, '/upload/c9f124b360d3405583745762c3c1dae0.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (6, 1676033769369, 1676033769369, '/upload/80fe1368130c45aaa732d25a92233624.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (7, 1676037233859, 1676037233859, '/upload/688476f686fb4a0d9ca535ab2d6a69cb.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (8, 1676038200424, 1676040651600, NULL, '测试文件夹1', '1', 0, 2, 1, NULL, 0, 2, NULL);
INSERT INTO `system_file` VALUES (9, 1676040265856, 1676040265856, '/upload/b9e16a80ebe94a41bb5fea861c762a99.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 1, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (10, 1676040363281, 1676040363281, '/upload/9daf507c1ee848e8816074dbb380af5f.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 8, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (11, 1676040923353, 1676040923353, '/upload/89498ec2af7644a29ffafe1806ef3dd6.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 8, 11601, 0, 2, NULL);
INSERT INTO `system_file` VALUES (12, 1676080527906, 1676080527905, NULL, '测试', '1', 0, 2, 8, NULL, 0, 2, NULL);
INSERT INTO `system_file` VALUES (13, 1676083505498, 1677667519027, '/upload/51c2e42e93434cbd887323ddd352f925.pdf', '机房巡检机器人的设计要求及功能_张星海.pdf', '1', 0, 1, 1, 568870, 1, 2, NULL);

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS `system_login_log`;
CREATE TABLE `system_login_log`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `login_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录账号',
  `pass_word` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录密码',
  `ip_addr` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `active` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '登录操作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统登录日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_login_log
-- ----------------------------
INSERT INTO `system_login_log` VALUES ('047c7d56ce5f4dd99cb04476c53dd014', 1697720263253, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');
INSERT INTO `system_login_log` VALUES ('1611b4e6002c43078ce976c2d83aea3b', 1697460398480, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');
INSERT INTO `system_login_log` VALUES ('18d1adb7daaa469f907779d8d5939090', 1697949012508, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');
INSERT INTO `system_login_log` VALUES ('245f21d5db18412eaeb84cc46ffe0d22', 1697457703776, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');
INSERT INTO `system_login_log` VALUES ('245f6c11bb574e00bb1ca755a8685a78', 1697961425953, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('341ba3a89c574bebb55606d6a1aa4047', 1697967384977, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('3b2d08fd3701463ca0b21c2c012da694', 1697974106395, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('3c3ae7ef47db4186ad909707e28f7bf5', 1697965650063, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('3d71ec9604ff46bcb094893b0a815526', 1699158223155, 'admin', '12345678F', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('42f08f0aa746408884cebbaf98244f26', 1699112424675, 'admin', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('43d0b97e29124753862d00a5caabdfe6', 1699074250300, 'admin', '123456', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('4e394a72b9814e4080306b9fc3a06465', 1699074314930, 'admin', 'admin', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('4f1638d5ea734fbbafb3c93a15313140', 1697973456729, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('5ea910ea2f43442f9ba1886081aa2e62', 1699161159448, 'admin', '12345678F', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('64210a4319fc43b2975320d9f649852a', 1699097230929, 'admin', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('796d0de77a2841c5a58f984689a6d590', 1699075019820, 'admin', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('7c8bf04e6eea40bd955c3aa0b1f651ca', 1697974166674, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('91579efdbc48429cac2f84888223a6c4', 1697965085148, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('ac810d2d6e8d48a691be58784e73e1a9', 1699074506911, 'admin', 'admin', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('ae186f7fd8164027b3eefc2bf8fe8dbf', 1699073312152, NULL, 'root', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('b4444139f4f945709783fe61145a0dfd', 1699161181680, 'admin', '2', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('b55b533587314292a18d066864febc3e', 1697939785511, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');
INSERT INTO `system_login_log` VALUES ('b7451850b75542fcb1d23372a9e76711', 1699075181176, 'admin', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('c29f213eff3a4d758bfccd7cf1760532', 1697719263158, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');
INSERT INTO `system_login_log` VALUES ('c331ff3023bc42eca59df99b090a9a5b', 1697974083882, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61]');
INSERT INTO `system_login_log` VALUES ('dac1f5a19e5545d4a17c9fc7e7694daa', 1699074701048, 'admin', '123456', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('e3494397061d4d4b9d8805c2e50729ab', 1699074228717, 'admin', '123456', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('e56bf6aa95d7456b85cb517124b41800', 1699074909826, 'admin', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76]');
INSERT INTO `system_login_log` VALUES ('ec95a6fac8fe45099985c4d2afc6d39d', 1697724518165, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:118.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.46]');

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `top` int NULL DEFAULT NULL COMMENT '置顶状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_notice
-- ----------------------------
INSERT INTO `system_notice` VALUES ('57fdf84621dc4ea9950daa5371f46b87', 1699276458007, '测试', '<p>这是初始化内容</p>', 1, '1', 1699276458007, 1);
INSERT INTO `system_notice` VALUES ('9ece789aad954d40b5c3ba0d91748d27', 1698590533711, '1222222333', '<p>这是初始化内容</p>', 0, '1', 1698590533711, 1);
INSERT INTO `system_notice` VALUES ('a3ac8b52c55c4be2875cdf8828f03f9c', 1643538516936, '测试', '测试公告内容', 1, '1', 1666846785677, 1);
INSERT INTO `system_notice` VALUES ('caf654afd61f4c15bee65057af15da90', 1675091436660, '测试112233', '<p>这是初始化内容</p>', 0, '1', 1675091436660, 1);
INSERT INTO `system_notice` VALUES ('e7bf3bd8117f44fd9f9741cac47c095a', 1643538764273, '二饭管理系统', '<p>测试测试111</p><p><br></p><p>测试测试<img src=\"http://127.0.0.1:88//upload/2bac2ebdb87d4f2799be2c8895ba7935.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', 1, '1', 1673103279919, 0);

-- ----------------------------
-- Table structure for system_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `system_operation_log`;
CREATE TABLE `system_operation_log`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `active` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作内容',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `table_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作表',
  `target_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作数据',
  `ip_addr` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_operation_log
-- ----------------------------
INSERT INTO `system_operation_log` VALUES ('0965518358ec40fb8669114d30266acd', 1699362549298, '通知公告-通过ID删除通知', '1', 'system_notice', '[\"57fdf84621dc4ea9950daa5371f46b87\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('10c0133b9ae24946bfb72decf5d3c55c', 1699160969441, '【已恢复】通知公告-通过ID删除通知', '4', NULL, '[17]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('1a44d7d0e66448899cdd91202e5ab712', 1699160398585, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('2111471af721422dbc89a7af3a9e9901', 1698937597848, '【已恢复】通知公告-通过ID删除通知', 'undefined', NULL, '[\"9ece789aad954d40b5c3ba0d91748d27\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('2550f49cbc9f49e1a2f5ea97df4b315c', 1699112436362, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('2914ffc1cb5c4fb9afb627fa6e070005', 1699161537771, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('36fd20f7d4414719b2229775b215478f', 1699158258213, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('53a9e03a6ce14491b7cb5ddfa43aa1f3', 1699163761590, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('5884b88f462f4848b06bef800ea3e470', 1698937646445, '【已恢复】通知公告-通过ID删除通知', 'undefined', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('5fd526ac72a24c418bc653f6fb0d575c', 1699158252516, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('606e395363e54484a6bcea32010cfe53', 1699160948899, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('66821af213b543e28deccfe4488f77cd', 1699161565506, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('67aa1181f53e449ba555af222de6ba08', 1699161452129, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('6ce5fd991064419f9b0736e844b469bd', 1699163771917, '【已恢复】通知公告-通过ID删除通知', '1', NULL, '[\"3a791d8a86d24d389b5c7f2722db187d\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('7269ab8f6262477ba58e76ec111855cc', 1699159827279, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('7685b43a3a124674beefea5ee8260dcb', 1699161493270, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('7ceae25f37654467a26bca4cb8165c63', 1699074666081, '【已恢复】通知公告-通过ID删除通知', 'undefined', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('7e0f435bb2784828a1705254d204aacd', 1699096690730, '【已恢复】通知公告-通过ID删除通知', 'undefined', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('7f04506cd4104925beb4fcbd73d00b7d', 1699160585307, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('84a0fed30f4a4f4c94692be18e9f3b2d', 1699158502433, '【已恢复】通知公告-通过ID删除通知', '4', NULL, '[\"fc3e4e7983c5b07d81ee6ad2baa2ab1f\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('92d9e706c2da480ab5bfc41611456fb9', 1699160413485, '【已恢复】通知公告-通过ID删除通知', '4', NULL, '[16]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('93c66c5e76e44644ae0779daa333385a', 1699160380340, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('a7e0a82ae99d408982fa60fb93ee3f20', 1699276466204, '【已恢复】通知公告-通过ID删除通知', '1', NULL, '[\"57fdf84621dc4ea9950daa5371f46b87\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('a9b9726adc6648f79245e47a2543c1bf', 1699158338963, '【已恢复】通知公告-通过ID删除通知', '4', NULL, '[\"b5b7678e1e13c52c0b2312c463cf64c1\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('b7edc58d4de5495e90c205fffccbccd8', 1699161559898, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('c0e35de919a141c68c77c3f8f4ae3ed5', 1699158209567, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('cfc5addc01bc45b991de5df8db49e5e0', 1699161008968, '【已恢复】通知公告-通过ID删除通知', '4', NULL, '[18]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('d47c1d4c69b84e40954144920ee50c81', 1699362447563, '【已恢复】通知公告-通过ID删除通知', '1', NULL, '[\"57fdf84621dc4ea9950daa5371f46b87\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('d79ed217e9614d4e9ffed980391664cb', 1699074558189, '【已恢复】通知公告-通过ID删除通知', 'undefined', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('dce4b6ae631f41fcabac9cf9ffb89546', 1699276457998, '【已恢复】通知公告-通过ID删除通知', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('e0e891cf72fe40589aa389079bab929c', 1699158495901, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('e1108b7c400b4ebaaa9875367d4bfabc', 1699362421733, '【已恢复】通知公告-通过ID删除通知', '1', NULL, '[\"57fdf84621dc4ea9950daa5371f46b87\"]', '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('eb1b7ad334b34451a3ba247633c010d3', 1699112447636, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');
INSERT INTO `system_operation_log` VALUES ('ed3b884c55fd4fcba446247ef16c47e4', 1699160925281, '【已恢复】通知公告-通过ID删除通知', '4', NULL, NULL, '127.0.0.1');

-- ----------------------------
-- Table structure for system_resources
-- ----------------------------
DROP TABLE IF EXISTS `system_resources`;
CREATE TABLE `system_resources`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资源路径',
  `pid` int NULL DEFAULT NULL COMMENT '上级菜单',
  `sort` int NULL DEFAULT NULL COMMENT '菜单排序',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `type` int NULL DEFAULT NULL COMMENT '菜单类型',
  `path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单路由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_resources
-- ----------------------------
INSERT INTO `system_resources` VALUES (1, '系统管理', '/system', 0, 1, 'el-icon-setting', 1, NULL);
INSERT INTO `system_resources` VALUES (2, '信息管理', '/info', 0, 2, 'el-icon-s-data', 1, NULL);
INSERT INTO `system_resources` VALUES (3, '公告管理', '/notice', 0, 3, 'el-icon-chat-line-round', 1, NULL);
INSERT INTO `system_resources` VALUES (4, '角色管理', '/system/role', 1, 11, 'null', 2, '/admin/system/role');
INSERT INTO `system_resources` VALUES (5, '资源菜单', '/system/resource', 1, 12, 'null', 2, '');
INSERT INTO `system_resources` VALUES (23, '公告信息', '/notice/notice', 3, 31, '', 2, '/admin/notice');
INSERT INTO `system_resources` VALUES (26, '人员管理', '/system/admin', 1, 14, '', 2, '/admin/admin');
INSERT INTO `system_resources` VALUES (29, '日志管理', '/log', 0, 4, 'el-icon-document', 1, NULL);
INSERT INTO `system_resources` VALUES (30, '操作日志', '/log/log', 29, 41, '', 2, '/admin/log/adminList');
INSERT INTO `system_resources` VALUES (31, '登录日志', '/log/loginLog', 29, 42, '', 2, '/admin/log/loginList');
INSERT INTO `system_resources` VALUES (32, '系统工具', '/tools', 0, 5, 'el-icon-box', 1, NULL);
INSERT INTO `system_resources` VALUES (33, '系统接口', '/tools/doc', 32, 51, '', 2, NULL);
INSERT INTO `system_resources` VALUES (34, '系统监控', '/tools/monitor', 32, 52, '', 2, '/admin/system/systemInfo');
INSERT INTO `system_resources` VALUES (35, '代码生成', '/tools/codeGeneration', 32, 55, '', 2, NULL);
INSERT INTO `system_resources` VALUES (65, '开发示例', '/dev', 0, 6, 'el-icon-s-cooperation', 1, NULL);
INSERT INTO `system_resources` VALUES (66, '富文本组件', '/dev/editor', 65, 61, '', 2, NULL);
INSERT INTO `system_resources` VALUES (67, '跳转页面', '/dev/jump', 65, 62, '', 2, NULL);
INSERT INTO `system_resources` VALUES (75, '文件上传', '/dev/upload', 65, 63, '', 2, NULL);
INSERT INTO `system_resources` VALUES (78, '在线账户', '/tools/online', 32, 56, '', 2, '/admin/system/online');
INSERT INTO `system_resources` VALUES (80, '版本日志', '/log/versionLog', 29, 43, '', 2, NULL);
INSERT INTO `system_resources` VALUES (83, '字典管理', '/tools/dist', 32, 50, '', 2, '');
INSERT INTO `system_resources` VALUES (94, '支付示例', '/dev/alipay/10086', 65, 4, '', 2, '');
INSERT INTO `system_resources` VALUES (95, '访问白名单', '/tools/whiteList', 32, 57, '', 2, '');
INSERT INTO `system_resources` VALUES (96, 'AES加密', '/dev/aes', 65, 97, '', 2, '');
INSERT INTO `system_resources` VALUES (97, '我的文件', '/admin/file', 0, 9, 'el-icon-folder', 2, '');
INSERT INTO `system_resources` VALUES (99, 'OCR识别', '/dev/ocr', 65, 98, '', 2, '');
INSERT INTO `system_resources` VALUES (101, '首页', '/admin/home', 0, 0, 'el-icon-s-home', 2, '');
INSERT INTO `system_resources` VALUES (102, '应用监控', '/tools/admin', 32, 58, '', 2, '');
INSERT INTO `system_resources` VALUES (103, '部门管理', '/system/department', 1, 24, '', 2, '');

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `deleted` tinyint NULL DEFAULT 0,
  `create_time` bigint NULL DEFAULT NULL,
  `update_time` bigint NULL DEFAULT NULL,
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_name`(`role_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `system_role` VALUES (1, '超级管理员', 1, NULL, NULL, NULL);
INSERT INTO `system_role` VALUES (2, '一级管理员', 0, NULL, NULL, NULL);
INSERT INTO `system_role` VALUES (3, '二级管理员', 0, NULL, NULL, NULL);
INSERT INTO `system_role` VALUES (4, '用户', 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for system_role_resources
-- ----------------------------
DROP TABLE IF EXISTS `system_role_resources`;
CREATE TABLE `system_role_resources`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NULL DEFAULT NULL COMMENT '角色编号',
  `resource_id` int NULL DEFAULT NULL COMMENT '菜单编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17158155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色菜单关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_role_resources
-- ----------------------------
INSERT INTO `system_role_resources` VALUES (-1090138111, 1, 23);
INSERT INTO `system_role_resources` VALUES (67, 2, 23);
INSERT INTO `system_role_resources` VALUES (68, 2, 26);
INSERT INTO `system_role_resources` VALUES (69, 2, 30);
INSERT INTO `system_role_resources` VALUES (70, 2, 31);
INSERT INTO `system_role_resources` VALUES (71, 2, 4);
INSERT INTO `system_role_resources` VALUES (17158145, 4, 23);
INSERT INTO `system_role_resources` VALUES (17158146, 4, 97);
INSERT INTO `system_role_resources` VALUES (17158147, 3, 23);
INSERT INTO `system_role_resources` VALUES (17158148, 3, 30);
INSERT INTO `system_role_resources` VALUES (17158149, 3, 31);
INSERT INTO `system_role_resources` VALUES (17158150, 3, 35);
INSERT INTO `system_role_resources` VALUES (17158151, 3, 78);
INSERT INTO `system_role_resources` VALUES (17158152, 3, 80);
INSERT INTO `system_role_resources` VALUES (17158153, 3, 83);
INSERT INTO `system_role_resources` VALUES (17158154, 3, 95);

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `login_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户名',
  `pass_word` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `status` int NULL DEFAULT 0 COMMENT '状态',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0,
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '账号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES ('1', 'super', '305cecf1eb10d0bcb1b0df2675535731', '超级管理', -1, 1642437031000, 1698499208087, 0, NULL);
INSERT INTO `system_user` VALUES ('3a791d8a86d24d389b5c7f2722db187d', '123', '033e997f49e0cff004e70b09303f670a', '123', 0, 1699163761828, 1699163761828, 1, '1');
INSERT INTO `system_user` VALUES ('4', 'admin', 'fd94911088b38e12d01051fbc38fd55e', '管理员A', 0, 1642437031000, NULL, 0, NULL);
INSERT INTO `system_user` VALUES ('b30b183775de476f9081543a712fc9bd', 'user', '033e997f49e0cff004e70b09303f670a', '用户A', 0, 1642437031000, NULL, 0, NULL);

-- ----------------------------
-- Table structure for system_user_department
-- ----------------------------
DROP TABLE IF EXISTS `system_user_department`;
CREATE TABLE `system_user_department`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `department_id` int NULL DEFAULT NULL COMMENT '部门编号',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`department_id` ASC) USING BTREE,
  INDEX `admin_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门用户关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user_department
-- ----------------------------

-- ----------------------------
-- Table structure for system_user_info
-- ----------------------------
DROP TABLE IF EXISTS `system_user_info`;
CREATE TABLE `system_user_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `admin_sex` int NULL DEFAULT NULL COMMENT '性别',
  `admin_phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `admin_email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `home_place` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住址',
  `contact_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系地址',
  `admin_note` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user_info
-- ----------------------------
INSERT INTO `system_user_info` VALUES (1, 1667054874440, 2, '13133334468', 'tworice_0811@163.com', '北京市', '山西省大同市', '测试', '1', NULL, NULL, b'0');
INSERT INTO `system_user_info` VALUES (4, 1673074959485, 1, NULL, 'tworice_0811@163.com', '北京市', '北京市海淀区中关村东路', NULL, '4', 1699112436370, NULL, b'0');

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int NULL DEFAULT NULL COMMENT '角色编号',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  INDEX `admin_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
INSERT INTO `system_user_role` VALUES (1, 1, '1', 0);
INSERT INTO `system_user_role` VALUES (3, 3, '3', 0);
INSERT INTO `system_user_role` VALUES (10, 2, '2', 0);
INSERT INTO `system_user_role` VALUES (11, 4, 'b30b183775de476f9081543a712fc9bd', 0);
INSERT INTO `system_user_role` VALUES (14, 2, '1', 0);
INSERT INTO `system_user_role` VALUES (15, 2, '4', 0);
INSERT INTO `system_user_role` VALUES (16, 4, 'd6a2c18b937e448082fa54aad1270e1c', 0);
INSERT INTO `system_user_role` VALUES (23, 16, '4', 0);

-- ----------------------------
-- Table structure for system_version_log
-- ----------------------------
DROP TABLE IF EXISTS `system_version_log`;
CREATE TABLE `system_version_log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '版本号',
  `info` varchar(8098) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '版本信息',
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统版本日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_version_log
-- ----------------------------
INSERT INTO `system_version_log` VALUES (1, 1652799051704, 'v1.3', '1、新增版本日志\r\n2、更改界面按钮尺寸\r\n3、增加多选框及批量删除\r\n4、增加Service使用统一接口\r\n5、修复刷新后页面重新初始化路径\r\n6、升级富文本组件为wangEditor5', '二饭');
INSERT INTO `system_version_log` VALUES (2, 1653638359707, 'v1.3.1', '1、更新界面UI\r\n2、优化界面初始化状态', '二饭');

-- ----------------------------
-- Table structure for system_white_list
-- ----------------------------
DROP TABLE IF EXISTS `system_white_list`;
CREATE TABLE `system_white_list`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `begin_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开始IP',
  `end_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '结束IP',
  `state` int NULL DEFAULT NULL COMMENT '状态',
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '访问白名单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_white_list
-- ----------------------------
INSERT INTO `system_white_list` VALUES (3, 1683167167287, 1683167167287, '192.168.0.12', '192.168.0.15', NULL, 1);
INSERT INTO `system_white_list` VALUES (4, 1683168466704, 1683168748438, '192.168.0.1', '192.168.0.116', NULL, 0);
INSERT INTO `system_white_list` VALUES (5, 1683168768847, 1683168768847, '127.0.0.1', '127.0.0.1', NULL, 1);

SET FOREIGN_KEY_CHECKS = 1;
