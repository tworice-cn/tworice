# 二饭单服务快速开发框架

 <p align="center">
    <img src="https://img.shields.io/badge/RELEASE-V1.4.1-green.svg" alt="Downloads">
    <img src="https://img.shields.io/badge/JDK-1.8+-green.svg" alt="Build Status">
    <img src="https://img.shields.io/badge/Spring%20Cloud-Hoxton.SR12-blue.svg" alt="Coverage Status">
    <img src="https://img.shields.io/badge/Spring%20Boot-2.3.12.RELEASE-blue.svg" alt="Downloads">
    <img src="https://img.shields.io/badge/Vue-2.6.11-blue.svg" alt="Downloads">
     <img src="https://img.shields.io/badge/MySQL-8.0+-blue.svg" alt="Downloads">
</p>




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



### 0.5、快速上手

#### 0.5.1、如何快速创建页面

##### ① 代码生成

在“系统工具-代码生成”功能中，您可以填写表名、字段以及字段类型等信息，然后执行生成操作。

生成成功后，后端项目会自动生成包括`client`、`service`、`dao`、`po`等文件，同时会在数据库中创建相应的表结构。

前端项目则会在`code`文件夹下生成相应的`vue`页面文件。

##### ② 重启后端项目

由于后端项目不支持热加载，所以需要重启项目来使刚刚生成代码生效。

##### ③ 添加菜单

在“系统管理-资源菜单”中，您可以将刚刚生成的 Vue 页面名称填入相应位置。

“更新路由”操作表示将当前页面的路径添加到本地的 `VueRouter` 文件中，以便在前端项目中能够访问到这个新生成的页面。

