# 二饭单服务快速开发框架

## 0、简介

本系统基于SpringBoot、MyBatis、Vue & Element实现的后台系统，支持RBAC动态菜单&权限；

### 0.1、角色管理

本系统的采用RBAC权限模型，通俗点说就是：一个角色可以拥有多个菜单（一对多），一个人员账号可以绑定多个角色（一对多），所以人员账号就可以拥有多个菜单了（多对多）。

<img src="IMG\角色管理.png" alt="image-20230421222410100" />

本系统的【角色管理】中有两大功能，分别是【权限管理】和【设置人员】，设置人员又可以理解成为当前角色绑定用户账号。

### 0.2、权限管理

<img src="IMG\权限管理.png" alt="image-20230421222410100" />

权限管理是对当前角色设置访问权限，界面中展示的全部都是菜单选项，可以理解为【设置当前角色进入系统后可以看到的左侧菜单项】。未勾选的选项不会显示在当前角色的菜单栏。

### 0.3、设置人员

![image-20230421231613140](IMG\角色设置人员.png)

此操作就是为角色绑定用户账号，左侧是待选列表，右侧是已经选了（已绑定）的用户账号。这里无需确认，每一次的【移除人员】和【添加人员】操作都会实时保存。



### 0.4、菜单渲染

所有角色、所有用户的登录界面都是同一个，系统在接收登录请求后，获取当前用户的角色绑定了哪些权限（菜单），就把哪些菜单渲染到界面左侧，所以决定当前账户有哪些菜单项是通过给角色设置权限。

两个不同角色的用户登录系统后左侧菜单列表也不同，但两个相同角色下的用户登录系统后的菜单项是相同的。



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





## 4、组件

### 4.1、时效Map

项目中内嵌自研有时效的Map，即`AgingMap`，可用来取代Redis；如项目数据较为庞大请切换为Redis等其他NoSQL。





## 5、第三方支持

### 5.1、SpringBootAdmin

引入：

```xml
<dependency>
    <groupId>cn.tworice</groupId>
    <artifactId>tworice-admin-starter</artifactId>
    <version>1.0</version>
</dependency>
```

增加配置文件：

```yml
spring:
  application:
    name: 应用
  boot:
    admin:
      client:
        url: http://localhost:88
        instance:
          prefer-ip: true
management:
  endpoints:
    web:
      exposure:
        include: '*'
  endpoint:
    health:
      show-details: always
    shutdown:
      enabled: true
```

可根据实际需求调整。



### 6.2、图形验证码

项目支持算数和字符两种图形验证码，默认为算数验证码。

可通过如下配置来改变验证码类型：

```yml
tworice:
	captcha:
    	type: arithmetic # 算数验证码
```

type的取值：`arithmetic`（算数），`character`（字符）；其中字符验证码不分大小写。



