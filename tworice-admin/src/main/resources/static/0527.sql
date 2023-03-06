CREATE DATABASE  IF NOT EXISTS `erfan_admin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `erfan_admin`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: erfan_admin
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` varchar(64) NOT NULL,
  `login_name` varchar(64) DEFAULT NULL,
  `pass_word` varchar(64) DEFAULT NULL,
  `nick_name` varchar(24) DEFAULT NULL,
  `status` int DEFAULT '0',
  `date` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('1',NULL,NULL,'超级管理员',0,1642437031000),('4','admin','admin','管理员A',0,1642437031000),('b30b183775de476f9081543a712fc9bd','user','user','用户A',0,1642437031000),('d945f59477cc41c681a85218ea99ac92','test','test','test',0,1647584357530);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_log`
--

DROP TABLE IF EXISTS `admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_log` (
  `id` varchar(64) NOT NULL,
  `time` bigint DEFAULT NULL,
  `active` varchar(128) DEFAULT NULL,
  `admin_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_log`
--

LOCK TABLES `admin_log` WRITE;
/*!40000 ALTER TABLE `admin_log` DISABLE KEYS */;
INSERT INTO `admin_log` VALUES ('007041a85cf74acabe200d8872214df3',1642437160425,'删除人员账号-[5ec2fd70a5bc405e844250af08ac3117]','1'),('0109f03b8ac9468a8900b103539b9951',1653034545243,'添加/更新一个人员账号信息','1'),('05d1bfa8301a437fbebfbf15ff62a676',1642250670128,'删除1条资源','1'),('06008bb1ce3c422eb17ef8f00cb2e90e',1644985477361,'更新角色-2-权限为[23, 26, 31, 4, 66, 67]','1'),('08945eecca2149c5a2fd5b18485e9043',1653034635224,'添加/更新一个人员账号信息','1'),('09390d69197b4df7896997664f2ccc6f',1652770581128,'删除人员账号-[4c0dad2875264541ac5a348f3f7e205c]','1'),('09be828b18534aacb289237693e71d82',1647600448497,'删除1条资源','1'),('0f4c8ff1f0e94a329bb6f1f109ff4606',1642247450098,'删除1条资源','1'),('111fec2d9fff42c4852f07c01f557820',1641986241404,'删除1条资源','1'),('14b9a86f589747d3bc53c4f9de72fd2c',1647599898798,'添加/更新资源信息-测试页','1'),('1605f61b727c41eba2c3437d3ae6ccc8',1652770571403,'删除人员账号-[acc1e55f0e7f4d08bc08f5c5996c6846]','1'),('160cb784eb974bd6bd51078b833d442a',1644943611401,'添加/更新资源信息-开发示例','1'),('18727cce100441329da40593ebe54aef',1641985090047,'删除1条资源','1'),('19cf0e7f1d7942149d542edc8d6f4b3a',1642247595567,'添加/更新资源信息-test','1'),('1bfdc45e9d5f49e9ae1d892f56eebf5b',1644997149739,'添加/更新资源信息-废品信息','1'),('22be26cd7de74eb0acfaf222046cb904',1642258696145,'删除1条资源','1'),('2574701c23864c16a0cab5cc7d50c714',1642258543080,'添加/更新资源信息-测试','1'),('2714c9ba1b47415fbaba9b28d1147847',1652770575173,'删除人员账号-[3d0f112067cb469eb5a42566f705378b]','1'),('28344e5631b640f2aac2669668c7e944',1641983984533,'删除1条资源','1'),('2a13a304cb2f4ddda342d502a98ff277',1653017530491,'添加/更新一个人员账号信息','1'),('2b134d04bc6a46139c2b8cb89b103a1d',1641984727534,'添加/更新资源信息-测试','1'),('2f22a54fc8794d3cabfd45ec1767751c',1644981722226,'添加/更新资源信息-跳转页面','1'),('30886fa2ec604a9b8bb996000a7a2d5c',1652770576665,'删除人员账号-[9325299e3c29416abc4e9735c7a08b0c]','1'),('31763c5ab75b4a48b72deb8d243e293c',1653034668458,'添加人员-[746874601ad1419cb66a19009a52a6e2, bf47f4bf03044c11a8c605dc4a234f88]-到角色-4','1'),('31d5d99e26b547d8ab625c58a9cc4d64',1642250688912,'添加/更新资源信息-测试','1'),('32dda69665224403a7ed0ba54e94079d',1641983922661,'删除1条资源','1'),('34adc3e010394f499e3a5e26232cbb2a',1642431861526,'删除1条资源','1'),('3549aa54bcae48c6bbde57042e6dc26a',1642437140335,'添加/更新一个人员账号信息','1'),('36339e8e0a564eaa96e73ad711b43d7b',1652973757971,'删除人员账号-[fa09e3acc4f140baaa940aeeaf853176, d6a2c18b937e448082fa54aad1270e1c]','4'),('37b2289dd01b4d0085f3bf9aeeeba1e2',1653034631568,'添加/更新一个人员账号信息','1'),('399dce58ab6a402e8f4a0d47db62347d',1641985892773,'删除1条资源','1'),('3b98bf2120044232aba78b55a834475d',1652770573507,'删除人员账号-[411813b5ea78489b966d40b4b20b8f9d]','1'),('3d5ad3631f994d37bcb9eca4840ce947',1652770391423,'添加/更新一个人员账号信息','1'),('4213ad9f324645488a524f0918e262ad',1642248483214,'删除1条资源','1'),('42d65c4e75ce403181627def11247004',1653034829255,'删除1条资源','1'),('43b32d9a796b42c78c135548ed662c51',1642247305272,'添加/更新资源信息-test','1'),('441ea53ca2314f00b183ef5b3ff998ef',1653034690451,'删除人员账号-[746874601ad1419cb66a19009a52a6e2, bf47f4bf03044c11a8c605dc4a234f88]','1'),('4697df69944e43eea1af653fbec0da82',1652770396175,'添加/更新一个人员账号信息','1'),('48ee0fee79f54c9ea782be33ebcbe3b1',1643538643005,'设置置顶公告-e7bf3bd8117f44fd9f9741cac47c095a','1'),('49910a7b18ec42b68df404102c1484d0',1652770582457,'删除人员账号-[3f6919ba5872408aa544c374181cd2e0]','1'),('4b3191bf7cf049348b526fc34c31ad1a',1645695455754,'添加/更新资源信息-测试','1'),('4deb55d12c334b03be946c065cb3369b',1647594774853,'删除人员账号-[3]','1'),('4f55932c9a6044a384bad0f7349cc26e',1644978909646,'添加/更新资源信息-富文本组件','1'),('50634bcf46984c75aff3e590f5856bd7',1642437111807,'添加人员-[1]-到角色-2','1'),('53e405dbee0f483b9854450b7d9e5fcd',1642782238924,'添加/更新资源信息-系统工具','1'),('54dd9fbc84d04507bfb78c4a07a03dae',1641985209298,'添加/更新资源信息-测试','1'),('556dc2c54ae5401a8b283780a97c25de',1647594763458,'删除人员账号-[875e0725b20a4bc3b905a6ffa9c5998a]','1'),('5816e7952e7c467c98e8a234c9640e7a',1642250673414,'删除1条资源','1'),('58efc11a531347a0b1875164e90d461c',1642250671953,'删除1条资源','1'),('59549c5969444468b544b8fad9302c0a',1652770388641,'添加/更新一个人员账号信息','1'),('59c8bfc86706449f8c55536eb5f7ad31',1652770579529,'删除人员账号-[a894aba07ab44fd9a15ec6b6a118c844]','1'),('5a1a04ea828542768834e54eb3c0df85',1641986077325,'添加/更新资源信息-测试','1'),('5c193e126e8d4fd8a04bb5c264bf824e',1642250604651,'添加/更新资源信息-测试1','1'),('5c87152a552f45ba826a27bad1032a53',1642250724833,'删除1条资源','1'),('5d38da640c4640d78f13ea9ed06aac8d',1652250803957,'删除1条资源','1'),('5d51363b792642189efd0d9f00b55e45',1653034657286,'添加/更新一个人员账号信息','1'),('6215a0acfca34156969e8b761f76d09f',1644998475535,'删除1条资源','1'),('6459d2396dbb423581c0a7647ec9e9af',1642431857765,'删除1条资源','1'),('64db33ead9b44782a53797d902e293de',1643538769642,'设置置顶公告-e7bf3bd8117f44fd9f9741cac47c095a','1'),('659127fbbe47451791e01369639fd8dd',1644997227545,'添加/更新资源信息-订单信息','1'),('6812c5c971d743ab9936bb59ed3a9b61',1642435242169,'删除1条资源','1'),('691e434d444142d38f2585d637471a57',1643538616489,'更新公告信息-e7bf3bd8117f44fd9f9741cac47c095a','1'),('6985fdebbd6b4560a5b0a24969dc083f',1647595776829,'删除人员账号-[f3d8b40525784edf9c0bf5180504f665]','1'),('6a7f997b604c4619af1a911b11e192e7',1653034619021,'删除人员账号-[9a547cf185b645d0a454e6c3d9628a97]','1'),('6adb26c5b98f44ce93e146b282879d9a',1652770402676,'添加/更新一个人员账号信息','1'),('6b0f504aa801465f852d35a523223714',1652797115825,'添加/更新资源信息-版本日志','1'),('6f7124c81bb44f98a07fd52706ae0eb9',1652770569771,'删除人员账号-[eef534ac6a2e4135a1d14de582cf8958]','1'),('77fe6bd017824d6aae8838f2998f1bf2',1644985835300,'添加人员-[4]-到角色-2','1'),('784aa84ddae74b5aa2ff97a0cefe4126',1652770398196,'添加/更新一个人员账号信息','1'),('79c57189c1d049bab436a0ded70ab6ec',1642429400422,'添加/更新资源信息-测试','1'),('7a77b1617dde405995da20804fb2ca6b',1647595778688,'删除人员账号-[fecae5ce63ee41a7ab8d3f258db2d62f]','1'),('7b88b37631bd4b48b11a59403538d112',1653034641083,'删除人员账号-[0cda60bd6d444414bd67637844658b94, 8be4f08777d143afaf42a6c16af54237]','1'),('7eaa2dab0bd146cbb9d8c791577762e8',1653018280649,'添加/更新资源信息-信息管理','1'),('7f748b4c338a4a4daa24fb240388e986',1647509359853,'添加/更新资源信息-文件上传','1'),('80ae528d37ec48a4bc3fed349cf3cf12',1653017536913,'添加/更新一个人员账号信息','1'),('85d7a28eb19c441489244467af303957',1647601317526,'删除1条资源','1'),('88c88531ed1c43048185b1fb07dc0411',1647596950029,'添加/更新资源信息-测试','1'),('8908c6f8c7c941a596834777dc18711d',1642782193297,'添加/更新资源信息-信息管理','1'),('8930407921624bc09d01c0c509080404',1650942522762,'添加/更新资源信息-在线账户','1'),('8b28b62db9bb44e59dd036b60dc40333',1642437098987,'添加/更新一个人员账号信息','1'),('8f8868f56b954981b44cd37960232098',1642250362807,'添加/更新资源信息-测试','1'),('9044a65a2bc34320ba238b3e09288a0c',1642437152937,'添加/更新一个人员账号信息','1'),('916ecbeb08224b34a167c4bfe75c4a55',1647595774904,'删除人员账号-[8da968a828234824a8f7b5f40cc0aeb1]','1'),('917f06e2ee27473c9e892329e6d98ded',1652770407014,'添加/更新一个人员账号信息','1'),('91db20bb443640db807adbceba9cc8f9',1652770393850,'添加/更新一个人员账号信息','1'),('95ab725648d64b91bde813c8ade811fd',1647508260689,'添加/更新资源信息-数据导入','1'),('9686dd4e6bf04031a796dc775890c6c7',1644985789064,'更新角色-2-权限为[26, 31, 34, 4, 66, 67]','1'),('97811bfe34f945199e5057fe2fe34fae',1647601319826,'删除1条资源','1'),('9c5ba8456bb54533833e1aaaa5440838',1653018276174,'添加/更新资源信息-信息管理1','1'),('9d42baeafaa942db900350fb910e22c2',1653034798230,'更新角色-2-权限为[26, 31, 34, 4, 66, 67, 81]','1'),('9e7dab9428d543289acca61fd7840278',1643538764273,'更新公告信息-e7bf3bd8117f44fd9f9741cac47c095a','1'),('9f54f678f0764f199d35259a55c7ec0c',1642432200222,'添加/更新资源信息-测试','1'),('9fbfd735017f4581ac2194a3c2c3604f',1644998489467,'删除1条资源','1'),('a0aa0aa291994207a6a0a772eb94d8f6',1647584325877,'删除人员账号-[2]','1'),('a6a0acc5f1e1425e82860954e1de9996',1644998478600,'删除1条资源','1'),('a7fdaa7c4f9944dbb967ce2d79c3523c',1643538516937,'更新公告信息-a3ac8b52c55c4be2875cdf8828f03f9c','1'),('a900329aa61543ce95bcd6c0a1c8bb26',1653034758992,'添加/更新资源信息-1','1'),('accd7b1dfdce47fa8c45695d66acf9d7',1653295693935,'删除人员账号-[6f07d55499cd4af8b6322fc20b6bf5af, f1f30345267b49129f73f9f3527006db, d6ae849fa6e94262b3157e077aeec1df]','1'),('b2f4349f38bb4e3e98cae3e8c3d4f215',1642782210023,'添加/更新资源信息-公告管理','1'),('b424a9eade614a84ab64e5affce90ba9',1653296548140,'添加/更新资源信息-测试','1'),('bc3ed6da6dc04fd2970a6797020ce25c',1653296892251,'删除1条资源','1'),('bc681092e9f9436dbd2013f047615fb4',1653034554677,'添加人员-[9a547cf185b645d0a454e6c3d9628a97]-到角色-4','1'),('bd2b5d877c9e42138623b6b5f9e625f8',1652249000616,'添加/更新资源信息-测试','1'),('c3b38824102e44f4b0ef9caa9dd05529',1647594827789,'删除人员账号-[061f01ac958a4d43bd316410a6dae264]','1'),('c567b875631a4895a274d022fd0eb351',1647594834897,'删除人员账号-[e577e82a414b4df0bbf7ec7edbb74fd3]','1'),('c75114e57a6e4778a412eaf40d4377a8',1652770400593,'添加/更新一个人员账号信息','1'),('c8949ad8ac8748dfb0815bccf9d231fa',1645695702774,'删除1条资源','1'),('ca54e59e039a4fada149470cd4d51273',1642437220983,'更新角色-2-权限为[23, 26, 31, 4]','1'),('cdbdddba353a41dd9ca46be9cfb3a26b',1641985088168,'删除1条资源','1'),('cf16eeaffc33471298f5b6501a3b60b3',1642782223614,'添加/更新资源信息-日志管理','1'),('cf37ea7d44c747fab6b4970d26fbb0ac',1642248723385,'添加/更新资源信息-test','1'),('cf587853accb4deeae2a7150aa1e50ff',1647594837079,'删除人员账号-[f035c615da544e60ae0a9d449f24b744]','1'),('d24c16fa46674cc0b6db4b1d12558f51',1642249121561,'添加/更新资源信息-test','1'),('d25083b42b0d43558a1b2da07759c6fb',1644998493932,'删除1条资源','1'),('d2988dc49f354accb41a2d63a0d3294d',1641984000746,'添加/更新资源信息-测试','1'),('d40524a678914d4fa2d100c1d91a1a42',1647584357530,'添加/更新一个人员账号信息','1'),('d89a929b07994e66b5c8986589f2bd5a',1647594750341,'删除人员账号-[42f22cb0e86048d3a90dc968d957ea39]','1'),('d97a3db97bfb48dab6da2431b4a889bb',1641983947014,'添加/更新资源信息-测试','1'),('d9e99c14e2b243fe9e9ba36b13635704',1644985798981,'更新角色-3-权限为null','1'),('d9f4da94c9104836995d72876fb0fa83',1642249097881,'删除1条资源','1'),('db45dd534c194ca1be82030661a01c5b',1641984817504,'添加/更新资源信息-测试','1'),('dba310ecb5b04c55877b28a9496f1d6a',1642429446018,'添加/更新资源信息-测试','1'),('dd1cafa6f54e4ca39271a46c91e2565c',1641986063602,'删除1条资源','1'),('dfd40a6b516d4dcc8964fbb22360d150',1652770404918,'添加/更新一个人员账号信息','1'),('e427fade52764faa84c3e5387363f6ec',1641985908534,'添加/更新资源信息-测试','1'),('e55a0961b7de47b29f0260c799234dfe',1644997177539,'添加/更新资源信息-用户信息','1'),('e6faf8dbaed0487c8af4c51cfb60508d',1641984703052,'删除1条资源','1'),('e732cf94fa8f408fa65ba042d0e94861',1644997244987,'添加/更新资源信息-账单信息','1'),('e7486427df5a48edb9c45ea1a0a49131',1647594747970,'删除人员账号-[2cf9319f20484027af12b90b6e06eb60]','1'),('efe6ddd1871742c584508cecd5bf7207',1652973750951,'添加/更新一个人员账号信息','4'),('f18bc4ecf5c84ec8a095321a53bd9f3e',1641983882215,'添加/更新资源信息-测试','1'),('f2607de39cce49a79908a3781adc6b21',1653034660430,'添加/更新一个人员账号信息','1'),('f419f3a0148646d1aab25ee5f4f938e4',1642782096489,'添加/更新资源信息-系统管理','1'),('f894eed374b845789c95343edaffed1b',1652770578077,'删除人员账号-[9009c25d6b02466eb2de87aeca9756a2]','1'),('f94884d977754bb8895be5a4a15ba0a5',1644998491664,'删除1条资源','1'),('fd4f493e79104d0ab83f762888149e51',1647594766053,'删除人员账号-[d0748b43585f4724b996ffefb25e5cab]','1'),('fd8d505ee5cb4e7eac0135e414798531',1644997126861,'添加/更新资源信息-废品分类','1');
/*!40000 ALTER TABLE `admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role`
--

DROP TABLE IF EXISTS `admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int DEFAULT NULL,
  `admin_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role`
