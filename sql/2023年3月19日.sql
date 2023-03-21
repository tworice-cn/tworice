/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80028 (8.0.28)
 Source Host           : localhost:3306
 Source Schema         : tworice_admin

 Target Server Type    : MySQL
 Target Server Version : 80028 (8.0.28)
 File Encoding         : 65001

 Date: 19/03/2023 14:40:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_admin
-- ----------------------------
DROP TABLE IF EXISTS `system_admin`;
CREATE TABLE `system_admin`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `login_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pass_word` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nick_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT 0,
  `create_time` bigint NULL DEFAULT NULL,
  `update_time` bigint NULL DEFAULT NULL,
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '账号表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_admin
-- ----------------------------
INSERT INTO `system_admin` VALUES ('1', 'super', '7063a3d5f1aa1ff89acb8e1ac78b9854', '超级管理员', 0, 1642437031000, NULL, 0);
INSERT INTO `system_admin` VALUES ('3afbb7acb1f44c2ab342ce3a96a4a20b', 'wqe', 'b75f1bc9cb2a9e64aabc4dc9bf1bb58c', 'qwe', 0, 1675134055175, NULL, 0);
INSERT INTO `system_admin` VALUES ('4', 'admin', 'fcc304f79dc800ad44f7e09732efa97e', '管理员A', 0, 1642437031000, NULL, 0);
INSERT INTO `system_admin` VALUES ('4e1c5efda31c4eb492a7c6db63140e94', '2222', 'b75f1bc9cb2a9e64aabc4dc9bf1bb58c', '1111', 0, 1675082850341, NULL, 1);
INSERT INTO `system_admin` VALUES ('81b333e77e854eb0b3f0a5f0eb5b50a3', '2222', 'b75f1bc9cb2a9e64aabc4dc9bf1bb58c', '1111', 0, 1675005268549, NULL, 1);
INSERT INTO `system_admin` VALUES ('af39d57668c249fbb42fbef814fcbc26', 'test1', '033e997f49e0cff004e70b09303f670a', 'test1', 0, 1673068864547, NULL, 1);
INSERT INTO `system_admin` VALUES ('b30b183775de476f9081543a712fc9bd', 'user', '033e997f49e0cff004e70b09303f670a', '用户A', 0, 1642437031000, NULL, 0);
INSERT INTO `system_admin` VALUES ('d945f59477cc41c681a85218ea99ac92', 'test', '033e997f49e0cff004e70b09303f670a', 'test', 0, 1647584357530, NULL, 0);

-- ----------------------------
-- Table structure for system_admin_dist
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_dist`;
CREATE TABLE `system_admin_dist`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `logo` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_admin_dist
-- ----------------------------
INSERT INTO `system_admin_dist` VALUES (1, 1664092965734, '性别', '性别选项', 'SYSTEM_SEX');
INSERT INTO `system_admin_dist` VALUES (2, 1664097012604, '天气', '天气字典', 'SYSTEM_WEATHER');

-- ----------------------------
-- Table structure for system_admin_info
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_info`;
CREATE TABLE `system_admin_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL,
  `admin_sex` int NULL DEFAULT NULL,
  `admin_phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `admin_email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `home_place` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `contact_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `admin_note` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_id`(`admin_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_admin_info
-- ----------------------------
INSERT INTO `system_admin_info` VALUES (1, 1667054874440, 1, '13133334468', 'tworice_0811@163.com', '北京市', '山西省大同市', '测试', '1');
INSERT INTO `system_admin_info` VALUES (4, 1673074959485, 1, NULL, NULL, NULL, NULL, NULL, '4');

