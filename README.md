# 二饭单服务快速开发框架

## 0、简介

本系统基于SpringBoot、MyBatis、Vue & Element实现的后台系统，支持RBAC动态菜单&权限；

### 0.1、角色管理

本系统的采用RBAC权限模型，通俗点说就是：一个角色可以拥有多个菜单（一对多），一个人员账号可以绑定多个角色（一对多），所以人员账号就可以拥有多个菜单了（多对多）。

<img src="https://gitee.com/StandFast/tworice/raw/1.0/IMG/角色管理.png" />

本系统的【角色管理】中有两大功能，分别是【权限管理】和【设置人员】，设置人员又可以理解成为当前角色绑定用户账号。

### 0.2、权限管理

<img src="https://gitee.com/StandFast/tworice/raw/1.0/IMG/权限管理.png" alt="image-20230421222410100" />

权限管理是对当前角色设置访问权限，界面中展示的全部都是菜单选项，可以理解为【设置当前角色进入系统后可以看到的左侧菜单项】。未勾选的选项不会显示在当前角色的菜单栏。

### 0.3、设置人员

![image-20230421231613140](https://gitee.com/StandFast/tworice/raw/1.0/IMG/角色设置人员.png)

此操作就是为角色绑定用户账号，左侧是待选列表，右侧是已经选了（已绑定）的用户账号。这里无需确认，每一次的【移除人员】和【添加人员】操作都会实时保存。



### 0.4、菜单渲染

所有角色、所有用户的登录界面都是同一个，系统在接收登录请求后，获取当前用户的角色绑定了哪些权限（菜单），就把哪些菜单渲染到界面左侧，所以决定当前账户有哪些菜单项是通过给角色设置权限。

两个不同角色的用户登录系统后左侧菜单列表也不同，但两个相同角色下的用户登录系统后的菜单项是相同的。



## 1、启动

### 1.1、初始化Maven仓库

将`Dependence`目录下的`tworice`目录放到本地Maven仓库的`cn`目录下。

最终的Maven仓库目录结构应该如下图所示：

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

**注意**：SQL文件不含建库语句，需要自行建库。



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



### 4.2、文件上传

本项目目的是为了尽可能的轻量，不依赖第三方项目及应用，所以文件上传默认采用本地上传。

文件上传分为开发环境和生产环境，采用`tworice.env`配置进行切换，取值范围`dev`、`prod`，分别采用不同的上传方式。

文件的上传路径由配置文件`tworice.file.path`控制，如果是开发环境，默认为`\target\classes\static\`，建议不要修改；生产环境下建议修改该配置为`\static\`。



### 4.3、系统登录

```yml
tworice:
  login:
    captchaAging: 300000 # 验证码的有效时间（毫秒）
    root: root-root # 超级管理员账户
```

如上是系统登录的默认参数，删除后仍然生效。

1、验证码的有效时间包括登录的图形验证码和注册时的邮箱验证码。

2、超级管理员账户默认拥有所有权限，不受数据库限制。格式如：`账号-密码`。



### 4.4、流量监控

流量监控是对访问系统的流量进行监控，流量以IP作为唯一标识，当同一IP的访问频率超过上限时触发拒绝访问。默认情况下本组件不开启，如下是使用方法。

#### 4.4.1、配置文件

```yml
tworice:
  monitor:
    flow: true # 是否开启流量监控
    storage: 300 # 默认流量数据存储上限
    limit: 200 # 默认达到这个值后拒绝访问
    refuse: 60000 # 默认拒绝访问的时间
```

如上是系统流量监控的参数，`flow`默认值是`false`不开启。

#### 4.4.2、添加依赖

```xml
<dependency>
    <groupId>cn.tworice</groupId>
    <artifactId>tworice-admin-starter</artifactId>
    <version>1.0</version>
</dependency>
```



### 4.5、请求效验

#### 4.5.1、拦截请求配置

```yml
tworice:
  auth:
    intercept:
      paths:
        - /admin/**
        - /client/**
```

如上是默认值，不进行配置时，以上内容生效。



#### 4.5.2、放行请求配置

```yml
tworice:
  auth:
    exclude:
      paths:
        - /admin/login/**
        - /editor/**
        - /admin/admin/template
```

如上是默认值，不进行配置时，以上内容生效。



### 4.6、邮箱支持

默认邮箱发送邮箱名称为`二饭技术`，可修改配置文件`tworice.mail.header`项来设置邮件发送人。



### 4.7、数据库备份

分别支持通过请求数据接口，传递数据库配置来进行数据库备份，并将备份数据发送至指定邮箱。

① Maven引入：

```xml
<dependency>
    <groupId>cn.tworice</groupId>
    <artifactId>tworice-backup-starter</artifactId>
    <version>1.0</version>
</dependency>
```

② 添加配置：

```
tworice:
  backup:
  	enabled: false  # 默认未开启，是否开启自动备份，开启后根据Cron表达式和邮箱进行数据库备份
    path: backup  # 当前为默认值，指定SQL备份目录
    cron: '0 0 2 * * *'  # 当前为默认值，Cron 表达式，表示每日凌晨两点执行备份
    email: 123456@qq.com  # 默认为空，指定接收备份数据库的邮箱
```

系统提供多个对外接口，您也可以在系统启动后根据接口文档进行动态的指定数据库备份规则。



## 5、第三方支持

### 5.1、SpringBootAdmin

> Spring Boot Admin是一个监控工具，旨在以一种漂亮且易于访问的方式可视化Spring Boot Actuators提供的信息。
>
> 第三方官方文档：http://docs.spring-boot-admin.com/current/getting-started.html

Maven引入：

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



### 5.2、图形验证码

项目支持**算数**和**字符**两种图形验证码，默认为算数验证码。
图形验证码用在登录中，项目支持算数和字符两种图形验证码，默认为算数验证码。

可通过如下配置来改变验证码类型：

```yml
tworice:
	captcha:
    	type: arithmetic # 算数验证码
```

type的取值：`arithmetic`（算数），`character`（字符）；其中字符验证码不分大小写。



### 5.3、访问白名单

系统支持设置访问系统的白名单IP段，访问机的IP必须在白名单段内，否则无法访问服务。

**Q：**将白名单全部删除后系统显示“当前系统未允许任何IP访问”怎么办？

**A：**将`tworice.dev`配置设置为`true`，表示当前为开发模式，不进行效验。此时重启服务器，进入系统后重新将IP加入到白名单列表中后，将配置修改回去，再次重启服务器。

![image-20230504112557711](https://gitee.com/StandFast/tworice/raw/1.0/IMG/开发模式.png)



### 5.4、数据库文档导出

执行单元测试下的`cn.tworice.DataBaseDoc`，会生成一个`数据库文档.doc`文档在项目根目录。



### 5.5、接口文档

接口文档采用[Knife4j](https://doc.xiaominfo.com/)，基于Swagger。

启动项目后访问`IP:PORT/doc.html`可查看。

## 6、缓存

默认已打开MyBatis二级缓存，可根据需求前往配置文件中进行关闭。



## 7、部署

### 7.1、Docker部署

① package打包项目

② 项目根目录执行

```bash
docker build -t tworice-admin:1.0 .
```

③ 运行docker运行命令

```bash
docker run -d --name tworice-admin -p 888:88 tworice-admin:1.0
```

④ 将镜像打包，到另一个机器上运行

```bash
# 生成一个名为 tworice.tar 的文件，其中 tworice-admin:1.0 是之前构建的镜像的名称和标签，后面可以跟多个镜像
docker save -o tworice.tar tworice-admin:1.0
# 导入镜像到另一台计算机的Docker中
docker load -i images.tar
```

