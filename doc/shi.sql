-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: shishicai
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fa_admin`
--

DROP TABLE IF EXISTS `fa_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(100) NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `token` varchar(59) NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_admin`
--

LOCK TABLES `fa_admin` WRITE;
/*!40000 ALTER TABLE `fa_admin` DISABLE KEYS */;
INSERT INTO `fa_admin` VALUES (1,'admin','Admin','075eaec83636846f51c152f29b98a2fd','s4f3','/assets/img/avatar.png','admin@fastadmin.net',0,1502029281,1492186163,1502029281,'d3992c3b-5ecc-4ecb-9dc2-8997780fcadc','normal'),(2,'admin2','admin2','9a28ce07ce875fbd14172a9ca5357d3c','2dHDmj','/assets/img/avatar.png','admin2@fastadmin.net',0,1505450906,1492186163,1505450906,'df45fdd5-26f4-45ca-83b3-47e4491a315a','normal'),(3,'admin3','admin3','1c11f945dfcd808a130a8c2a8753fe62','WOKJEn','/assets/img/avatar.png','admin3@fastadmin.net',0,1501980868,1492186201,1501982377,'','normal'),(4,'admin22','admin22','1c1a0aa0c3c56a8c1a908aab94519648','Aybcn5','/assets/img/avatar.png','admin22@fastadmin.net',0,0,1492186240,1492186240,'','normal'),(5,'admin32','admin32','ade94d5d7a7033afa7d84ac3066d0a02','FvYK0u','/assets/img/avatar.png','admin32@fastadmin.net',0,0,1492186263,1492186263,'','normal');
/*!40000 ALTER TABLE `fa_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_admin_log`
--

DROP TABLE IF EXISTS `fa_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_admin_log`
--

LOCK TABLES `fa_admin_log` WRITE;
/*!40000 ALTER TABLE `fa_admin_log` DISABLE KEYS */;
INSERT INTO `fa_admin_log` VALUES (1,1,'admin','/shishicai/public/index.php/admin/general.config/edit','常规管理 系统配置 编辑','{\"row\":{\"mail_type\":\"1\",\"mail_smtp_host\":\"smtp.qq.com\",\"mail_smtp_port\":\"465\",\"mail_smtp_user\":\"904693433@qq.com\",\"mail_smtp_pass\":\"ygojtjqghsivbdbi\",\"mail_verify_type\":\"2\",\"mail_from\":\"904693433@qq.com\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522590534),(2,1,'admin','/shishicai/public/index.php/admin/general/config/emailtest','','{\"receiver\":\"904693433@qq.com\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522590539),(3,1,'admin','/shishicai/public/index.php/admin/general.config/edit','常规管理 系统配置 编辑','{\"row\":{\"mail_type\":\"1\",\"mail_smtp_host\":\"smtp.qq.com\",\"mail_smtp_port\":\"465\",\"mail_smtp_user\":\"904693433@qq.com\",\"mail_smtp_pass\":\"ygojtjqghsivbdbi\",\"mail_verify_type\":\"2\",\"mail_from\":\"904693433@qq.com\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522590546),(4,1,'admin','/shishicai/public/index.php/admin/general.config/edit','常规管理 系统配置 编辑','{\"row\":{\"mail_type\":\"1\",\"mail_smtp_host\":\"smtp.qq.com\",\"mail_smtp_port\":\"465\",\"mail_smtp_user\":\"904693433@qq.com\",\"mail_smtp_pass\":\"ygojtjqghsivbdbi\",\"mail_verify_type\":\"0\",\"mail_from\":\"904693433@qq.com\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522590579),(5,1,'admin','/shishicai/public/index.php/admin/general/config/emailtest','','{\"receiver\":\"904693433@qq.com\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522590882),(6,1,'admin','/shishicai/public/index.php/admin/general/config/emailtest','','{\"receiver\":\"904693433@qq.com\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522591306),(7,1,'admin','/shishicai/public/index.php/admin/addon/install','插件管理 安装','{\"name\":\"crontab\",\"force\":\"0\",\"uid\":\"0\",\"token\":\"\",\"version\":\"1.0.1\",\"faversion\":\"1.0.0.20180327_beta\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681882),(8,1,'admin','/shishicai/public/index.php/admin/index/index','','{\"action\":\"refreshmenu\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681882),(9,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"* * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681947),(10,1,'admin','/shishicai/public/index.php/admin/general/crontab/check_schedule','','{\"row\":{\"schedule\":\"* * * * *\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681949),(11,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"* * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681949),(12,1,'admin','/shishicai/public/index.php/admin/general/crontab/edit/ids/2?dialog=1','常规管理 定时任务 编辑 ','{\"dialog\":\"1\",\"row\":{\"title\":\"\\u67e5\\u8be2\\u4e00\\u6761SQL\",\"type\":\"sql\",\"content\":\"SELECT 1;\",\"schedule\":\"* * * * *\",\"maximums\":\"0\",\"begintime\":\"2017-01-01 00:00:00\",\"endtime\":\"2019-01-01 00:00:00\",\"weigh\":\"2\",\"status\":\"hidden\"},\"ids\":\"2\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681950),(13,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"* * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681952),(14,1,'admin','/shishicai/public/index.php/admin/general/crontab/check_schedule','','{\"row\":{\"schedule\":\"* * * * *\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681955),(15,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"* * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681955),(16,1,'admin','/shishicai/public/index.php/admin/general/crontab/edit/ids/1?dialog=1','常规管理 定时任务 编辑 ','{\"dialog\":\"1\",\"row\":{\"title\":\"\\u8bf7\\u6c42FastAdmin\",\"type\":\"url\",\"content\":\"http:\\/\\/www.fastadmin.net\",\"schedule\":\"* * * * *\",\"maximums\":\"0\",\"begintime\":\"2017-01-01 00:00:00\",\"endtime\":\"2019-01-01 00:00:00\",\"weigh\":\"1\",\"status\":\"hidden\"},\"ids\":\"1\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681955),(17,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"* * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681972),(18,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"* * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522681980),(19,1,'admin','/shishicai/public/index.php/admin/general/crontab/check_schedule','','{\"row\":{\"schedule\":\"*\\/1 * * * *\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522682009),(20,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"*\\/1 * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522682009),(21,1,'admin','/shishicai/public/index.php/admin/general/crontab/get_schedule_future','','{\"schedule\":\"*\\/1 * * * *\",\"days\":\"7\"}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522682024),(22,1,'admin','/shishicai/public/index.php/admin/general/crontab/add?dialog=1','常规管理 定时任务 添加','{\"dialog\":\"1\",\"row\":{\"title\":\"\\u5b9a\\u65f6\\u83b7\\u53d6\\u6570\\u636e\\u5e76\\u4e0b\\u6ce8\",\"type\":\"url\",\"content\":\"http:\\/\\/yangqihua.com\\/shishicai\\/public\\/index.php\\/api\\/cai\\/pk10\\/cron_get_data\",\"schedule\":\"*\\/1 * * * *\",\"maximums\":\"0\",\"begintime\":\"2018-04-02 23:13:32\",\"endtime\":\"2024-12-28 23:13:34\",\"weigh\":\"0\",\"status\":\"normal\"}}','127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',1522682025);
/*!40000 ALTER TABLE `fa_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_attachment`
--

DROP TABLE IF EXISTS `fa_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) NOT NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `uploadtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `storage` enum('local','upyun','qiniu') NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_attachment`
--