-- ----------------------------
-- Table structure for system_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_log`;
CREATE TABLE `system_admin_log`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` bigint NULL DEFAULT NULL,
  `active` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `table_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `target_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ip_addr` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_admin_log
-- ----------------------------
INSERT INTO `system_admin_log` VALUES ('04af25ce32d541489cad9caf815699a1', 1675093157551, '系统角色-删除角色', '1', 'system_role', '[13]', NULL);
INSERT INTO `system_admin_log` VALUES ('08fdc4d33f18490785253d25daed1e49', 1675132966352, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('0f300e714bef4f97a643121366fd9197', 1673162949507, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('1100b14de2d5460fb14b527d9e23cfd7', 1673261254679, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('117bcb4643c44973a93536660c540c8f', 1675092716838, '【已恢复】通知公告-通过ID删除通知', '1', NULL, '[\"caf654afd61f4c15bee65057af15da90\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('11f00088c58a4e3c8320b8df9d4f9985', 1675132947624, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('1217cfdbdec34b3089c2b041b5961057', 1673275213062, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('13849ceae34e45ffba62c1ce1584e3e3', 1673162877922, '添加/更新资源信息-资源菜单', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('164b88993c4c4d1ba6c9622c5a6df9be', 1673165789063, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('19b7bb1ee7cd4ea99ca7bc1daa33216e', 1673158627992, '系统字典-通过ID数组删除数据', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('224afc603583403a9e0170b7b5a57451', 1675134880710, '【已恢复】通知公告-通过ID删除通知', '1', NULL, '[\"a3ac8b52c55c4be2875cdf8828f03f9c\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('24bc0186343948eaae4b4c57100a03b3', 1675091439480, '通知公告-通过ID删除通知', '1', 'system_notice', '[\"a3ac8b52c55c4be2875cdf8828f03f9c\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('25afa6f82a434453ac1c75dbd9f969c9', 1675005268547, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('25def1a817c642cda3146842e6dd8aa8', 1679148754041, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('2940eb79327b471485dd4dafeed46e11', 1673157184283, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('2aba439ebe9241018309ca8031f21af1', 1673165423023, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('2c5b1fa1473c4ff08b07ec3a36f75474', 1673327856979, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('3b56c10f55894207b59cce97e139fdd8', 1673162949508, '添加/更新资源信息-支付示例', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('3fcdb481aaed4e91b54d9fa18a2d36e2', 1675092733502, '通知公告-通过ID删除通知', '1', 'system_notice', '[\"caf654afd61f4c15bee65057af15da90\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('43b4eb7379ec406986838fbf6b19aa47', 1676200803207, '系统菜单资源-删除资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('454df7f3ec714dc98707421f9e6b8490', 1676037350477, '文件管理-删除数据', '1', 'system_file', '[6,5,4,3,2]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('47c64197ab24480e870fbd4672e17299', 1673265884666, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('48bb43ec464e4fb08b452a7047efb256', 1678546832976, '测试表-更新数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('4a06823892de402698fa01d461ecf86e', 1676080527897, '文件管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('4a7228c88ba545a68dda2e8f3abd39e2', 1675090029884, '【已恢复】系统人员管理-删除人员账号', '1', NULL, '[\"af39d57668c249fbb42fbef814fcbc26\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('4d622e9f7eb649d09aed2714a3a9237c', 1676080664773, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('4fce8189298a4c74aef002e5dd51cfe1', 1673324836153, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('513f4ff0e0eb48b4b545ecc96bc0f54e', 1676781392619, '系统人员管理-更新账号密码', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('544d87e94478431fb0b811f0ddce6621', 1678546737692, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('5606f80022ca4e4894f5b302ccc96a9c', 1675093117629, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('5842e766c5e44a8bac70cd646ef4187f', 1673500589618, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('59071415bc04429883f9b7e74b979e47', 1673275410448, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('59185fd3ae04418dbb7b049b70a2b3cb', 1673167570280, '系统角色-添加人员到指定角色，可多人员', 'd945f59477cc41c681a85218ea99ac92', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('5c88e306fc024e2a8e6d240c3e57751f', 1675134026464, '系统角色-删除角色', '1', 'system_role', '[15]', NULL);
INSERT INTO `system_admin_log` VALUES ('5f14685e000b4d83afdd3344fa0582ab', 1673325514007, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('6409eda0c3484d50b314e5f4aa98b264', 1675005273375, '系统人员管理-删除人员账号', '1', '', '[[\"81b333e77e854eb0b3f0a5f0eb5b50a3\"]]', NULL);
INSERT INTO `system_admin_log` VALUES ('655e2a953ecf4327b25695e3270a68bc', 1675090023600, '系统人员管理-删除人员账号', '1', 'system_admin', '[\"4e1c5efda31c4eb492a7c6db63140e94\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('6a89a910916443d886f43b5747d4d256', 1678546856872, '测试表-更新数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('6c8d5e685cb14309b4ee15fca85094f8', 1675344959709, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('72bddeaf36ba41f08b4c98f5d66baeba', 1676006787501, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('73c10613db304ed7b6395571a256cd10', 1675082850338, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('7528b902d95c457e9b7a994ba429153a', 1676037277646, '文件管理-删除数据', '1', 'system_file', '[6,5,4,3,2]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('75e317c030384b1bb526f80021827dc4', 1675092919101, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('761503ebf6c1442c9d93a1fff58b4c24', 1675092742057, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('769a631da1ab4a03942c354067805740', 1675134028445, '系统角色-删除角色', '1', 'system_role', '[14]', NULL);
INSERT INTO `system_admin_log` VALUES ('7a725c2a5d844e1fb5a4626d24faa34e', 1675090009779, '系统日志-删除操作日志', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('7eeb173ab6b9432a941df4faf9d38c99', 1675091032270, '系统角色-删除角色', '1', 'system_role', '[5]', NULL);
INSERT INTO `system_admin_log` VALUES ('80e0e768b8124577be4f81dfbc10d8b2', 1673158605712, '系统字典-新增数据', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('84a983b4c7734f9ea71c14e5d60de0d4', 1676200798906, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('8c085b5a81dc489d900a62a1827eb11d', 1673167570281, '添加人员-[d945f59477cc41c681a85218ea99ac92]-到角色-2', 'd945f59477cc41c681a85218ea99ac92', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('8d0a2241f1724de1a2363e3f83a8e311', 1673155820964, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('92087d89fd1a4b12a630261aebd7bc7c', 1675091436658, '通知公告-添加通知', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('9440f8df31d04f2db48a14820d339ffd', 1675134861900, '系统角色-删除角色', '1', 'system_role', '[12]', NULL);
INSERT INTO `system_admin_log` VALUES ('96cc63e4cda24c8b9eb983fa1c117b20', 1675141508592, '通知公告-通过ID删除通知', '1', 'system_notice', '[\"a3ac8b52c55c4be2875cdf8828f03f9c\"]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('9af85834f41c4ba4801480381a19ecef', 1674997772544, '系统人员管理-删除人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('9cef0f2e5be24efda85cb877926c85ee', 1673165500961, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('9d91eb3b83a04ef0b0c6901cb5cc170f', 1676200674120, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('9f6f06dbb5a441c185a72a22b44bddcd', 1673162877922, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('a203af6955d542eeb3dd708432dc5b2a', 1677667519017, '文件管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('a23852f02c334e1c8a0028b7582bc45a', 1676038200422, '文件管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('a27d71ee93e34343aaadfb7256775f75', 1675089966891, '系统日志-删除操作日志', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('a8234c1bf02247129c9180a782e2535e', 1675090048727, '系统人员管理-删除人员账号', '1', 'system_admin', '[\"81b333e77e854eb0b3f0a5f0eb5b50a3\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('a878af6abd334c29b63080313f39b065', 1673325725225, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('b4f66ecfb5b94daa994813e2e41d786e', 1673177413692, '系统人员管理-添加人员账号', 'd945f59477cc41c681a85218ea99ac92', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('b5dd4c826e8f42da92fff6252f491584', 1673325955552, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('b741d89c3fc54db9bc4ae4d16bdeefc7', 1673500427869, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('bded7ef7eee04e0bba6f2fb9ac4287f6', 1673165247844, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('c2e27f0700ae4b888ee670f9d0fce5ce', 1676040651595, '文件管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('c4d56d9a7687433593b50da92582a998', 1675163332067, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('c5f1d426fbe74f9485585d0c7a32e53a', 1675134055174, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('c6e02eb34cd44c71b698ef6b3cbc309b', 1673103451774, '系统日志-删除操作日志', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('c72e3356633745beb9a940c3adaa2553', 1675090046538, '系统人员管理-删除人员账号', '1', 'system_admin', '[\"af39d57668c249fbb42fbef814fcbc26\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('ca23af4cea4b49f0953422356bf90e0e', 1673165488693, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('d0d83a2360d94effb72973288f60d442', 1673328177129, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('d8b52859d9ba4f00b85f10793454ab4d', 1673165400316, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('da972a5c756a42cab25f3d92f2ca35e8', 1673265069889, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('e11c3957c8b5416b9d9bd6f93bbf0f51', 1676196795975, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('e75f64e3f3b54727b2c1f164a2c79147', 1676196813392, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('ef22a28b02524e1bae413caeb18dfbdc', 1673275081692, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('f4a07863d12647a695ece96375bc4a38', 1673275595341, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('f5d55645521b4d2a907f3ac5a382bdc3', 1673261506378, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('ff2c61b6605e45c296f8e87bf54b3ec0', 1673275133984, '支付宝支付-支付', '1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for system_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_role`;
CREATE TABLE `system_admin_role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NULL DEFAULT NULL,
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  INDEX `admin_id`(`admin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_admin_role
-- ----------------------------
INSERT INTO `system_admin_role` VALUES (1, 1, '1');
INSERT INTO `system_admin_role` VALUES (3, 3, '3');
INSERT INTO `system_admin_role` VALUES (10, 2, '2');
INSERT INTO `system_admin_role` VALUES (11, 4, 'b30b183775de476f9081543a712fc9bd');
INSERT INTO `system_admin_role` VALUES (14, 2, '1');
INSERT INTO `system_admin_role` VALUES (15, 2, '4');
INSERT INTO `system_admin_role` VALUES (16, 4, 'd6a2c18b937e448082fa54aad1270e1c');

