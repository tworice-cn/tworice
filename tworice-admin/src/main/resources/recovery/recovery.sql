/*
 Navicat Premium Data Transfer

 Source Server         : NAS MySQL8
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : www.tworice.online:13306
 Source Schema         : tworice_admin

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 24/01/2024 18:04:12
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
-- Table structure for system_dict
-- ----------------------------
DROP TABLE IF EXISTS `system_dict`;
CREATE TABLE `system_dict`  (
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
-- Records of system_dict
-- ----------------------------
INSERT INTO `system_dict` VALUES (1, 1664092965734, '性别', '性别选项', 'SYSTEM_SEX', NULL, NULL, 0);
INSERT INTO `system_dict` VALUES (2, 1664097012604, '天气', '天气字典', 'SYSTEM_WEATHER', NULL, NULL, 0);
INSERT INTO `system_dict` VALUES (6, 1681227558864, '调动状态', '调动状态', 'RSDDZT', NULL, NULL, 0);

-- ----------------------------
-- Table structure for system_dict_value
-- ----------------------------
DROP TABLE IF EXISTS `system_dict_value`;
CREATE TABLE `system_dict_value`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `dict` int NULL DEFAULT NULL COMMENT '字典编号',
  `content` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典内容',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_dict_value
-- ----------------------------
INSERT INTO `system_dict_value` VALUES (1, 1664096943799, 1, '男', '性别男');
INSERT INTO `system_dict_value` VALUES (2, 1664097610129, 1, '女', '性别女');
INSERT INTO `system_dict_value` VALUES (3, 1664097743834, 2, '晴', '天气晴');
INSERT INTO `system_dict_value` VALUES (4, 1664097775454, 2, '阴', '天气阴');
INSERT INTO `system_dict_value` VALUES (5, 1664097842757, 2, '小雨', '天气小雨');
INSERT INTO `system_dict_value` VALUES (6, 1664097987000, 2, '大雨', '天气大雨');
INSERT INTO `system_dict_value` VALUES (7, 1664098087375, 2, '大风', '天气大风');
INSERT INTO `system_dict_value` VALUES (11, 1664098293463, 1, '未知', '性别未知');

-- ----------------------------
-- Table structure for system_feedback
-- ----------------------------
DROP TABLE IF EXISTS `system_feedback`;
CREATE TABLE `system_feedback`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `fb_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '反馈类型',
  `fb_describe` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '反馈描述',
  `fb_contact` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系方式',
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户反馈信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_feedback
-- ----------------------------

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
INSERT INTO `system_notice` VALUES ('b4602337ee3e42f3883d5711fc40d989', 1700234121999, '测试公告', '<p>这里是公告内容</p>', 1, '1', 1700234121999, 0);

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
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '前端页面路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_resources
-- ----------------------------
INSERT INTO `system_resources` VALUES (1, '系统管理', '/system', 0, 1, 'el-icon-setting', 1, '/system', NULL);
INSERT INTO `system_resources` VALUES (2, '信息管理', '/info', 0, 2, 'el-icon-s-data', 1, '/info', NULL);
INSERT INTO `system_resources` VALUES (3, '基础设施', '/notice', 0, 3, 'el-icon-chat-line-round', 1, '', NULL);
INSERT INTO `system_resources` VALUES (4, '角色管理', '/system/role', 1, 11, 'null', 2, '/role', '@/components/admin/role.vue');
INSERT INTO `system_resources` VALUES (5, '资源菜单', '/system/resource', 1, 12, 'null', 2, '/resource', '@/components/admin/resource.vue');
INSERT INTO `system_resources` VALUES (23, '公告信息', '/notice/notice', 3, 31, '', 2, '/notice', '@/components/admin/notice.vue');
INSERT INTO `system_resources` VALUES (26, '人员管理', '/system/admin', 1, 14, '', 2, '/admin', '@/components/admin/admin.vue');
INSERT INTO `system_resources` VALUES (29, '日志管理', '/log', 0, 4, 'el-icon-document', 1, '/log', '@/components/admin');
INSERT INTO `system_resources` VALUES (30, '操作日志', '/log/log', 29, 41, '', 2, '/log', '@/components/admin/log.vue');
INSERT INTO `system_resources` VALUES (31, '登录日志', '/log/loginLog', 29, 42, '', 2, '/loginLog', '@/components/admin/loginLog.vue');
INSERT INTO `system_resources` VALUES (32, '系统工具', '/tools', 0, 5, 'el-icon-box', 1, '/tools', '@/components/admin');
INSERT INTO `system_resources` VALUES (33, '系统接口', '/tools/doc', 32, 51, '', 2, '/doc', '@/components/admin/doc.vue');
INSERT INTO `system_resources` VALUES (34, '系统监控', '/tools/monitor', 32, 52, '', 2, '/monitor', '@/components/admin/monitor.vue');
INSERT INTO `system_resources` VALUES (35, '代码生成', '/tools/codeGeneration', 32, 55, '', 2, '/codeGeneration', '@/components/admin/codeGeneration.vue');
INSERT INTO `system_resources` VALUES (65, '开发示例', '/dev', 0, 6, 'el-icon-s-cooperation', 1, '/online', '@/components/admin/online.vue');
INSERT INTO `system_resources` VALUES (66, '富文本组件', '/dev/editor', 65, 61, '', 2, '/editor', '@/components/dev/editor.vue');
INSERT INTO `system_resources` VALUES (67, '跳转页面', '/dev/jump', 65, 62, '', 2, '/jump', '@/components/dev/jump.vue');
INSERT INTO `system_resources` VALUES (75, '文件上传', '/dev/upload', 65, 63, '', 2, '/upload', '@/components/dev/upload.vue');
INSERT INTO `system_resources` VALUES (78, '在线账户', '/tools/online', 32, 56, '', 2, '/online', '@/components/admin/online.vue');
INSERT INTO `system_resources` VALUES (80, '版本日志', '/log/versionLog', 29, 43, '', 2, '/versionLog', '@/components/admin/versionLog.vue');
INSERT INTO `system_resources` VALUES (83, '字典管理', '/tools/dict', 32, 50, '', 2, '/dict', '@/components/admin/dict.vue');
INSERT INTO `system_resources` VALUES (94, '支付示例', '/dev/alipay/10086', 65, 4, '', 2, 'alipay/:id', '@/components/dev/alipay.vue');
INSERT INTO `system_resources` VALUES (95, '访问白名单', '/tools/whiteList', 32, 57, '', 2, '/whiteList', '@/components/admin/whiteList.vue');
INSERT INTO `system_resources` VALUES (96, 'AES加密', '/dev/aes', 65, 97, '', 2, 'aes', '@/components/dev/aes.vue');
INSERT INTO `system_resources` VALUES (97, '我的文件', '/admin/file', 0, 9, 'el-icon-folder', 2, 'file', '@/components/admin/systemFile.vue');
INSERT INTO `system_resources` VALUES (99, 'OCR识别', '/dev/ocr', 65, 98, '', 2, 'ocr', '@/components/dev/ocr.vue');
INSERT INTO `system_resources` VALUES (101, '首页', '/admin/home', 0, 0, 'el-icon-s-home', 2, '/admin/home', '@/components/admin');
INSERT INTO `system_resources` VALUES (102, '应用监控', '/tools/admin', 32, 58, '', 2, 'admin', '@/components/tools/SpringBootAdmin.vue');
INSERT INTO `system_resources` VALUES (103, '部门管理', '/system/department', 1, 24, '', 2, 'department', '@/components/admin/department.vue');
INSERT INTO `system_resources` VALUES (106, '用户反馈', '/notice/feedback', 3, 3, '', 2, '', NULL);

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
INSERT INTO `system_user` VALUES ('1', 'test@qq.com', '305cecf1eb10d0bcb1b0df2675535731', '超级管理', -1, 1642437031000, 1706090254754, 0, NULL);
INSERT INTO `system_user` VALUES ('4', 'admin', 'fd94911088b38e12d01051fbc38fd55e', '管理员A', 0, 1642437031000, NULL, 0, NULL);
INSERT INTO `system_user` VALUES ('4caa1ac83e3b9dfb6f75f891a7de4696', '1786705138@qq.com', '25769cf968f8954b42c9dce8eea60e8f', '二饭', 0, 1704627921890, 1704627921890, 0, 'undefined');
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
INSERT INTO `system_user_info` VALUES (1, 1667054874440, 1, '13133334468', 'tworice_0811@163.com', '北京市', '山西省大同市', '测试', '1', NULL, NULL, b'0');
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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关系表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `system_user_role` VALUES (28, 4, '4caa1ac83e3b9dfb6f75f891a7de4696', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统版本日志' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `system_white_list` VALUES (5, 1683168768847, 1683168768847, '127.0.0.1', '127.0.0.1', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