LOCK TABLES `fa_attachment` WRITE;
/*!40000 ALTER TABLE `fa_attachment` DISABLE KEYS */;
INSERT INTO `fa_attachment` VALUES (1,'/assets/img/qrcode.png','150','150','png',0,21859,'image/png','',1499681848,1499681848,1499681848,'local','17163603d0263e4838b9387ff2cd4877e8b018f6');
/*!40000 ALTER TABLE `fa_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_auth_group`
--

DROP TABLE IF EXISTS `fa_auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_auth_group`
--

LOCK TABLES `fa_auth_group` WRITE;
/*!40000 ALTER TABLE `fa_auth_group` DISABLE KEYS */;
INSERT INTO `fa_auth_group` VALUES (1,0,'Admin group','*',1490883540,149088354,'normal'),(2,1,'Second group','13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5',1490883540,1505465692,'normal'),(3,2,'Third group','1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5',1490883540,1502205322,'normal'),(4,1,'Second group 2','1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65',1490883540,1502205350,'normal'),(5,2,'Third group 2','1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34',1490883540,1502205344,'normal');
/*!40000 ALTER TABLE `fa_auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_auth_group_access`
--

DROP TABLE IF EXISTS `fa_auth_group_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_auth_group_access`
--

LOCK TABLES `fa_auth_group_access` WRITE;
/*!40000 ALTER TABLE `fa_auth_group_access` DISABLE KEYS */;
INSERT INTO `fa_auth_group_access` VALUES (1,1),(2,2),(3,3),(4,5),(5,5);
/*!40000 ALTER TABLE `fa_auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_auth_rule`
--

DROP TABLE IF EXISTS `fa_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_auth_rule`
--

LOCK TABLES `fa_auth_rule` WRITE;
/*!40000 ALTER TABLE `fa_auth_rule` DISABLE KEYS */;
INSERT INTO `fa_auth_rule` VALUES (186,'file',0,'addon','插件管理','fa fa-circle-o','','可在线安装、卸载、禁用、启用插件，同时支持添加本地插件。FastAdmin已上线插件商店 ，你可以发布你的免费或付费插件：<a href=\"https://www.fastadmin.net/store.html\" target=\"_blank\">https://www.fastadmin.net/store.html</a>',1,1522595866,1522595866,0,'normal'),(187,'file',186,'addon/index','查看','fa fa-circle-o','','',0,1522595866,1522595866,0,'normal'),(188,'file',186,'addon/config','配置','fa fa-circle-o','','',0,1522595866,1522595866,0,'normal'),(189,'file',186,'addon/install','安装','fa fa-circle-o','','',0,1522595866,1522595866,0,'normal'),(190,'file',186,'addon/uninstall','卸载','fa fa-circle-o','','',0,1522595866,1522595866,0,'normal'),(191,'file',186,'addon/state','禁用启用','fa fa-circle-o','','',0,1522595866,1522595866,0,'normal'),(192,'file',186,'addon/local','本地上传','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(193,'file',186,'addon/upgrade','更新插件','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(194,'file',186,'addon/refresh','刷新缓存','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(195,'file',186,'addon/downloaded','已装插件','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(196,'file',186,'addon/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(197,'file',186,'addon/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(198,'file',186,'addon/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(199,'file',186,'addon/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(200,'file',0,'category','分类管理','fa fa-list','','用于统一管理网站的所有分类,分类可进行无限级分类',1,1522595867,1522595867,0,'normal'),(201,'file',200,'category/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(202,'file',200,'category/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(203,'file',200,'category/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(204,'file',200,'category/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(205,'file',200,'category/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(206,'file',0,'dashboard','控制台','fa fa-dashboard','','用于展示当前系统中的统计数据、统计报表及重要实时数据',1,1522595867,1522595867,0,'normal'),(207,'file',206,'dashboard/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(208,'file',206,'dashboard/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(209,'file',206,'dashboard/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(210,'file',206,'dashboard/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(211,'file',206,'dashboard/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(212,'file',0,'auth','auth','fa fa-list','','',1,1522595867,1522595867,0,'normal'),(213,'file',212,'auth/admin','管理员管理','fa fa-users','','一个管理员可以有多个角色组,左侧的菜单根据管理员所拥有的权限进行生成',1,1522595867,1522595867,0,'normal'),(214,'file',213,'auth/admin/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(215,'file',213,'auth/admin/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(216,'file',213,'auth/admin/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(217,'file',213,'auth/admin/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(218,'file',212,'auth/adminlog','管理员日志','fa fa-users','','管理员可以查看自己所拥有的权限的管理员日志',1,1522595867,1522595867,0,'normal'),(219,'file',218,'auth/adminlog/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(220,'file',218,'auth/adminlog/detail','详情','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(221,'file',218,'auth/adminlog/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(222,'file',218,'auth/adminlog/selectpage','Selectpage','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(223,'file',212,'auth/group','角色组','fa fa-group','','角色组可以有多个,角色有上下级层级关系,如果子角色有角色组和管理员的权限则可以派生属于自己组别下级的角色组或管理员',1,1522595867,1522595867,0,'normal'),(224,'file',223,'auth/group/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(225,'file',223,'auth/group/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(226,'file',223,'auth/group/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(227,'file',223,'auth/group/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(228,'file',212,'auth/rule','规则管理','fa fa-list','','规则通常对应一个控制器的方法,同时左侧的菜单栏数据也从规则中体现,通常建议通过控制台进行生成规则节点',1,1522595867,1522595867,0,'normal'),(229,'file',228,'auth/rule/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(230,'file',228,'auth/rule/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(231,'file',228,'auth/rule/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(232,'file',228,'auth/rule/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(233,'file',228,'auth/rule/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(234,'file',0,'general','general','fa fa-list','','',1,1522595867,1522595867,0,'normal'),(235,'file',234,'general/attachment','附件管理','fa fa-circle-o','','主要用于管理上传到又拍云的数据或上传至本服务的上传数据',1,1522595867,1522595867,0,'normal'),(236,'file',235,'general/attachment/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(237,'file',235,'general/attachment/select','选择附件','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(238,'file',235,'general/attachment/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(239,'file',235,'general/attachment/del','删除附件','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(240,'file',235,'general/attachment/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(241,'file',235,'general/attachment/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(242,'file',234,'general/config','系统配置','fa fa-circle-o','','可以在此增改系统的变量和分组,也可以自定义分组和变量,如果需要删除请从数据库中删除',1,1522595867,1522595867,0,'normal'),(243,'file',242,'general/config/index','Index','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(244,'file',242,'general/config/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(245,'file',242,'general/config/edit','Edit','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(246,'file',242,'general/config/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(247,'file',242,'general/config/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(248,'file',234,'general/profile','个人配置','fa fa-user','','',1,1522595867,1522595867,0,'normal'),(249,'file',248,'general/profile/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(250,'file',248,'general/profile/update','更新个人信息','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(251,'file',248,'general/profile/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(252,'file',248,'general/profile/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(253,'file',248,'general/profile/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(254,'file',248,'general/profile/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(255,'file',0,'pk','pk','fa fa-list','','',1,1522595867,1522595867,0,'normal'),(256,'file',255,'pk/huihe','北京pk回合记录','fa fa-circle-o','','',1,1522595867,1522595867,0,'normal'),(257,'file',256,'pk/huihe/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(258,'file',256,'pk/huihe/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(259,'file',256,'pk/huihe/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(260,'file',256,'pk/huihe/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(261,'file',256,'pk/huihe/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(262,'file',255,'pk/lost','Lost','fa fa-circle-o','','',1,1522595867,1522595867,0,'normal'),(263,'file',262,'pk/lost/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(264,'file',262,'pk/lost/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(265,'file',262,'pk/lost/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(266,'file',262,'pk/lost/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(267,'file',262,'pk/lost/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(268,'file',255,'pk/result','北京pk','fa fa-circle-o','','',1,1522595867,1522595867,0,'normal'),(269,'file',268,'pk/result/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(270,'file',268,'pk/result/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(271,'file',268,'pk/result/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(272,'file',268,'pk/result/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(273,'file',268,'pk/result/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(274,'file',0,'user','user','fa fa-list','','',1,1522595867,1522595867,0,'normal'),(275,'file',274,'user/group','会员组管理','fa fa-users','','',1,1522595867,1522595867,0,'normal'),(276,'file',275,'user/group/add','Add','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(277,'file',275,'user/group/edit','Edit','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(278,'file',275,'user/group/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(279,'file',275,'user/group/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(280,'file',275,'user/group/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(281,'file',274,'user/rule','会员规则管理','fa fa-circle-o','','',1,1522595867,1522595867,0,'normal'),(282,'file',281,'user/rule/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(283,'file',281,'user/rule/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(284,'file',281,'user/rule/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(285,'file',281,'user/rule/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(286,'file',281,'user/rule/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(287,'file',274,'user/user','会员管理','fa fa-user','','',1,1522595867,1522595867,0,'normal'),(288,'file',287,'user/user/index','查看','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(289,'file',287,'user/user/edit','编辑','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(290,'file',287,'user/user/add','添加','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(291,'file',287,'user/user/del','删除','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(292,'file',287,'user/user/multi','批量更新','fa fa-circle-o','','',0,1522595867,1522595867,0,'normal'),(293,'file',234,'general/crontab','定时任务','fa fa-tasks','','类似于Linux的Crontab定时任务,可以按照设定的时间进行任务的执行,目前仅支持三种任务:请求URL、执行SQL、执行Shell',1,1522681882,1522681882,0,'normal'),(294,'file',293,'general/crontab/index','查看','fa fa-circle-o','','',0,1522681882,1522681882,0,'normal'),(295,'file',293,'general/crontab/add','添加','fa fa-circle-o','','',0,1522681882,1522681882,0,'normal'),(296,'file',293,'general/crontab/edit','编辑 ','fa fa-circle-o','','',0,1522681882,1522681882,0,'normal'),(297,'file',293,'general/crontab/del','删除','fa fa-circle-o','','',0,1522681882,1522681882,0,'normal'),(298,'file',293,'general/crontab/multi','批量更新','fa fa-circle-o','','',0,1522681882,1522681882,0,'normal');
/*!40000 ALTER TABLE `fa_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_category`
--

DROP TABLE IF EXISTS `fa_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) NOT NULL DEFAULT '',
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) NOT NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `weigh` (`weigh`,`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_category`
--

LOCK TABLES `fa_category` WRITE;
/*!40000 ALTER TABLE `fa_category` DISABLE KEYS */;
INSERT INTO `fa_category` VALUES (1,0,'page','官方新闻','news','recommend','/assets/img/qrcode.png','','','news',1495262190,1495262190,1,'normal'),(2,0,'page','移动应用','mobileapp','hot','/assets/img/qrcode.png','','','mobileapp',1495262244,1495262244,2,'normal'),(3,2,'page','微信公众号','wechatpublic','index','/assets/img/qrcode.png','','','wechatpublic',1495262288,1495262288,3,'normal'),(4,2,'page','Android开发','android','recommend','/assets/img/qrcode.png','','','android',1495262317,1495262317,4,'normal'),(5,0,'page','软件产品','software','recommend','/assets/img/qrcode.png','','','software',1495262336,1499681850,5,'normal'),(6,5,'page','网站建站','website','recommend','/assets/img/qrcode.png','','','website',1495262357,1495262357,6,'normal'),(7,5,'page','企业管理软件','company','index','/assets/img/qrcode.png','','','company',1495262391,1495262391,7,'normal'),(8,6,'page','PC端','website-pc','recommend','/assets/img/qrcode.png','','','website-pc',1495262424,1495262424,8,'normal'),(9,6,'page','移动端','website-mobile','recommend','/assets/img/qrcode.png','','','website-mobile',1495262456,1495262456,9,'normal'),(10,7,'page','CRM系统 ','company-crm','recommend','/assets/img/qrcode.png','','','company-crm',1495262487,1495262487,10,'normal'),(11,7,'page','SASS平台软件','company-sass','recommend','/assets/img/qrcode.png','','','company-sass',1495262515,1495262515,11,'normal'),(12,0,'test','测试1','test1','recommend','/assets/img/qrcode.png','','','test1',1497015727,1497015727,12,'normal'),(13,0,'test','测试2','test2','recommend','/assets/img/qrcode.png','','','test2',1497015738,1497015738,13,'normal');
/*!40000 ALTER TABLE `fa_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_config`
--

DROP TABLE IF EXISTS `fa_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `content` text NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='系统配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_config`
--

LOCK TABLES `fa_config` WRITE;
/*!40000 ALTER TABLE `fa_config` DISABLE KEYS */;
INSERT INTO `fa_config` VALUES (1,'name','basic','Site name','请填写站点名称','string','FastAdmin','','required',''),(2,'beian','basic','Beian','粤ICP备15054802号-4','string','','','',''),(3,'cdnurl','basic','Cdn url','如果静态资源使用第三方云储存请配置该值','string','','','',''),(4,'version','basic','Version','如果静态资源有变动请重新配置该值','string','1.0.1','','required',''),(5,'timezone','basic','Timezone','','string','Asia/Shanghai','','required',''),(6,'forbiddenip','basic','Forbidden ip','一行一条记录','text','','','',''),(7,'languages','basic','Languages','','array','{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}','','required',''),(8,'fixedpage','basic','Fixed page','请尽量输入左侧菜单栏存在的链接','string','dashboard','','required',''),(9,'categorytype','dictionary','Category type','','array','{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}','','',''),(10,'configgroup','dictionary','Config group','','array','{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}','','',''),(11,'mail_type','email','Mail type','选择邮件发送方式','select','1','[\"Please select\",\"SMTP\",\"Mail\"]','',''),(12,'mail_smtp_host','email','Mail smtp host','错误的配置发送邮件会导致服务器超时','string','smtp.qq.com','','',''),(13,'mail_smtp_port','email','Mail smtp port','(不加密默认25,SSL默认465,TLS默认587)','string','465','','',''),(14,'mail_smtp_user','email','Mail smtp user','（填写完整用户名）','string','904693433@qq.com','','',''),(15,'mail_smtp_pass','email','Mail smtp password','（填写您的密码）','string','ygojtjqghsivbdbi','','',''),(16,'mail_verify_type','email','Mail vertify type','（SMTP验证方式[推荐SSL]）','select','0','[\"None\",\"TLS\",\"SSL\"]','',''),(17,'mail_from','email','Mail from','','string','904693433@qq.com','','','');
/*!40000 ALTER TABLE `fa_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_crontab`
--

DROP TABLE IF EXISTS `fa_crontab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_crontab` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '事件类型',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '事件标题',
  `content` text NOT NULL COMMENT '事件内容',
  `schedule` varchar(100) NOT NULL DEFAULT '' COMMENT 'Crontab格式',
  `sleep` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '延迟秒数执行',
  `maximums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大执行次数 0为不限',
  `executes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已经执行的次数',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `begintime` int(10) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `endtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `executetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后执行时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` enum('completed','expired','hidden','normal') NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_crontab`
--

LOCK TABLES `fa_crontab` WRITE;
/*!40000 ALTER TABLE `fa_crontab` DISABLE KEYS */;
INSERT INTO `fa_crontab` VALUES (1,'url','请求FastAdmin','http://www.fastadmin.net','* * * * *',0,0,13548,1497070825,1522681955,1483200000,1546272000,1501253101,1,'hidden'),(2,'sql','查询一条SQL','SELECT 1;','* * * * *',0,0,13548,1497071095,1522681950,1483200000,1546272000,1501253101,2,'hidden'),(3,'url','定时获取数据并下注','http://yangqihua.com/shishicai/public/index.php/api/cai/pk10/cron_get_data','*/1 * * * *',0,0,0,1522682025,1522682025,1522682012,1735398814,0,0,'normal');
/*!40000 ALTER TABLE `fa_crontab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_ems`
--

DROP TABLE IF EXISTS `fa_ems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) NOT NULL DEFAULT '' COMMENT '事件',
  `email` varchar(20) NOT NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮箱验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_ems`
--

LOCK TABLES `fa_ems` WRITE;
/*!40000 ALTER TABLE `fa_ems` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_ems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_sms`
--

DROP TABLE IF EXISTS `fa_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) NOT NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_sms`
--

LOCK TABLES `fa_sms` WRITE;
/*!40000 ALTER TABLE `fa_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_test`
--

DROP TABLE IF EXISTS `fa_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) NOT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') NOT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') NOT NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') NOT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) NOT NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) NOT NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(100) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) NOT NULL DEFAULT '' COMMENT '省市',
  `price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '刷新时间(int)',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') NOT NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='测试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_test`
--

LOCK TABLES `fa_test` WRITE;
/*!40000 ALTER TABLE `fa_test` DISABLE KEYS */;
INSERT INTO `fa_test` VALUES (1,0,12,'12,13','monday','hot,index','male','music,reading','我是一篇测试文章','<p>我是测试内容</p>','/assets/img/avatar.png','/assets/img/avatar.png,/assets/img/qrcode.png','/assets/img/avatar.png','关键字','描述','广西壮族自治区/百色市/平果县',0.00,0,'2017-07-10','2017-07-10 18:24:45',2017,'18:24:45',1499682285,1499682526,1499682526,0,1,'normal','1');
/*!40000 ALTER TABLE `fa_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user`
--

DROP TABLE IF EXISTS `fa_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) NOT NULL DEFAULT '' COMMENT '格言',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `logintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `loginip` varchar(50) NOT NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) NOT NULL DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) NOT NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user`
--

LOCK TABLES `fa_user` WRITE;
/*!40000 ALTER TABLE `fa_user` DISABLE KEYS */;
INSERT INTO `fa_user` VALUES (1,1,'admin','admin','c13f62012fd6a8fdf06b3452a94430e5','rpR6Bv','admin@163.com','13888888888','/assets/img/avatar.png',0,0,'2017-04-15','',0,1,1,1516170492,1516171614,'127.0.0.1',0,'127.0.0.1',1491461418,0,1516171614,'','normal','');
/*!40000 ALTER TABLE `fa_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_group`
--

DROP TABLE IF EXISTS `fa_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '组名',
  `rules` text COMMENT '权限节点',
  `createtime` int(10) DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_group`
--

LOCK TABLES `fa_user_group` WRITE;
/*!40000 ALTER TABLE `fa_user_group` DISABLE KEYS */;
INSERT INTO `fa_user_group` VALUES (1,'默认组','1,2,3,4,5,6,7,8,9,10,11,12',1515386468,1516168298,'normal');
/*!40000 ALTER TABLE `fa_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_rule`
--

DROP TABLE IF EXISTS `fa_user_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='会员规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_rule`
--

LOCK TABLES `fa_user_rule` WRITE;
/*!40000 ALTER TABLE `fa_user_rule` DISABLE KEYS */;
INSERT INTO `fa_user_rule` VALUES (1,0,'index','前台','',1,1516168079,1516168079,1,'normal'),(2,0,'api','API接口','',1,1516168062,1516168062,2,'normal'),(3,1,'user','会员模块','',1,1515386221,1516168103,12,'normal'),(4,2,'user','会员模块','',1,1515386221,1516168092,11,'normal'),(5,3,'index/user/login','登录','',0,1515386247,1515386247,5,'normal'),(6,3,'index/user/register','注册','',0,1515386262,1516015236,7,'normal'),(7,3,'index/user/index','会员中心','',0,1516015012,1516015012,9,'normal'),(8,3,'index/user/profile','个人资料','',0,1516015012,1516015012,4,'normal'),(9,4,'api/user/login','登录','',0,1515386247,1515386247,6,'normal'),(10,4,'api/user/register','注册','',0,1515386262,1516015236,8,'normal'),(11,4,'api/user/index','会员中心','',0,1516015012,1516015012,10,'normal'),(12,4,'api/user/profile','个人资料','',0,1516015012,1516015012,3,'normal');
/*!40000 ALTER TABLE `fa_user_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_score_log`
--

DROP TABLE IF EXISTS `fa_user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分变动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_score_log`
--

LOCK TABLES `fa_user_score_log` WRITE;
/*!40000 ALTER TABLE `fa_user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_token`
--

DROP TABLE IF EXISTS `fa_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_token` (
  `token` varchar(50) NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `expiretime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员Token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_token`
--

LOCK TABLES `fa_user_token` WRITE;
/*!40000 ALTER TABLE `fa_user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_version`
--

DROP TABLE IF EXISTS `fa_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) NOT NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) NOT NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) NOT NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) NOT NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) NOT NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_version`
--

LOCK TABLES `fa_version` WRITE;
/*!40000 ALTER TABLE `fa_version` DISABLE KEYS */;
INSERT INTO `fa_version` VALUES (1,'1.1.1,2','1.2.1','20M','更新内容','https://www.fastadmin.net/download.html',1,1520425318,0,0,'normal');
/*!40000 ALTER TABLE `fa_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pk_huihe`
--

DROP TABLE IF EXISTS `pk_huihe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pk_huihe` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `wei` varchar(255) DEFAULT NULL COMMENT '位',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT '连出类型，单双大小',
  `qihaos` text COMMENT '连出期号',
  `repeat_num` int(11) NOT NULL DEFAULT '0' COMMENT '连出次数',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  `createtime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='北京pk回合记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pk_huihe`
--

LOCK TABLES `pk_huihe` WRITE;
/*!40000 ALTER TABLE `pk_huihe` DISABLE KEYS */;
/*!40000 ALTER TABLE `pk_huihe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pk_lost`
--

DROP TABLE IF EXISTS `pk_lost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pk_lost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qihao` varchar(255) DEFAULT '',
  `createtime` int(11) DEFAULT '0',
  `updatetime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pk_lost`
--

LOCK TABLES `pk_lost` WRITE;
/*!40000 ALTER TABLE `pk_lost` DISABLE KEYS */;
/*!40000 ALTER TABLE `pk_lost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pk_result`
--

DROP TABLE IF EXISTS `pk_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pk_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `qihao` varchar(255) NOT NULL DEFAULT '' COMMENT '期号',
  `total` varchar(255) DEFAULT '' COMMENT '冠亚军之和',
  `yi` varchar(255) NOT NULL DEFAULT '' COMMENT '冠军',
  `er` varchar(255) NOT NULL DEFAULT '' COMMENT '压军',
  `san` varchar(255) NOT NULL DEFAULT '' COMMENT '第三位',
  `si` varchar(255) NOT NULL DEFAULT '' COMMENT '第四位',
  `wu` varchar(255) NOT NULL DEFAULT '' COMMENT '第五位',
  `liu` varchar(255) NOT NULL DEFAULT '' COMMENT '第六位',
  `qi` varchar(255) NOT NULL DEFAULT '' COMMENT '第七位',
  `ba` varchar(255) NOT NULL DEFAULT '' COMMENT '第八位',
  `jiu` varchar(255) NOT NULL DEFAULT '' COMMENT '第九位',
  `shi` varchar(255) NOT NULL DEFAULT '' COMMENT '第十位',
  `createtime` int(11) NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  `reward_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='北京pk';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pk_result`
--

LOCK TABLES `pk_result` WRITE;
/*!40000 ALTER TABLE `pk_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `pk_result` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-02 23:14:45
