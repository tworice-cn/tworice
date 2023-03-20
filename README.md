# 二饭单服务快速开发框架

## 简介

本系统基于SpringBoot、MyBatis、Vue & Element实现的后台系统，支持RBAC动态菜单&权限；



## 1、启动

### 1.1、初始化Maven仓库

将`Dependence`目录下的`tworice`目录放到Maven仓库的`cn`目录下。

最终的Maven目录结构应该如下图所示：

```
├── Maven仓库路径							// 你本机的本地Maven仓库
│       └── ...
│       └── cn
│       	└── tworice
│       		└── cloud-server
│       		└── tworice-admin
│       		└── ...
```



### 1.2、导入SQL文件

本系统采用MySQL8.0，注意数据库版本。

SQL文件在`sql`目录下，文件以日期命名，请使用最新日期的SQL文件。

注意：SQL文件不含建库语句，需要自行建库。



### 1.3、启动服务端

使用IDEA工具导入项目目录`tworice-admin`。

等待加载依赖后启动`cn.tworice.Application`。



### 1.4、启动客户端

① 使用IDEA或其他开发工具导入项目目录`tworice-admin-web`。

② 在该目录下输入命令行`npm run serve`。



## 2、技术选型

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



## 3、项目结构

| 模块                | 说明                     | 是否必须 |
| ------------------- | ------------------------ | -------- |
| `tworice-admin`     | 基础组件，可针对方法重写 | 是       |
| `tworice-admin-web` | 管理端前端，使用Vue2开发 | 否       |



## 4、系统启动

将`Dependence`目录下的文件拷贝到`本地Maven仓库/cn/`下；

导入项目`tworice-admin`，设置JDK版本为`1.8`；

运行`Application.java`即可。



## 5、组件

### 5.1、时效Map

项目中内嵌自研有时效的Map，即`AgingMap`，可用来取代Redis；如项目数据较为庞大请切换为Redis等其他NoSQL。