-- ----------------------------
-- Table structure for system_dist_value
-- ----------------------------
DROP TABLE IF EXISTS `system_dist_value`;
CREATE TABLE `system_dist_value`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL,
  `dist` int NULL DEFAULT NULL,
  `content` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_file
-- ----------------------------
INSERT INTO `system_file` VALUES (1, NULL, NULL, '/', '根目录', NULL, 0, 2, NULL, NULL, 0);
INSERT INTO `system_file` VALUES (2, 1676032532190, 1676032532190, '/upload/c6af713394834cfcaa18d3759f21f0ae.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (3, 1676032705749, 1676032705749, '/upload/b2cd86a736d749a6a6eacf93c9917979.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (4, 1676032918699, 1676032918699, '/upload/4cfb1c0523424ce8b5f147bd33240aa9.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (5, 1676033736482, 1676033736482, '/upload/c9f124b360d3405583745762c3c1dae0.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (6, 1676033769369, 1676033769369, '/upload/80fe1368130c45aaa732d25a92233624.jpg', '微信图片_20220404220338.jpg', '', 1, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (7, 1676037233859, 1676037233859, '/upload/688476f686fb4a0d9ca535ab2d6a69cb.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (8, 1676038200424, 1676040651600, NULL, '测试文件夹1', '1', 0, 2, 1, NULL, 0);
INSERT INTO `system_file` VALUES (9, 1676040265856, 1676040265856, '/upload/b9e16a80ebe94a41bb5fea861c762a99.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 1, 11601, 0);
INSERT INTO `system_file` VALUES (10, 1676040363281, 1676040363281, '/upload/9daf507c1ee848e8816074dbb380af5f.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 8, 11601, 0);
INSERT INTO `system_file` VALUES (11, 1676040923353, 1676040923353, '/upload/89498ec2af7644a29ffafe1806ef3dd6.jpg', '微信图片_20220404220338.jpg', '1', 0, 1, 8, 11601, 0);
INSERT INTO `system_file` VALUES (12, 1676080527906, 1676080527905, NULL, '测试', '1', 0, 2, 8, NULL, 0);
INSERT INTO `system_file` VALUES (13, 1676083505498, 1677667519027, '/upload/51c2e42e93434cbd887323ddd352f925.pdf', '机房巡检机器人的设计要求及功能_张星海.pdf', '1', 0, 1, 1, 568870, 1);

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS `system_login_log`;
CREATE TABLE `system_login_log`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` bigint NULL DEFAULT NULL,
  `login_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pass_word` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ip_addr` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `active` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_login_log
-- ----------------------------
INSERT INTO `system_login_log` VALUES ('056743434da64f878a7c9cffa78eed52', 1642219308012, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('0847930dae8d42ccb60a564d7ed1d22e', 1640253379822, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('0893fec4b768456a81c5a84128497f98', 1673068888060, 'test1', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('09f38b1a7ef94c52b769a0db31fded47', 1638879707657, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('0b293e7afb464848b4a4b897c4012d40', 1641549951087, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('0dbced40cca842239d80e00eeae4e151', 1641620537918, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('0e5f4f754e9a46f38cfa2ac535337c8d', 1673176871941, 'test', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('0f05035a06034c4db5c2ee5ba59388c0', 1641557412231, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('115f146ebb894f148215953d0d3374b9', 1665211201777, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('16838b12a7c24f9b87dbddf52009e567', 1639041960042, 'test1', 'test1', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('1bea0b9282434a5fb75ba24da5510548', 1641645887280, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('1e7a8a22acbe4c88b0a1cf4985ee9556', 1673166933274, 'test', 'test', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('1f309f32b6364d01a76cac15877ddb66', 1638796758106, 'dasd', 'dsad', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('2085b6147c704734967678bd0c2a4f18', 1667056724829, 'test', 'test', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('24d6e57a54c74e18be3bc11840023801', 1665222628109, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('285a43a4aa744f11bdd1fea7859e088e', 1665212054034, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('2ae8dddfeaad4e1cbea8355842ce6554', 1642167223041, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('2e6e739dbbc7438a9af764299474e03c', 1673167588608, 'user', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('304da7befab148c39a0dd6d62e69b3ed', 1640603039152, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('3094428811ed4192bcbd9f976b808496', 1639041914271, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('37d4b9e074de43fd9979b02788914cc4', 1641549915424, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('3b1342ee63e740489cde23611d5a0af0', 1638799241405, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('3c5a541322814087950f7e5bf9b370e5', 1639041817922, 'test', 'test', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('3d26aa45e3024b169bdcab79c847375e', 1673069073450, 'admin', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('3ef67152bb30401caabaeb2ae2b22a1c', 1664638505980, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('3f8e0f30e4b143e78ba522afc0843323', 1641620501381, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('40eb2aa285804adfa8a9a2de8699aa0a', 1652249232789, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('415d139c44cf450594662fc47dfe785d', 1638796202994, 'ads', 'sad', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('42db94df2ae646f1843d6d6ada8848c2', 1669615759360, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('4398f7f457cb41af9aeef950049dfae2', 1673256613445, 'test', 'test', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:108.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76]');
INSERT INTO `system_login_log` VALUES ('447022cb6dbe4661809c125b017f691e', 1638799158372, 'test1', 'test1', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('4630b47d7eef4ea7ad37e371ceb5767b', 1638796292417, 'sad', 'dsad', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('46689029868f4919990b574d9364eb45', 1653639513407, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('4673fc2f7df8430d8b691842a05b7626', 1667044588357, 'test', 'test', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('47041b3a88614f07ae517d55376fd394', 1673158535361, 'root1', 'R#root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('48a1cd0d240c4d0484bf102d3e96ff14', 1673155832388, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('48be8c8faa004935a0f2964f867130cc', 1641986132234, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('492ac01312ab41b8ad6ef02ece32ab54', 1638798260922, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('4ce353dd45514f269f7c3ee574a83f4b', 1640603740620, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('4defb6afd42044748138261ca2357e0d', 1640261532467, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('4f529be9e6e64eda900e86f66adfa69f', 1641552837905, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('5195371032704ba2a8515dc6df1af6be', 1640253369858, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('54ab31000bab4d249fc9663544879d54', 1641550726834, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('55effea0550a4916aa2bf263891037fd', 1638960901050, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('5bd7fc322bd34b7c8450a249b0ffba2d', 1641614747512, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('5c3e2d19ef7c4a1aa876cfa504674279', 1667056829306, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('5c8288b6c5a346da81589ed227d02d99', 1647702963635, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('5dc51a86ad45470a8776a8f62f45f03f', 1652973319055, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('5eeae48f389540e9bffc0ba059435c4b', 1667057241684, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('6007e4b1977f45afb7708d7cbd5aa1f4', 1644985850738, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('619815bd80a24c558f34fd0ec81dafa2', 1639041721858, 'test', 'test', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('66d0bf03d1e6489cb34fb1fae203c902', 1645626074909, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('675533ca85b54f2ab0a86883a65ea416', 1640261540044, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('698e50c1b88144aca467a61ab2e3bf93', 1673167534763, 'test', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('6a59653cf91a49e59376af35507a8d5e', 1638799229477, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('6b23c62fd029495dab1a8dbda733f9cb', 1641552853977, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('6b66ed2886514f2d906e5ce1cd36245a', 1640253273419, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('6d4ad9730a2a48aa92284f0f531d659e', 1673166938021, 'test', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('6e8924feff124e6ea41c05fcbe393a1b', 1638770762762, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('6fc01a1eeb6043a49888d01688370736', 1669617373201, 'user', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('7377d5c5948744c099636eca3a87f1e7', 1673075632102, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('757edb49dfdc4a28acd909a774d1ae7f', 1642222929048, 'aa', 'vv', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('781125e4488648f4adbb86ec26b5403b', 1665035069509, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('7fd9115b3a85468889c49c19c9eaeb4a', 1673500064481, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:108.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76]');
INSERT INTO `system_login_log` VALUES ('829210326e2244099e5b0b0f0138391c', 1641550765307, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('8376ad7f64334d66b11c1e9160446e57', 1673256621428, 'test', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:108.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76]');
INSERT INTO `system_login_log` VALUES ('874e5bd00a504107a64ac1f1278a364a', 1643897238890, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('87de965c0ba24b80bb0bf84470baef9e', 1664638566840, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('88a69e743f5b4197b31fca1de5aaffdd', 1675134730675, 'user', '123456', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:109.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.70]');
INSERT INTO `system_login_log` VALUES ('8983925b32d940f99384ebb89139cfd7', 1641540635047, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('8c63b5dd82c148ac999ccc783bb6df1a', 1642392535942, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('8ccd42e904f5470fa209738133ca4eec', 1640252044765, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('8ecf7231a22e4277b6aa23d803f6918a', 1640259417059, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('8f4d3c531e444523b425fda07a3fdf26', 1638799099354, 'test', 'test', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('8f85e3df843044b7984b54ca12c28eca', 1642258574382, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('9192d18a724045958041d57c1fb18d89', 1673176928361, 'test', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('919f942d88294c6b92eeedce2dc8437c', 1641901294999, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('91d6395e1b4841d4a2df8c01d2793ee7', 1666747951429, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('935079da39374a5b888094d40bc98b11', 1665035388539, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('9501c372080c47a48704e2c030a9c0b0', 1669613929969, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('95b30ae75a804856aa32c9580411e70b', 1638696262970, 'test', 'sssssss', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('965657c015ba4a309b9ad7d70d22958b', 1675135342102, 'admin', 'admin', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:109.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.70]');
INSERT INTO `system_login_log` VALUES ('9900df760da94b74a1d381199ec1f7d0', 1666253989565, 'root', '123456', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('9c12bbd619c54c5f9536624acb266143', 1678546318200, 'admin', 'admin', '127.0.0.1', 1, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 11,浏览器版本:110.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69]');
INSERT INTO `system_login_log` VALUES ('9e018a496d7043178b871b31a92db2a2', 1640599245185, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('9e2c240a0dc64df1a026db09080d82bc', 1642429464429, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('9ecf9fbc4d4c48c58613bdeafd97a3d3', 1641975129286, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('a023e66395b14fdd930a3fdf01a0b1a3', 1664637933688, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('a49bc3ef1a8e4c869af8f6083ab072c0', 1667057168066, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('a65b6f6ec23940128f2936755874b76d', 1641698064960, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('a666e3ff56ca411fae96a1f19dc5ebbe', 1665212223593, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('a89a93f0e4a74c2fb76ff621d923bc40', 1641645898995, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('a95b01b16ccd405a86f16f3ef40da9ef', 1669614436476, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('aa795cb11b0f4f0e9f1abf66cd4f3153', 1641550106326, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('ab77558c9f164dfab2efcf77eeed8828', 1665212314458, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('adfb5c63370642b1bdaeb6142e65d697', 1652456229898, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('af4dedcab90344559d339350cdde8166', 1638696270495, 'asdsa', 'sadsad', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('b141eef039b8434a83654e86663070ec', 1638799107932, 'test', 'test', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('b389460edc25421e9b8d2d71199de3ad', 1640823053755, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('b3fcbea9283d49cd873e2f382ceaf533', 1639042271735, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('b8c4a483b18d4fc48c676e56d24b1da6', 1639041839059, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('bd093e0a95a84d87850b2a2d3477a73a', 1641879153883, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('bffc938a1c6c4675abfca09e671b0155', 1673256597640, 'admin', 'admin', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:108.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76]');
INSERT INTO `system_login_log` VALUES ('c42e4b3365c145d78413d9b316785506', 1644985506006, 'test', 'test', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('c6320d0f52db4037b261b051656a380b', 1638765189448, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('c9454a92d33f4017981be7cb917853d1', 1638960976882, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('ca6a8aef72fd4a9dbdc07bcb562c954f', 1650947901957, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('cdc885cae1c445718ea73edda4477ce1', 1642409774023, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('cdf08676738f433bb339e37648561d09', 1665034627009, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('cee73f34aab341dda64984af8d0e6c92', 1641550776554, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('cef530603587432b9bbda7d6b5fc782f', 1665222505778, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('d371e84c6a0d4b79aeb0a07d533a06ad', 1638696277934, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('d4fc8d9c535e454b934f9cb2b48458ea', 1638796800744, 'dsads', 'dsad', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('d50a66a4c10e447b87e4887fc4a9318a', 1641550142821, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('d54d79b9e8e849f396b1a89fecfd1098', 1641463341667, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('d77c31e6b6ae4d5ca5325433ad2aa77a', 1664638469016, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('d80d396ac59f495bb5ce8008023c91db', 1665035453089, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('d8b4068f56694460898c0bf681654d0f', 1638796185973, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('d9cccdd1ead344d3b0ec86ddd1abcd6a', 1642246628722, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('db17721b87234c7da951a33070ea973b', 1667056823666, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('dd23b8e554cc4f4a9bb4545d61b21651', 1640599271752, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('dd5d10fd4d6c4458bc36a96e8e79cc06', 1647781154781, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('de37ce39baee430e80b459d276476be8', 1665222294278, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('de5d794b93474b0b9a1a38836a311eb6', 1642222955519, 'aa', 'aa', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('e1fb100e24a246fbaf5061338ff49ec6', 1641550148009, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('e50e43dd059343e78c1b61930ab08043', 1667056796361, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('e6a925fd99f3461b99d7b4ab9f4887b2', 1665222199739, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('ea619044b4e446ff989774e99c80fa76', 1641698215408, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('eb89604299494c88afa3d848f7c70930', 1640827734135, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('efd27f8c93b44aa0b1ffb0745fa20113', 1672840436175, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('f0a73a53f6b54e4b9d2d0fa434503a53', 1667057258942, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('f2a6095de4e947cb8dae95c5ac00d66a', 1675134722096, 'user', 'user', '127.0.0.1', 0, '设备类型:COMPUTER,操作系统:Windows 10,浏览器:Chrome 10,浏览器版本:109.0.0.0,浏览器引擎:WEBKIT,用户代理(User-Agent):[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.70]');
INSERT INTO `system_login_log` VALUES ('f56e664be707483c92e0a1b77d71decd', 1652962772974, '1786705138@qq.com', '123456', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('f577edb8436043edab12a4a65c9a68b7', 1667030797702, 'root', 'root', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('f7b7c2ea0b1c478d9355df753a895d2e', 1639043214131, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('f962bb6df6914b8d9966e8c58697b23b', 1638695722932, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('f9e8b508b5344825aa31d157ed1f20c7', 1641550699312, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('fae75a997cb24936bb0dbfdb78b88321', 1640771448464, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('fbcebc75550148ec9b9cb2024ea9ca8e', 1673166895563, 'admin', 'admin', NULL, 0, NULL);
INSERT INTO `system_login_log` VALUES ('fcdc5d5f47dd40e4940a5899fdb25c56', 1665035261586, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('fd373e45aee2419cb1576a691fe801da', 1664638816843, 'user', 'user', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('fe4e64ff844b45a6ab90e02d4831be2e', 1640253525782, 'admin', 'admin', NULL, 1, NULL);
INSERT INTO `system_login_log` VALUES ('fee3f22a60a64ddf915507bd09e3c6fa', 1642432282167, 'admin', 'admin', NULL, 1, NULL);

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` bigint NULL DEFAULT NULL,
  `title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `top` int NULL DEFAULT NULL,
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` bigint NULL DEFAULT NULL,
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_notice
-- ----------------------------
INSERT INTO `system_notice` VALUES ('a3ac8b52c55c4be2875cdf8828f03f9c', 1643538516936, '测试', '测试公告内容', 1, '1', 1666846785677, 1);
INSERT INTO `system_notice` VALUES ('caf654afd61f4c15bee65057af15da90', 1675091436660, '测试112233', '<p>这是初始化内容</p>', 0, '1', 1675091436660, 1);
INSERT INTO `system_notice` VALUES ('e7bf3bd8117f44fd9f9741cac47c095a', 1643538764273, '二饭管理系统', '<p>测试测试111</p><p><br></p><p>测试测试<img src=\"http://127.0.0.1:88//upload/2bac2ebdb87d4f2799be2c8895ba7935.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', 1, '1', 1673103279919, 0);

-- ----------------------------
-- Table structure for system_resources
-- ----------------------------
DROP TABLE IF EXISTS `system_resources`;
CREATE TABLE `system_resources`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `url` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pid` int NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL,
  `path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_name`(`role_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `system_role` VALUES (1, '超级管理员', 1);
INSERT INTO `system_role` VALUES (2, '一级管理员', 0);
INSERT INTO `system_role` VALUES (3, '二级管理员', 0);
INSERT INTO `system_role` VALUES (4, '用户', 0);
INSERT INTO `system_role` VALUES (13, '123', 1);
INSERT INTO `system_role` VALUES (14, '123', 1);
INSERT INTO `system_role` VALUES (15, '345', 1);

-- ----------------------------
-- Table structure for system_role_resources
-- ----------------------------
DROP TABLE IF EXISTS `system_role_resources`;
CREATE TABLE `system_role_resources`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NULL DEFAULT NULL,
  `resource_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_role_resources
-- ----------------------------
INSERT INTO `system_role_resources` VALUES (51, 3, 23);
INSERT INTO `system_role_resources` VALUES (52, 3, 30);
INSERT INTO `system_role_resources` VALUES (53, 3, 31);
INSERT INTO `system_role_resources` VALUES (54, 3, 33);
INSERT INTO `system_role_resources` VALUES (55, 3, 34);
INSERT INTO `system_role_resources` VALUES (56, 3, 35);
INSERT INTO `system_role_resources` VALUES (57, 3, 66);
INSERT INTO `system_role_resources` VALUES (58, 3, 67);
INSERT INTO `system_role_resources` VALUES (59, 3, 75);
INSERT INTO `system_role_resources` VALUES (60, 3, 78);
INSERT INTO `system_role_resources` VALUES (61, 3, 80);
INSERT INTO `system_role_resources` VALUES (62, 3, 83);
INSERT INTO `system_role_resources` VALUES (63, 2, 26);
INSERT INTO `system_role_resources` VALUES (64, 2, 31);
INSERT INTO `system_role_resources` VALUES (65, 2, 4);
INSERT INTO `system_role_resources` VALUES (66, 2, 78);

-- ----------------------------
-- Table structure for system_version_log
-- ----------------------------
DROP TABLE IF EXISTS `system_version_log`;
CREATE TABLE `system_version_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL,
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `info` varchar(8098) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统版本日志' ROW_FORMAT = Dynamic;

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
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` bigint NULL DEFAULT NULL,
  `update_time` bigint NULL DEFAULT NULL,
  `begin_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `end_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `state` int NULL DEFAULT NULL,
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '访问白名单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_white_list
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
