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

 Date: 15/06/2023 15:31:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_admin
-- ----------------------------
DROP TABLE IF EXISTS `system_admin`;  
CREATE TABLE `system_admin`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `login_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户名',
  `pass_word` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `status` int NULL DEFAULT 0 COMMENT '状态',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '账号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_admin
-- ----------------------------
INSERT INTO `system_admin` VALUES ('1', 'super', '7063a3d5f1aa1ff89acb8e1ac78b9854', '超级管理员', 0, 1642437031000, NULL, 0);
INSERT INTO `system_admin` VALUES ('3afbb7acb1f44c2ab342ce3a96a4a20b', 'wqe', 'b75f1bc9cb2a9e64aabc4dc9bf1bb58c', 'qwe', 1, 1675134055175, NULL, 0);
INSERT INTO `system_admin` VALUES ('4', 'admin', 'fcc304f79dc800ad44f7e09732efa97e', '管理员A', 0, 1642437031000, NULL, 0);
INSERT INTO `system_admin` VALUES ('4e1c5efda31c4eb492a7c6db63140e94', '2222', 'b75f1bc9cb2a9e64aabc4dc9bf1bb58c', '1111', 0, 1675082850341, NULL, 1);
INSERT INTO `system_admin` VALUES ('81b333e77e854eb0b3f0a5f0eb5b50a3', '2222', 'b75f1bc9cb2a9e64aabc4dc9bf1bb58c', '1111', 0, 1675005268549, NULL, 1);
INSERT INTO `system_admin` VALUES ('af39d57668c249fbb42fbef814fcbc26', 'test1', '033e997f49e0cff004e70b09303f670a', 'test1', 0, 1673068864547, NULL, 1);
INSERT INTO `system_admin` VALUES ('b30b183775de476f9081543a712fc9bd', 'user', '033e997f49e0cff004e70b09303f670a', '用户A', 0, 1642437031000, NULL, 0);
INSERT INTO `system_admin` VALUES ('d945f59477cc41c681a85218ea99ac92', 'test', '033e997f49e0cff004e70b09303f670a', 'test', 1, 1647584357530, NULL, 0);
INSERT INTO `system_admin` VALUES ('effee63edb324b0684cb37c202a3d7e0', '123456', '033e997f49e0cff004e70b09303f670a', '123456', 0, 1682062125841, NULL, 0);

-- ----------------------------
-- Table structure for system_admin_department
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_department`;
CREATE TABLE `system_admin_department`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `department_id` int NULL DEFAULT NULL COMMENT '部门编号',
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`department_id` ASC) USING BTREE,
  INDEX `admin_id`(`admin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门用户关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_admin_department
-- ----------------------------
INSERT INTO `system_admin_department` VALUES (1, 1, '1', 0);
INSERT INTO `system_admin_department` VALUES (3, 3, '3', 0);
INSERT INTO `system_admin_department` VALUES (10, 2, '2', 0);
INSERT INTO `system_admin_department` VALUES (11, 4, 'b30b183775de476f9081543a712fc9bd', 0);
INSERT INTO `system_admin_department` VALUES (14, 2, '1', 0);
INSERT INTO `system_admin_department` VALUES (15, 2, '4', 0);
INSERT INTO `system_admin_department` VALUES (16, 4, 'd6a2c18b937e448082fa54aad1270e1c', 0);
INSERT INTO `system_admin_department` VALUES (24, 2, 'd945f59477cc41c681a85218ea99ac92', 0);

-- ----------------------------
-- Table structure for system_admin_dist
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_dist`;
CREATE TABLE `system_admin_dist`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典名称',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典描述',
  `logo` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_admin_dist
-- ----------------------------
INSERT INTO `system_admin_dist` VALUES (1, 1664092965734, '性别', '性别选项', 'SYSTEM_SEX');
INSERT INTO `system_admin_dist` VALUES (2, 1664097012604, '天气', '天气字典', 'SYSTEM_WEATHER');
INSERT INTO `system_admin_dist` VALUES (6, 1681227558864, '调动状态', '调动状态', 'RSDDZT');

-- ----------------------------
-- Table structure for system_admin_info
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_info`;
CREATE TABLE `system_admin_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `admin_sex` int NULL DEFAULT NULL COMMENT '性别',
  `admin_phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `admin_email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `home_place` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住址',
  `contact_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系地址',
  `admin_note` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_id`(`admin_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

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
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `active` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作内容',
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `table_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作表',
  `target_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作数据',
  `ip_addr` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_admin_log
-- ----------------------------
INSERT INTO `system_admin_log` VALUES ('04af25ce32d541489cad9caf815699a1', 1675093157551, '系统角色-删除角色', '1', 'system_role', '[13]', NULL);
INSERT INTO `system_admin_log` VALUES ('056658325e2d4d10b8bf430b31bee9d4', 1681212455095, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('07e8f9cb6a264b0f805c9417d4f33fdf', 1683169119111, '访问白名单管理-删除数据', '1', 'system_white_list', '[5]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('08fdc4d33f18490785253d25daed1e49', 1675132966352, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('096e19563f994ea6b58c6ad30152aa63', 1681261370060, '系统部门-添加人员到指定部门，可多人员', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('0f300e714bef4f97a643121366fd9197', 1673162949507, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('100263a71fef4e9f8f7962e83b62a1b5', 1681264729974, '系统部门-添加人员到指定部门', '1', NULL, NULL, '127.0.0.1');
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
INSERT INTO `system_admin_log` VALUES ('29e54b92b1394c3297668180eed5896d', 1681212625967, '系统角色-编辑角色', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('2aba439ebe9241018309ca8031f21af1', 1673165423023, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('2c5b1fa1473c4ff08b07ec3a36f75474', 1673327856979, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('2d553da37f1c4c828be8dca0ffa5c72b', 1683168066561, '访问白名单管理-删除数据', '1', 'system_white_list', '[3]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('354c7db041f140f7b5f2effb4bf5244d', 1681212636513, '系统角色-编辑角色', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('36d640ca4cbe4051b216fe4dac4eea37', 1681262962359, '系统部门-添加人员到指定部门，可多人员', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('39a1032ba1df4da9bda10e4f78f86cf7', 1683167167283, '访问白名单管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('3ad616ca334f4832992b83667d12d9f5', 1682062125837, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');
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
INSERT INTO `system_admin_log` VALUES ('6961e3260eff4f5fb462664bc63fc2c0', 1681214212820, '系统角色-编辑角色', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('69a3a715c5424073b6eb545752102eca', 1683168768847, '访问白名单管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('6a89a910916443d886f43b5747d4d256', 1678546856872, '测试表-更新数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('6c8d5e685cb14309b4ee15fca85094f8', 1675344959709, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('72bddeaf36ba41f08b4c98f5d66baeba', 1676006787501, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('73c10613db304ed7b6395571a256cd10', 1675082850338, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('7528b902d95c457e9b7a994ba429153a', 1676037277646, '文件管理-删除数据', '1', 'system_file', '[6,5,4,3,2]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('75e317c030384b1bb526f80021827dc4', 1675092919101, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('761503ebf6c1442c9d93a1fff58b4c24', 1675092742057, '系统角色-编辑角色', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('769a631da1ab4a03942c354067805740', 1675134028445, '系统角色-删除角色', '1', 'system_role', '[14]', NULL);
INSERT INTO `system_admin_log` VALUES ('79ea5263cf634d34876ec7707799cc8f', 1680526942337, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('7a725c2a5d844e1fb5a4626d24faa34e', 1675090009779, '系统日志-删除操作日志', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('7bcd66a177d0413c85e7aefb433ba49d', 1682061746910, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('7eeb173ab6b9432a941df4faf9d38c99', 1675091032270, '系统角色-删除角色', '1', 'system_role', '[5]', NULL);
INSERT INTO `system_admin_log` VALUES ('80e0e768b8124577be4f81dfbc10d8b2', 1673158605712, '系统字典-新增数据', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('83850e76ff3044dd8b883a527dce1471', 1681227558852, '系统字典-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('84a983b4c7734f9ea71c14e5d60de0d4', 1676200798906, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('898126c058724ad5b06df138d7d65c35', 1681261325366, '系统部门-添加人员到指定部门，可多人员', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('8c085b5a81dc489d900a62a1827eb11d', 1673167570281, '添加人员-[d945f59477cc41c681a85218ea99ac92]-到角色-2', 'd945f59477cc41c681a85218ea99ac92', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('8d0a2241f1724de1a2363e3f83a8e311', 1673155820964, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('92087d89fd1a4b12a630261aebd7bc7c', 1675091436658, '通知公告-添加通知', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('93a22fc0c5af46f8bd3d8020b54d8b08', 1679457904273, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
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
INSERT INTO `system_admin_log` VALUES ('b3a27137575e4f17babd4402392dab0a', 1682061826544, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('b4f66ecfb5b94daa994813e2e41d786e', 1673177413692, '系统人员管理-添加人员账号', 'd945f59477cc41c681a85218ea99ac92', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('b5dd4c826e8f42da92fff6252f491584', 1673325955552, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('b5e1629e569d4bb3b56e50941ec996d7', 1681212593014, '系统角色-编辑角色', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('b7351b41d77d49e49f230d8e6627b5f8', 1680529815373, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('b741d89c3fc54db9bc4ae4d16bdeefc7', 1673500427869, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('bc4d9f25c519488a9e043694d61a93ee', 1681214216314, '系统角色-编辑角色', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('bded7ef7eee04e0bba6f2fb9ac4287f6', 1673165247844, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('c2e27f0700ae4b888ee670f9d0fce5ce', 1676040651595, '文件管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('c3008153100b45928fb13061d6eb61ab', 1681212615308, '系统角色-编辑角色', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('c4d56d9a7687433593b50da92582a998', 1675163332067, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('c5f1d426fbe74f9485585d0c7a32e53a', 1675134055174, '系统人员管理-添加人员账号', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('c6e02eb34cd44c71b698ef6b3cbc309b', 1673103451774, '系统日志-删除操作日志', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('c72e3356633745beb9a940c3adaa2553', 1675090046538, '系统人员管理-删除人员账号', '1', 'system_admin', '[\"af39d57668c249fbb42fbef814fcbc26\"]', NULL);
INSERT INTO `system_admin_log` VALUES ('ca23af4cea4b49f0953422356bf90e0e', 1673165488693, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('cf925a5040f346ad89a5225835a173f2', 1682089625441, '系统角色-更新角色权限', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('d0d83a2360d94effb72973288f60d442', 1673328177129, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('d8b52859d9ba4f00b85f10793454ab4d', 1673165400316, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('da972a5c756a42cab25f3d92f2ca35e8', 1673265069889, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('e11c3957c8b5416b9d9bd6f93bbf0f51', 1676196795975, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('e21f74eb39ef408fb5d3cd675a1a53e0', 1683168466700, '访问白名单管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('e75f64e3f3b54727b2c1f164a2c79147', 1676196813392, '系统菜单资源-编辑或添加资源', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('e82741ceaaa4471c86b4ccfec743b61f', 1681264590369, '系统部门-从部门移除人员', '1', 'system_department', '[\"d945f59477cc41c681a85218ea99ac92\"]', '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('ef22a28b02524e1bae413caeb18dfbdc', 1673275081692, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('efc483804e754f7fb0c1233c894fe5c4', 1682062663655, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('f4a07863d12647a695ece96375bc4a38', 1673275595341, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('f5d55645521b4d2a907f3ac5a382bdc3', 1673261506378, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('f70b199751664764be9b80c12ee9c598', 1683168748423, '访问白名单管理-新增数据', '1', NULL, NULL, '127.0.0.1');
INSERT INTO `system_admin_log` VALUES ('ff2c61b6605e45c296f8e87bf54b3ec0', 1673275133984, '支付宝支付-支付', '1', NULL, NULL, NULL);
INSERT INTO `system_admin_log` VALUES ('ffab0808c6784d29b9169fcd01a36a76', 1681263245953, '系统人员管理-添加人员账号', '1', NULL, NULL, '127.0.0.1');

-- ----------------------------
-- Table structure for system_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `system_admin_role`;
CREATE TABLE `system_admin_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int NULL DEFAULT NULL COMMENT '角色编号',
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户编号',
  `deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  INDEX `admin_id`(`admin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_admin_role
-- ----------------------------
INSERT INTO `system_admin_role` VALUES (1, 1, '1', 0);
INSERT INTO `system_admin_role` VALUES (3, 3, '3', 0);
INSERT INTO `system_admin_role` VALUES (10, 2, '2', 0);
INSERT INTO `system_admin_role` VALUES (11, 4, 'b30b183775de476f9081543a712fc9bd', 0);
INSERT INTO `system_admin_role` VALUES (14, 2, '1', 0);
INSERT INTO `system_admin_role` VALUES (15, 2, '4', 0);
INSERT INTO `system_admin_role` VALUES (16, 4, 'd6a2c18b937e448082fa54aad1270e1c', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_department
-- ----------------------------
INSERT INTO `system_department` VALUES (1, '超级管理员', 1);
INSERT INTO `system_department` VALUES (2, '研发', 0);
INSERT INTO `system_department` VALUES (3, '行政', 0);
INSERT INTO `system_department` VALUES (4, '安保', 0);
INSERT INTO `system_department` VALUES (13, '123', 1);
INSERT INTO `system_department` VALUES (14, '123', 1);
INSERT INTO `system_department` VALUES (15, '345', 1);
INSERT INTO `system_department` VALUES (16, '商务', 0);

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
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标用户编号',
  `deleted` tinyint NULL DEFAULT 0,
  `deploy_id` int NULL DEFAULT NULL COMMENT '部门编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '人事调动记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_deploy_log
-- ----------------------------
INSERT INTO `system_deploy_log` VALUES (1, 1681264735346, 1681264735346, '1', '移入', 'd945f59477cc41c681a85218ea99ac92', 0, 2);

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
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `create_time` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `top` int NULL DEFAULT NULL COMMENT '置顶状态',
  `admin_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人',
  `update_time` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告通知表' ROW_FORMAT = DYNAMIC;

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
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资源路径',
  `pid` int NULL DEFAULT NULL COMMENT '上级菜单',
  `sort` int NULL DEFAULT NULL COMMENT '菜单排序',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `type` int NULL DEFAULT NULL COMMENT '菜单类型',
  `path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单路由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单资源表' ROW_FORMAT = DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_name`(`role_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

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
  `role_id` int NULL DEFAULT NULL COMMENT '角色编号',
  `resource_id` int NULL DEFAULT NULL COMMENT '菜单编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色菜单关系表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `system_role_resources` VALUES (67, 2, 23);
INSERT INTO `system_role_resources` VALUES (68, 2, 26);
INSERT INTO `system_role_resources` VALUES (69, 2, 30);
INSERT INTO `system_role_resources` VALUES (70, 2, 31);
INSERT INTO `system_role_resources` VALUES (71, 2, 4);

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
