/*
 Navicat Premium Data Transfer

 Source Server         : 本地MySQL8
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : tworice_admin

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 18/03/2025 15:15:26
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
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
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
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  `deploy_id` int NULL DEFAULT NULL COMMENT '部门编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '人事调动记录' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_dict
-- ----------------------------
INSERT INTO `system_dict` VALUES (1, 1664092965734, '性别', '性别选项', 'SYSTEM_SEX', NULL, NULL, 0);
INSERT INTO `system_dict` VALUES (2, 1664097012604, '天气', '天气字典', 'SYSTEM_WEATHER', NULL, NULL, 0);
INSERT INTO `system_dict` VALUES (6, 1681227558864, '调动状态', '调动状态', 'RSDDZT', NULL, NULL, 0);
INSERT INTO `system_dict` VALUES (9, 1707900985630, '反馈处理状态', '反馈处理状态', 'FKCLZT', 1707900985630, '4', 0);
INSERT INTO `system_dict` VALUES (10, 1708500045201, '测试', '测试', '测试', 1708500045201, '1', 1);
INSERT INTO `system_dict` VALUES (11, 1708501927900, '测试12', '测试12', '测试12', 1708501946361, '1', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `system_dict_value` VALUES (12, 1707901023292, 9, '处理中', '处理中');
INSERT INTO `system_dict_value` VALUES (13, 1707901036893, 9, '已解决', '已解决');

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
  `fb_deal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '反馈处理',
  `fb_state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理状态',
  `fb_contact` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系方式',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户反馈信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for system_feedback_type
-- ----------------------------
DROP TABLE IF EXISTS `system_feedback_type`;
CREATE TABLE `system_feedback_type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `type_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '反馈类型名称',
  `type_state` int NULL DEFAULT NULL COMMENT '反馈类型状态',
  `type_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '反馈类型描述',
  `type_level` int NULL DEFAULT NULL COMMENT '反馈类型级别',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '反馈类型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_feedback_type
-- ----------------------------
INSERT INTO `system_feedback_type` VALUES (2, 1707831696242, 1707831696242, '1', '产品建议', 1, '请向开发者反馈你对产品的相关建议。', 3, 0);
INSERT INTO `system_feedback_type` VALUES (3, 1707831893511, 1707831893511, '1', '功能异常', 1, '请向开发者反馈系统功能异常问题', 3, 0);
INSERT INTO `system_feedback_type` VALUES (4, 1707831912384, 1707831912384, '1', '违规举报', 1, '若遇到色情、诱导、骚扰、欺诈、违法犯罪等情况，请向系统管理员举报。', 3, 0);

-- ----------------------------
-- Table structure for system_file
-- ----------------------------
DROP TABLE IF EXISTS `system_file`;
CREATE TABLE `system_file`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件路径',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件名称',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除',
  `type` int NULL DEFAULT 1 COMMENT '文件类型',
  `parent` int NULL DEFAULT NULL COMMENT '所属父目录',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `share` int NULL DEFAULT 0 COMMENT '1-分享 0-不分享',
  `level` int NULL DEFAULT 2 COMMENT '访问等级',
  `pwd` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问密码',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_file
-- ----------------------------
INSERT INTO `system_file` VALUES (1, NULL, NULL, '/', '根目录', NULL, 0, 2, NULL, NULL, 0, 2, NULL, NULL);

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
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_notice
-- ----------------------------
INSERT INTO `system_notice` VALUES ('cefa64bba1d042618dff0784f2d9731c', 1722156251388, '测试', '<p>这是初始化内容111🤓</p>', 1, '1', 1722394796081, 0);

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
  `url` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求路径',
  `pid` int NULL DEFAULT NULL COMMENT '上级菜单',
  `sort` int NULL DEFAULT NULL COMMENT '菜单排序',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `type` int NULL DEFAULT NULL COMMENT '菜单类型',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '前端页面路径',
  `state` tinyint NULL DEFAULT 1 COMMENT '展示状态',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由地址',
  `menu` tinyint NULL DEFAULT 1 COMMENT '是否菜单',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_resources
-- ----------------------------
INSERT INTO `system_resources` VALUES (1, '系统管理', '/system', 0, 1, 'el-icon-setting', 1, 'views/admin/index.vue', 1, 'system', 1);
INSERT INTO `system_resources` VALUES (2, '信息管理', '/info', 0, 2, 'el-icon-s-data', 1, 'views/admin/index.vue', 1, 'info', 1);
INSERT INTO `system_resources` VALUES (3, '基础设施', '/infra', 0, 3, 'el-icon-chat-line-round', 1, 'views/admin/index.vue', 1, 'infra', 1);
INSERT INTO `system_resources` VALUES (4, '角色管理', '/system/role', 1, 11, 'null', 2, 'views/admin/role.vue', 1, 'role', 1);
INSERT INTO `system_resources` VALUES (5, '资源菜单', '/system/resource', 1, 12, 'null', 2, 'views/admin/resource.vue', 1, 'resource', 1);
INSERT INTO `system_resources` VALUES (23, '公告信息', '/infra/notice', 3, 31, '', 2, 'views/admin/notice.vue', 1, 'notice', 1);
INSERT INTO `system_resources` VALUES (26, '人员管理', '/system/admin', 1, 14, '', 2, 'views/admin/admin.vue', 1, 'admin', 1);
INSERT INTO `system_resources` VALUES (29, '日志管理', '/log', 0, 4, 'el-icon-document', 1, 'views/admin/index.vue', 1, 'log', 1);
INSERT INTO `system_resources` VALUES (30, '操作日志', '/log/log', 29, 41, '', 2, 'views/admin/log.vue', 1, 'log', 1);
INSERT INTO `system_resources` VALUES (31, '登录日志', '/log/loginLog', 29, 42, '', 2, 'views/admin/loginLog.vue', 1, 'loginLog', 1);
INSERT INTO `system_resources` VALUES (32, '系统工具', '/tools', 0, 5, 'el-icon-box', 1, 'views/admin/index.vue', 1, 'tools', 1);
INSERT INTO `system_resources` VALUES (33, '系统接口', '/tools/doc', 32, 51, '', 2, 'views/admin/doc.vue', 1, 'doc', 1);
INSERT INTO `system_resources` VALUES (34, '系统监控', '/tools/monitor', 32, 52, '', 2, 'views/admin/monitor.vue', 1, 'monitor', 1);
INSERT INTO `system_resources` VALUES (35, '代码生成', '/tools/codeGeneration', 32, 55, '', 2, 'views/admin/codeGeneration/codeGeneration.vue', 1, 'codeGeneration', 1);
INSERT INTO `system_resources` VALUES (65, '开发示例', '/dev', 0, 6, 'el-icon-s-cooperation', 1, 'views/admin/online.vue', 1, 'dev', 1);
INSERT INTO `system_resources` VALUES (66, '富文本组件', '/dev/editor', 65, 61, '', 2, 'views/dev/editor.vue', 1, 'editor', 1);
INSERT INTO `system_resources` VALUES (67, '跳转页面', '/dev/jump', 65, 62, '', 2, 'views/dev/jump.vue', 1, 'jump', 1);
INSERT INTO `system_resources` VALUES (75, '文件上传', '/dev/upload', 65, 63, '', 2, 'views/dev/upload.vue', 1, 'upload', 1);
INSERT INTO `system_resources` VALUES (78, '在线账户', '/tools/online', 32, 56, '', 2, 'views/admin/online.vue', 1, 'online', 1);
INSERT INTO `system_resources` VALUES (80, '版本日志', '/log/versionLog', 29, 43, '', 2, 'views/admin/versionLog.vue', 1, 'versionLog', 1);
INSERT INTO `system_resources` VALUES (83, '字典管理', '/tools/dict', 32, 50, '', 2, 'views/admin/dict.vue', 1, 'dict', 1);
INSERT INTO `system_resources` VALUES (94, '支付示例', '/dev/alipay/10086', 65, 4, '', 2, 'views/dev/alipay.vue', 1, 'alipay/:id', 1);
INSERT INTO `system_resources` VALUES (95, '访问白名单', '/tools/whiteList', 32, 57, '', 2, 'views/admin/whiteList.vue', 1, 'whiteList', 1);
INSERT INTO `system_resources` VALUES (96, 'AES加密', '/dev/aes', 65, 97, '', 2, 'views/dev/aes.vue', 1, 'aes', 1);
INSERT INTO `system_resources` VALUES (97, '我的文件', '/admin/file', 0, 9, 'el-icon-folder', 2, 'views/admin/file/systemFile.vue', 1, 'file', 1);
INSERT INTO `system_resources` VALUES (99, 'OCR识别', '/dev/ocr', 65, 98, '', 2, 'views/dev/ocr.vue', 1, 'ocr', 1);
INSERT INTO `system_resources` VALUES (101, '首页', '/admin/home', 0, -1, 'el-icon-s-home', 2, 'views/admin/home.vue', 1, 'home', 1);
INSERT INTO `system_resources` VALUES (102, '应用监控', '/tools/admin', 32, 58, '', 2, 'views/tools/SpringBootAdmin.vue', 1, 'admin', 1);
INSERT INTO `system_resources` VALUES (103, '部门管理', '/system/department', 1, 24, '', 2, 'views/admin/department.vue', 1, 'department', 1);
INSERT INTO `system_resources` VALUES (106, '用户反馈', '/infra/feedback', 3, 3, '', 2, 'views/admin/feedback/systemFeedback.vue', 1, 'feedback', 1);
INSERT INTO `system_resources` VALUES (107, '反馈类型', '/infra/feedbackType', 3, 1, '', 2, 'views/admin/feedback/systemFeedbackType.vue', 1, 'feedbackType', 1);
INSERT INTO `system_resources` VALUES (115, 'Netty', '/dev/ws', 65, 10, '', 2, 'views/dev/ws.vue', 1, 'ws', 1);
INSERT INTO `system_resources` VALUES (116, '公告查看', '/infra/showNotice', 0, 114, '', 2, 'views/admin/showNotice.vue', 1, 'showNotice', 0);

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_name`(`role_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `system_role` VALUES (1, '超级管理员', 1, NULL, NULL, NULL);
INSERT INTO `system_role` VALUES (2, '系统管理员', 0, NULL, 1713406117519, NULL);
INSERT INTO `system_role` VALUES (3, '管理员', 0, NULL, 1715574982463, NULL);
INSERT INTO `system_role` VALUES (4, '用户', 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for system_role_resources
-- ----------------------------
DROP TABLE IF EXISTS `system_role_resources`;
CREATE TABLE `system_role_resources`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int NULL DEFAULT NULL COMMENT '角色编号',
  `resource_id` int NULL DEFAULT NULL COMMENT '菜单编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17158214 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色菜单关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_role_resources
-- ----------------------------
INSERT INTO `system_role_resources` VALUES (-1090138111, 1, 23);
INSERT INTO `system_role_resources` VALUES (17158207, 3, 101);
INSERT INTO `system_role_resources` VALUES (17158208, 2, 101);
INSERT INTO `system_role_resources` VALUES (17158209, 2, 26);
INSERT INTO `system_role_resources` VALUES (17158210, 2, 4);
INSERT INTO `system_role_resources` VALUES (17158211, 4, 30);
INSERT INTO `system_role_resources` VALUES (17158212, 4, 31);
INSERT INTO `system_role_resources` VALUES (17158213, 4, 80);

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `login_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户名',
  `pass_word` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `status` int NULL DEFAULT 1 COMMENT '状态',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `invite_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邀请码',
  `inviter_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邀请人',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '账号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES ('1', 'super', '98892fc9a920fc14c6fd2467e09f78a9', '超级管理', 1, 1642437031000, 1723043417044, 0, NULL, '118118', NULL, NULL, NULL);
INSERT INTO `system_user` VALUES ('4', 'admin', '033e997f49e0cff004e70b09303f670a', '管理员', 1, 1642437031000, 1723044123790, 0, NULL, '745745', NULL, NULL, NULL);
INSERT INTO `system_user` VALUES ('b30b183775de476f9081543a712fc9bd', 'user', '033e997f49e0cff004e70b09303f670a', '用户', 1, 1642437031000, 1739098480857, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `system_user` VALUES ('cfe8f30c3992bd2bda10b36d59ccefc0', 'zhangsan', '033e997f49e0cff004e70b09303f670a', '张三', 1, 1713406355355, 1717404867144, 0, '1', NULL, NULL, NULL, NULL);
INSERT INTO `system_user` VALUES ('f8b3ea125c7df3753a39473376521642', 'test', '033e997f49e0cff004e70b09303f670a', 'test', 0, 1708498511121, 1708498511121, 1, '1', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for system_user_department
-- ----------------------------
DROP TABLE IF EXISTS `system_user_department`;
CREATE TABLE `system_user_department`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `department_id` int NULL DEFAULT NULL COMMENT '部门编号',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`department_id` ASC) USING BTREE,
  INDEX `admin_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门用户关系表' ROW_FORMAT = DYNAMIC;

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
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `deleted` bit(1) NULL DEFAULT NULL COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user_info
-- ----------------------------
INSERT INTO `system_user_info` VALUES (1, 1667054874440, 1, '13133334468', 'tworice_0811@163.com', '北京市', '山西省大同市12', '测试', '1', NULL, NULL, b'0');
INSERT INTO `system_user_info` VALUES (4, 1673074959485, 1, NULL, 'tworice_0811@163.com', '北京市', '北京市海淀区中关村东路', NULL, '4', 1699112436370, NULL, b'0');
INSERT INTO `system_user_info` VALUES (5, NULL, NULL, '123321', '12', NULL, NULL, '测试', 'b30b183775de476f9081543a712fc9bd', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int NULL DEFAULT NULL COMMENT '角色编号',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  INDEX `admin_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
INSERT INTO `system_user_role` VALUES (1, 1, '1', 0);
INSERT INTO `system_user_role` VALUES (10, 2, '2', 0);
INSERT INTO `system_user_role` VALUES (14, 2, '1', 0);
INSERT INTO `system_user_role` VALUES (15, 2, '4', 0);
INSERT INTO `system_user_role` VALUES (23, 16, '4', 0);
INSERT INTO `system_user_role` VALUES (30, 3, 'cfe8f30c3992bd2bda10b36d59ccefc0', 0);
INSERT INTO `system_user_role` VALUES (31, 4, 'cfe8f30c3992bd2bda10b36d59ccefc0', 0);
INSERT INTO `system_user_role` VALUES (32, 4, 'b30b183775de476f9081543a712fc9bd', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统版本日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_version_log
-- ----------------------------

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
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '访问白名单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_white_list
-- ----------------------------
INSERT INTO `system_white_list` VALUES (5, 1683168768847, 1683168768847, '127.0.0.1', '127.0.0.1', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
