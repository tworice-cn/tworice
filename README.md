# 二饭单服务快速开发框架

## 简介

本系统基于SpringBoot、MyBatis、Vue & Element实现的后台系统，支持RBAC动态菜单&权限；



## 1、技术选型

| 技术        | 说明                  | 官网                                           |
| ----------- | --------------------- | ---------------------------------------------- |
| SpringBoot  | v2.4.3，容器+MVC框架  | https://spring.io/projects/spring-boot         |
| MyBatis     | v2.1.4，ORM框架       | http://www.mybatis.org/mybatis-3/zh/index.html |
| MySQL       | 关系型数据库          | https://www.oracle.com/kr/mysql/               |
| Druid       | 数据库连接池          | https://github.com/alibaba/druid               |
| JWT         | JWT登录支持           | https://github.com/jwtk/jjwt                   |
| Lombok      | 简化对象封装工具      | https://github.com/rzwitserloot/lombok         |
| Swagger-UI  | 文档生成工具          | https://github.com/swagger-api/swagger-ui      |
| zXing       | 谷歌二维码生成技术    | https://github.com/*zxing*/zxing               |
| EasyCaptcha | Java图形验证码        | https://gitee.com/ele-admin/EasyCaptcha        |
| wangEditor  | 富文本编辑器          | https://www.wangeditor.com/                    |
| easyExcel   | 阿里巴巴Excel操作工具 | https://easyexcel.opensource.alibaba.com/      |



## 2、项目结构

| 模块                | 说明                     | 是否必须 |
| ------------------- | ------------------------ | -------- |
| `tworice-admin`     | 基础组件，可针对方法重写 | 是       |
| `tworice-admin-web` | 管理端前端，使用Vue2开发 | 否       |



## 3、系统启动

将`Dependence`目录下的文件拷贝到`本地Maven仓库/cn/`下；

导入项目`tworice-admin`，设置JDK版本为`1.8`；

运行`Application.java`即可。



## 4、组件

### 4.1、时效Map

项目中内嵌自研有时效的Map，即`AgingMap`，可用来取代Redis；如项目数据较为庞大请切换为Redis等其他NoSQL。