![image-20230421231613140](https://gitee.com/StandFast/tworice/raw/master/IMG/添加菜单.png)

##### ④ 重新登录

重新登录系统，获取最新的资源菜单，即可看到刚刚生成的页面了。



#### 0.5.2、改造系统底层

系统通过依赖注入的方式实现了代码的灵活性，如果需要修改系统底层代码，可以通过继承相关类并重写方法来实现。此外，系统还提供了丰富的配置和插件功能，几乎所有功能都可以通过配置文件来进行配置。您可以查看下方的详细文档，通过标题快速索引以获取更多信息。



## 1、启动

### 1.1、导入SQL文件

本系统采用`MySQL8.0`，注意数据库版本。

SQL文件在`sql`目录下，文件以日期命名，请使用最新版本的SQL文件。

**注意**：SQL文件不含建库语句，需要自行建库。



### 1.2、启动服务端

> 推荐使用IDEA开发工具

使用IDEA开发工具打开项目根目录，并加载`tworice-admin`下的pom文件。

等待加载依赖后启动`cn.tworice.Application`。



### 1.3、启动客户端

> 客户端使用Vue2开发，推荐使用IDEA开发工具启动

#### 1.3.1、安装依赖

在命令行模式进入`tworice-web`根目录下执行`npm install`安装依赖。

#### 1.3.2、启动

① 命令行形式启动：依赖安装完成后在该目录下输入命令行`npm run serve`启动。

② IDEA运行：添加`npm`运行配置。

![image-20250208211654786](https://gitee.com/StandFast/tworice/raw/master\IMG\IDEA启动客户端.png)



## 2、技术选型

| 技术         | 说明                          | 官网                                                 |
| ------------ | ----------------------------- | ---------------------------------------------------- |
| SpringBoot   | v2.3.12.RELEASE，容器+MVC框架 | https://spring.io/projects/spring-boot               |
| MyBatis      | v3.5.13，ORM框架              | http://www.mybatis.org/mybatis-3/zh/index.html       |
| MyBatis-Plus | v3.5.4，简化MyBatis开发       | [MyBatis-Plus (baomidou.com)](https://baomidou.com/) |
| MySQL        | v8.0                          | https://www.oracle.com/kr/mysql/                     |
| Hikari       | 数据库连接池                  | https://github.com/alibaba/druid                     |
| JWT          | JWT登录支持                   | https://github.com/jwtk/jjwt                         |
| Lombok       | 简化对象封装工具              | https://github.com/rzwitserloot/lombok               |
| Swagger-UI   | 文档生成工具                  | https://github.com/swagger-api/swagger-ui            |
| zXing        | 谷歌二维码生成技术            | https://github.com/*zxing*/zxing                     |
| EasyCaptcha  | Java图形验证码                | https://gitee.com/ele-admin/EasyCaptcha              |
| wangEditor   | 富文本编辑器                  | https://www.wangeditor.com/                          |
| easyExcel    | 阿里巴巴Excel操作工具         | https://easyexcel.opensource.alibaba.com/            |
| Node.JS      | v16.18.0                      | https://nodejs.org/                                  |
| Vue          | v2.7.16                       | https://cn.vuejs.org/                                |



## 3、项目结构

| 模块                | 说明                     | 是否必须 |
| ------------------- | ------------------------ | -------- |
| `tworice-admin`     | 基础组件，可针对方法重写 | 是       |
| `tworice-admin-web` | 管理端前端，使用Vue2开发 | 否       |



## 4、组件

### 4.1、时效Map

项目中内嵌自研有时效的Map，即`AgingMap`，可用来取代`Redis`；如项目数据较为庞大请切换为`Redis`等其它`NoSQL`。



### 4.2、文件上传

本项目目的是为了尽可能的轻量，不依赖第三方项目及应用，所以文件上传默认采用本地上传。

文件上传分为开发环境和生产环境，采用`tworice.env`配置进行切换，取值范围`dev`、`prod`，分别采用不同的上传方式。

文件的上传路径由配置文件`tworice.file.path`控制，如果是开发环境，默认为`项目根目录\upload\`，建议不要修改。



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
    <version>${tworice.version}</version>
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
    <version>${tworice.version}</version>
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



### 4.8、系统初始化

为了方便用户对系统进行初始化，系统设置了一个开发接口：

`GET IP:PORT/admin/system/recovery`

该接口会去读取项目根目录下的`/recovery/recovery.sql`SQL脚本文件，并将所有系统数据表进行初始化。



### 4.9、加密组件

系统中加密组件利用工厂模式实现，支持多种加密方式。

#### 4.9.1、使用加密组件

① 加入依赖

```xml
<dependency>
    <groupId>cn.tworice</groupId>
    <artifactId>tworice-cryption</artifactId>
</dependency>
```

加入依赖后默认配置如下：

```yaml
tworice:
  cryption:
    enable: true
    type: AES
    key: 1234567890hijklm
    pointcut: execution(public * cn.tworice.client.web..*.*(..)) || execution(public * cn.tworice.*.controller..*.*(..))
```

② 配置说明

`enable`：可选值是`true`、`false`，分别表示开启和关闭自动加密。

`type`：加密类型，可选值为`AES`、`Base64`，后续会持续增加不同的加密类型支持。

`key`：加密密钥，如果当前加密类型需要密钥。

`pointcut`：配置需要加密的接口切入点。

#### 4.9.2、排除加密接口

系统主要通过Swagger的相关注解进行加密接口返回结果，为接口访问接口添加`@NoEncryption`注解或去掉`@ApiOperation`注解，系统将不对该接口返回的结果进行加密。

```java
@GetMapping("captcha")
@ApiOperation("获取验证码图片")
@NoEncryption
public RequestResult captcha(String code){
    CaptchaBase64 captcha = loginService.getLoginCaptcha(code);
    // 构建返回客户端数据对象
    return RequestResult.success()
            .appendData("captcha", captcha.getCaptcha())
            .appendData("key", captcha.getKey());
}
```

#### 4.9.3、扩展加密方式

服务端加密服务主要使用的是工厂模式，如果你需要扩展自己的加密方式。

① 需要实现`cn.tworice.cryption.service.CryptService`接口。

② 并在`CryptionConfig`中配置你的加密实现。

③ 在前端项目中的`crypt.js`中进行同步解密操作即可实现自定义加密方式。



#### 4.9.4、数据库加密方式

为Service层实现`DataBaseCryption<T>`接口，其中`<T>`是数据库对应的实体类。

实现`DataBaseCryption`接口中的`encrypt`和`decrypt`方法，示例如下：

```java
@Resource
private CryptService cryptService;

@Override
public ChatLog encrypt(ChatLog entity) {
    entity.setMsgContent(cryptService.encrypt(entity.getMsgContent()));
    return entity;
}

@Override
public ChatLog decrypt(ChatLog entity) {
    entity.setMsgContent(cryptService.decrypt(entity.getMsgContent()));
    return entity;
}
```

`CryptService`是组件提供的默认加密接口。



### 4.10、系统登录

#### 4.10.1、二次验证

```
tworice:
	login:
		reAuth: false
```

二次验证表示在用户登录密码正确的情况下再次向绑定邮箱发送验证口令来确认身份。当账户未绑定邮箱时系统会跳过二次验证。



### 4.11、状态码

| 状态码 | 含义                       |
| ------ | -------------------------- |
| 200    | 请求正常通过，不展示通知   |
| 201    | 请求正常通过，展示通知消息 |
| 202    | 请求结果被加密             |
| 300    | 登录请求需要进行二次验证   |
| 500+   | 系统处理错误               |

### 4.12、生成式大模型

配置项：

```yaml
tworice:
	chatbot:
		api-key: xxx
		secret-key: xxx
		client-type: baidu
		model: ERNIE-Speed-128K
```

`client-type`取值范围：

| 值    | 描述       |
| ----- | ---------- |
| baidu | 千帆大模型 |
| sizhi | 思知       |



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
    <version>${tworice.version}</version>
</dependency>
```

增加配置文件（以下配置文件为默认，可根据实际需求调整）：

```yml
spring:
  application:
    name: 应用
  boot:
    admin:
      client:
        url: http://localhost:${server.port}
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



### 5.2、图形验证码

项目支持**算数**和**字符**两种图形验证码，默认为算数验证码。
图形验证码用在登录中，项目支持算数和字符两种图形验证码，默认为算数验证码。

可通过如下配置来改变验证码类型：

```yml
tworice:
	login:
		captchaType: arithmetic # 算数验证码
```

type的取值：`arithmetic`（算数），`character`（字符）；字符验证码不分大小写。



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

② 将生成的jar包放到`/docker/jar/`中。

③ 将配置文件放到`/docker/config`中。

④ 将docker目录上传到服务器。

⑤ 在服务器进入docker目录，运行docker运行如下命令来构建镜像：

```sh
docker build -t tworice-admin:latest .
```

⑥ 启动容器

```bash
docker run -d --name {替换为容器名称} -v {替换为jar目录绝对路径}:/jar -v {替换为config目录绝对路径}:/config -v {替换为文件上传目录绝对路径}:/upload -v {替换为日志文件目录绝对路径}:/logs -p {替换为外部端口}:88 tworice-admin:latest
```

⑦ 更新配置文件或jar包

替换本地的jar目录中的jar包及config目录下的配置文件即可。

替换完成后重启Docker容器：`docker restart {替换为容器名称}`。
