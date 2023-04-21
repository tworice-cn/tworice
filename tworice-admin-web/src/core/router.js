import Vue from "vue";
import VueRouter from "vue-router";
Vue.use(VueRouter);
const router =
      //$start
      [
            { path: "/", redirect: "/admin" },
            { path: "/login", component: () => import("@/components/login"), meta: { title: "登录" } },
            { path: "/bigScreen", component: () => import("@/components/index/home.vue"), meta: { title: "实时监控" } },
            {
                  path: "/admin",
                  name: "首页",
                  component: () => import("@/components/index"),
                  children: [
                        { path: "home", name: "我的首页", component: (resolve) => require(["@/components/index/home.vue"], resolve) },
                        { path: "userCenter/:id", name: "用户中心", component: (resolve) => require(["@/components/index/userCenter.vue"], resolve) },
                        { path: "file", name: "我的文件", component: (resolve) => require(["@/components/index/systemFile.vue"], resolve) },
                  ],
            },
            {
                  path: "/system",
                  name: "系统管理",
                  component: () => import("@/components/index"),
                  children: [
                        { path: "resource", name: "资源菜单", component: (resolve) => require(["@/components/index/resource.vue"], resolve) },
                        { path: "role", name: "角色管理", component: (resolve) => require(["@/components/index/role.vue"], resolve) },
                        { path: "admin", name: "人员管理", component: (resolve) => require(["@/components/index/admin.vue"], resolve) },
                        { path: "department", name: "部门管理", component: (resolve) => require(["@/components/index/department.vue"], resolve) },
                  ],
            },
            { path: "/info", name: "信息管理", component: () => import("@/components/index"), children: [] },
            {
                  path: "/notice",
                  name: "公告管理",
                  component: () => import("@/components/index"),
                  children: [
                        { path: "notice", name: "公告信息", component: (resolve) => require(["@/components/index/notice.vue"], resolve) },
                        { path: "showNotice", name: "查看公告", component: (resolve) => require(["@/components/index/showNotice.vue"], resolve) },
                  ],
            },
            {
                  path: "/log",
                  name: "日志管理",
                  component: () => import("@/components/index"),
                  children: [
                        { path: "log", name: "操作日志", component: (resolve) => require(["@/components/index/log.vue"], resolve) },
                        { path: "loginLog", name: "登录日志", component: (resolve) => require(["@/components/index/loginLog.vue"], resolve) },
                        { path: "versionLog", name: "版本日志", component: (resolve) => require(["@/components/index/versionLog.vue"], resolve) },
                  ],
            },
            {
                  path: "/tools",
                  name: "系统工具",
                  component: () => import("@/components/index"),
                  children: [
                        { path: "doc", name: "系统接口", component: (resolve) => require(["@/components/index/doc.vue"], resolve) },
                        { path: "monitor", name: "系统监控", component: (resolve) => require(["@/components/index/monitor.vue"], resolve) },
                        { path: "codeGeneration", name: "代码生成", component: (resolve) => require(["@/components/index/codeGeneration.vue"], resolve) },
                        { path: "online", name: "在线账户", component: (resolve) => require(["@/components/index/online.vue"], resolve) },
                        { path: "dist", name: "字典管理", component: (resolve) => require(["@/components/index/dist.vue"], resolve) },
                        { path: "whiteList", name: "访问白名单", component: (resolve) => require(["@/components/index/whiteList.vue"], resolve) },
                        { path: "admin", name: "应用监控", component: (resolve) => require(["@/components/tools/SpringBootAdmin.vue"], resolve) },
                  ],
            },
            {
                  path: "/dev",
                  name: "开发示例",
                  component: () => import("@/components/index"),
                  children: [
                        { path: "editor", name: "富文本引入示例", component: (resolve) => require(["@/components/dev/editor.vue"], resolve) },
                        { path: "jump", name: "跳转页面", component: (resolve) => require(["@/components/dev/jump.vue"], resolve) },
                        { path: "upload", name: "文件上传", component: (resolve) => require(["@/components/dev/upload.vue"], resolve) },
                        { path: "alipay/:id", name: "支付示例", component: (resolve) => require(["@/components/dev/alipay.vue"], resolve) },
                        { path: "goods/:id", name: "商品详情页", component: (resolve) => require(["@/components/dev/goods.vue"], resolve) },
                        { path: "aes", name: "AES加密", component: (resolve) => require(["@/components/dev/aes.vue"], resolve) },
                        { path: "ocr", name: "OCR识别", component: (resolve) => require(["@/components/dev/ocr.vue"], resolve) },
                  ],
            },
      ];
//$end
/**路由对象 */ export default new VueRouter({ routes: router });