--

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;
INSERT INTO `admin_role` VALUES (1,1,'1'),(3,3,'3'),(10,2,'2'),(11,4,'b30b183775de476f9081543a712fc9bd'),(14,2,'1'),(15,2,'4'),(16,4,'d6a2c18b937e448082fa54aad1270e1c');
/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_log`
--

DROP TABLE IF EXISTS `login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_log` (
  `id` varchar(64) NOT NULL,
  `time` bigint DEFAULT NULL,
  `login_name` varchar(45) DEFAULT NULL,
  `pass_word` varchar(45) DEFAULT NULL,
  `ip_addr` varchar(45) DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_log`
--

LOCK TABLES `login_log` WRITE;
/*!40000 ALTER TABLE `login_log` DISABLE KEYS */;
INSERT INTO `login_log` VALUES ('056743434da64f878a7c9cffa78eed52',1642219308012,'admin','admin',NULL,1),('0847930dae8d42ccb60a564d7ed1d22e',1640253379822,'admin','admin',NULL,1),('09f38b1a7ef94c52b769a0db31fded47',1638879707657,'admin','admin',NULL,1),('0b293e7afb464848b4a4b897c4012d40',1641549951087,'admin','admin',NULL,1),('0dbced40cca842239d80e00eeae4e151',1641620537918,'admin','admin',NULL,1),('0f05035a06034c4db5c2ee5ba59388c0',1641557412231,'admin','admin',NULL,1),('16838b12a7c24f9b87dbddf52009e567',1639041960042,'test1','test1',NULL,1),('1bea0b9282434a5fb75ba24da5510548',1641645887280,'admin','admin',NULL,0),('1f309f32b6364d01a76cac15877ddb66',1638796758106,'dasd','dsad',NULL,0),('2ae8dddfeaad4e1cbea8355842ce6554',1642167223041,'admin','admin',NULL,1),('304da7befab148c39a0dd6d62e69b3ed',1640603039152,'admin','admin',NULL,1),('3094428811ed4192bcbd9f976b808496',1639041914271,'admin','admin',NULL,1),('37d4b9e074de43fd9979b02788914cc4',1641549915424,'admin','admin',NULL,0),('3b1342ee63e740489cde23611d5a0af0',1638799241405,'admin','admin',NULL,1),('3c5a541322814087950f7e5bf9b370e5',1639041817922,'test','test',NULL,1),('3f8e0f30e4b143e78ba522afc0843323',1641620501381,'user','user',NULL,1),('40eb2aa285804adfa8a9a2de8699aa0a',1652249232789,'admin','admin',NULL,1),('415d139c44cf450594662fc47dfe785d',1638796202994,'ads','sad',NULL,0),('447022cb6dbe4661809c125b017f691e',1638799158372,'test1','test1',NULL,1),('4630b47d7eef4ea7ad37e371ceb5767b',1638796292417,'sad','dsad',NULL,0),('48be8c8faa004935a0f2964f867130cc',1641986132234,'admin','admin',NULL,1),('492ac01312ab41b8ad6ef02ece32ab54',1638798260922,'admin','admin',NULL,1),('4ce353dd45514f269f7c3ee574a83f4b',1640603740620,'admin','admin',NULL,1),('4defb6afd42044748138261ca2357e0d',1640261532467,'admin','admin',NULL,0),('4f529be9e6e64eda900e86f66adfa69f',1641552837905,'admin','admin',NULL,0),('5195371032704ba2a8515dc6df1af6be',1640253369858,'admin','admin',NULL,0),('54ab31000bab4d249fc9663544879d54',1641550726834,'admin','admin',NULL,0),('55effea0550a4916aa2bf263891037fd',1638960901050,'admin','admin',NULL,0),('5bd7fc322bd34b7c8450a249b0ffba2d',1641614747512,'admin','admin',NULL,1),('5c8288b6c5a346da81589ed227d02d99',1647702963635,'root','root',NULL,0),('5dc51a86ad45470a8776a8f62f45f03f',1652973319055,'admin','admin',NULL,1),('6007e4b1977f45afb7708d7cbd5aa1f4',1644985850738,'user','user',NULL,1),('619815bd80a24c558f34fd0ec81dafa2',1639041721858,'test','test',NULL,1),('66d0bf03d1e6489cb34fb1fae203c902',1645626074909,'root','root',NULL,0),('675533ca85b54f2ab0a86883a65ea416',1640261540044,'admin','admin',NULL,1),('6a59653cf91a49e59376af35507a8d5e',1638799229477,'admin','admin',NULL,0),('6b23c62fd029495dab1a8dbda733f9cb',1641552853977,'admin','admin',NULL,1),('6b66ed2886514f2d906e5ce1cd36245a',1640253273419,'admin','admin',NULL,1),('6e8924feff124e6ea41c05fcbe393a1b',1638770762762,'admin','admin',NULL,1),('757edb49dfdc4a28acd909a774d1ae7f',1642222929048,'aa','vv',NULL,0),('829210326e2244099e5b0b0f0138391c',1641550765307,'admin','admin',NULL,0),('874e5bd00a504107a64ac1f1278a364a',1643897238890,'root','root',NULL,0),('8983925b32d940f99384ebb89139cfd7',1641540635047,'admin','admin',NULL,1),('8c63b5dd82c148ac999ccc783bb6df1a',1642392535942,'admin','admin',NULL,1),('8ccd42e904f5470fa209738133ca4eec',1640252044765,'admin','admin',NULL,1),('8ecf7231a22e4277b6aa23d803f6918a',1640259417059,'admin','admin',NULL,1),('8f4d3c531e444523b425fda07a3fdf26',1638799099354,'test','test',NULL,0),('8f85e3df843044b7984b54ca12c28eca',1642258574382,'admin','admin',NULL,1),('919f942d88294c6b92eeedce2dc8437c',1641901294999,'admin','admin',NULL,1),('95b30ae75a804856aa32c9580411e70b',1638696262970,'test','sssssss',NULL,0),('9e018a496d7043178b871b31a92db2a2',1640599245185,'admin','admin',NULL,0),('9e2c240a0dc64df1a026db09080d82bc',1642429464429,'admin','admin',NULL,1),('9ecf9fbc4d4c48c58613bdeafd97a3d3',1641975129286,'admin','admin',NULL,1),('a65b6f6ec23940128f2936755874b76d',1641698064960,'admin','admin',NULL,1),('a89a93f0e4a74c2fb76ff621d923bc40',1641645898995,'admin','admin',NULL,1),('aa795cb11b0f4f0e9f1abf66cd4f3153',1641550106326,'admin','admin',NULL,0),('adfb5c63370642b1bdaeb6142e65d697',1652456229898,'root','root',NULL,0),('af4dedcab90344559d339350cdde8166',1638696270495,'asdsa','sadsad',NULL,0),('b141eef039b8434a83654e86663070ec',1638799107932,'test','test',NULL,1),('b389460edc25421e9b8d2d71199de3ad',1640823053755,'admin','admin',NULL,1),('b3fcbea9283d49cd873e2f382ceaf533',1639042271735,'admin','admin',NULL,1),('b8c4a483b18d4fc48c676e56d24b1da6',1639041839059,'admin','admin',NULL,0),('bd093e0a95a84d87850b2a2d3477a73a',1641879153883,'admin','admin',NULL,1),('c42e4b3365c145d78413d9b316785506',1644985506006,'test','test',NULL,1),('c6320d0f52db4037b261b051656a380b',1638765189448,'admin','admin',NULL,1),('c9454a92d33f4017981be7cb917853d1',1638960976882,'admin','admin',NULL,1),('ca6a8aef72fd4a9dbdc07bcb562c954f',1650947901957,'admin','admin',NULL,1),('cdc885cae1c445718ea73edda4477ce1',1642409774023,'admin','admin',NULL,1),('cee73f34aab341dda64984af8d0e6c92',1641550776554,'admin','admin',NULL,1),('d371e84c6a0d4b79aeb0a07d533a06ad',1638696277934,'admin','admin',NULL,1),('d4fc8d9c535e454b934f9cb2b48458ea',1638796800744,'dsads','dsad',NULL,0),('d50a66a4c10e447b87e4887fc4a9318a',1641550142821,'admin','admin',NULL,0),('d54d79b9e8e849f396b1a89fecfd1098',1641463341667,'admin','admin',NULL,1),('d8b4068f56694460898c0bf681654d0f',1638796185973,'admin','admin',NULL,1),('d9cccdd1ead344d3b0ec86ddd1abcd6a',1642246628722,'admin','admin',NULL,1),('dd23b8e554cc4f4a9bb4545d61b21651',1640599271752,'admin','admin',NULL,1),('dd5d10fd4d6c4458bc36a96e8e79cc06',1647781154781,'root','root',NULL,0),('de5d794b93474b0b9a1a38836a311eb6',1642222955519,'aa','aa',NULL,0),('e1fb100e24a246fbaf5061338ff49ec6',1641550148009,'admin','admin',NULL,1),('ea619044b4e446ff989774e99c80fa76',1641698215408,'admin','admin',NULL,1),('eb89604299494c88afa3d848f7c70930',1640827734135,'admin','admin',NULL,1),('f56e664be707483c92e0a1b77d71decd',1652962772974,'1786705138@qq.com','123456',NULL,1),('f7b7c2ea0b1c478d9355df753a895d2e',1639043214131,'admin','admin',NULL,1),('f962bb6df6914b8d9966e8c58697b23b',1638695722932,'admin','admin',NULL,1),('f9e8b508b5344825aa31d157ed1f20c7',1641550699312,'admin','admin',NULL,1),('fae75a997cb24936bb0dbfdb78b88321',1640771448464,'admin','admin',NULL,1),('fe4e64ff844b45a6ab90e02d4831be2e',1640253525782,'admin','admin',NULL,1),('fee3f22a60a64ddf915507bd09e3c6fa',1642432282167,'admin','admin',NULL,1);
/*!40000 ALTER TABLE `login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` varchar(64) NOT NULL,
  `date` bigint DEFAULT NULL,
  `title` varchar(16) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `top` int DEFAULT NULL,
  `admin_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES ('a3ac8b52c55c4be2875cdf8828f03f9c',1643538516936,'测试','测试公告内容',1,'1'),('e7bf3bd8117f44fd9f9741cac47c095a',1643538764273,'二饭管理系统','欢迎使用二饭管理系统。',1,'1');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(8) DEFAULT NULL,
  `url` varchar(24) DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `icon` varchar(24) DEFAULT NULL,
  `type` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'系统管理','/system',0,1,'el-icon-setting',1),(2,'信息管理','/info',0,2,'el-icon-s-data',1),(3,'公告管理','/notice',0,3,'el-icon-chat-line-round',1),(4,'角色管理','/system/role',1,11,'null',2),(5,'资源管理','/system/resource',1,12,'null',2),(23,'公告管理','/notice/notice',3,31,'',2),(26,'人员管理','/system/admin',1,14,'',2),(29,'日志管理','/log',0,4,'el-icon-document',1),(30,'操作日志','/log/log',29,41,'',2),(31,'登录日志','/log/loginLog',29,42,'',2),(32,'系统工具','/tools',0,5,'el-icon-box',1),(33,'系统接口','/tools/doc',32,51,'',2),(34,'系统监控','/tools/monitor',32,52,'',2),(35,'代码生成','/tools/codeGeneration',32,55,'',2),(65,'开发示例','/dev',0,6,'el-icon-s-cooperation',1),(66,'富文本组件','/dev/editor',65,61,'',2),(67,'跳转页面','/dev/jump',65,62,'',2),(75,'文件上传','/dev/upload',65,63,'',2),(78,'在线账户','/tools/online',32,56,'',2),(80,'版本日志','/log/versionLog',29,43,'',2);
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` bigint DEFAULT NULL,
  `homework` int DEFAULT NULL,
  `content` varchar(8098) DEFAULT NULL,
  `num` float DEFAULT NULL,
  `adminId` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (2,'一级管理员'),(3,'二级管理员'),(4,'用户');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_resources`
--

DROP TABLE IF EXISTS `role_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_resources`
--

LOCK TABLES `role_resources` WRITE;
/*!40000 ALTER TABLE `role_resources` DISABLE KEYS */;
INSERT INTO `role_resources` VALUES (35,2,26),(36,2,31),(37,2,34),(38,2,4),(39,2,66),(40,2,67);
/*!40000 ALTER TABLE `role_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` bigint DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version_log`
--

DROP TABLE IF EXISTS `version_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `version_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` bigint DEFAULT NULL,
  `version` varchar(64) DEFAULT NULL,
  `info` varchar(8098) DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version_log`
--

LOCK TABLES `version_log` WRITE;
/*!40000 ALTER TABLE `version_log` DISABLE KEYS */;
INSERT INTO `version_log` VALUES (1,1652799051704,'v1.3','1、新增版本日志\r\n2、更改界面按钮尺寸\r\n3、增加多选框及批量删除\r\n4、增加Service使用统一接口\r\n5、修复刷新后页面重新初始化路径\r\n6、升级富文本组件为wangEditor5','二饭');
/*!40000 ALTER TABLE `version_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'erfan_admin'
--

--
-- Dumping routines for database 'erfan_admin'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-27 15:18:37
