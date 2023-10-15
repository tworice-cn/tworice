import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

export function setupRouter(setting) {
    const router =
        //$start
        [
            {path: "/", redirect: "/admin"},
            {path: "/login", component: () => import("@/components/login/index.vue"), meta: {title: "登录"}},
            {path: "/bigScreen", component: () => import("@/components/admin/home.vue"), meta: {title: "实时监控"}},
            {
                path: "/admin",
                name: "首页",
                component: () => import("../components/admin"),
                children: [
                    {
                        path: "home",
                        name: "我的首页",
                        component: (resolve) => require(["@/components/admin/home.vue"], resolve)
                    },
                    {
                        path: "userCenter/:id",
                        name: "用户中心",
                        component: (resolve) => require(["@/components/admin/userCenter.vue"], resolve)
                    },
                    {
                        path: "file",
                        name: "我的文件",
                        component: (resolve) => require(["@/components/admin/systemFile.vue"], resolve)
                    },
                ],
            },
            {
                path: "/home",
                name: "欢迎",
                component: () => import("@/components/front"),
                children: [],
            },
            {
                path: "/system",
                name: "系统管理",
                component: () => import("@/components/admin"),
                children: [
                    {
                        path: "resource",
                        name: "资源菜单",
                        component: (resolve) => require(["@/components/admin/resource.vue"], resolve)
                    },
                    {
                        path: "role",
                        name: "角色管理",
                        component: (resolve) => require(["@/components/admin/role.vue"], resolve)
                    },
                    {
                        path: "admin",
                        name: "人员管理",
                        component: (resolve) => require(["@/components/admin/admin.vue"], resolve)
                    },
                    {
                        path: "department",
                        name: "部门管理",
                        component: (resolve) => require(["@/components/admin/department.vue"], resolve)
                    },
                ],
            },
            {path: "/info", name: "信息管理", component: () => import("../components/admin"), children: []},
            {
                path: "/notice",
                name: "公告管理",
                component: () => import("../components/admin"),
                children: [
                    {
                        path: "notice",
                        name: "公告信息",
                        component: (resolve) => require(["@/components/admin/notice.vue"], resolve)
                    },
                    {
                        path: "showNotice",
                        name: "查看公告",
                        component: (resolve) => require(["@/components/admin/showNotice.vue"], resolve)
                    },
                ],
            },
            {
                path: "/log",
                name: "日志管理",
                component: () => import("../components/admin"),
                children: [
                    {
                        path: "log",
                        name: "操作日志",
                        component: (resolve) => require(["@/components/admin/log.vue"], resolve)
                    },
                    {
                        path: "loginLog",
                        name: "登录日志",
                        component: (resolve) => require(["@/components/admin/loginLog.vue"], resolve)
                    },
                    {
                        path: "versionLog",
                        name: "版本日志",
                        component: (resolve) => require(["@/components/admin/versionLog.vue"], resolve)
                    },
                ],
            },
            {
                path: "/tools",
                name: "系统工具",
                component: () => import("../components/admin"),
                children: [
                    {
                        path: "doc",
                        name: "系统接口",
                        component: (resolve) => require(["@/components/admin/doc.vue"], resolve)
                    },
                    {
                        path: "monitor",
                        name: "系统监控",
                        component: (resolve) => require(["@/components/admin/monitor.vue"], resolve)
                    },
                    {
                        path: "codeGeneration",
                        name: "代码生成",
                        component: (resolve) => require(["@/components/admin/codeGeneration.vue"], resolve)
                    },
                    {
                        path: "online",
                        name: "在线账户",
                        component: (resolve) => require(["@/components/admin/online.vue"], resolve)
                    },
                    {
                        path: "dist",
                        name: "字典管理",
                        component: (resolve) => require(["@/components/admin/dist.vue"], resolve)
                    },
                    {
                        path: "whiteList",
                        name: "访问白名单",
                        component: (resolve) => require(["@/components/admin/whiteList.vue"], resolve)
                    },
                    {
                        path: "admin",
                        name: "应用监控",
                        component: (resolve) => require(["@/components/tools/SpringBootAdmin.vue"], resolve)
                    },
                ],
            },
            {
                path: "/dev",
                name: "开发示例",
                component: () => import("../components/admin"),
                children: [
                    {
                        path: "editor",
                        name: "富文本引入示例",
                        component: (resolve) => require(["@/components/dev/editor.vue"], resolve)
                    },
                    {
                        path: "jump",
                        name: "跳转页面",
                        component: (resolve) => require(["@/components/dev/jump.vue"], resolve)
                    },
                    {
                        path: "upload",
                        name: "文件上传",
                        component: (resolve) => require(["@/components/dev/upload.vue"], resolve)
                    },
                    {
                        path: "alipay/:id",
                        name: "支付示例",
                        component: (resolve) => require(["@/components/dev/alipay.vue"], resolve)
                    },
                    {
                        path: "goods/:id",
                        name: "商品详情页",
                        component: (resolve) => require(["@/components/dev/goods.vue"], resolve)
                    },
                    {
                        path: "aes",
                        name: "AES加密",
                        component: (resolve) => require(["@/components/dev/aes.vue"], resolve)
                    },
                    {
                        path: "ocr",
                        name: "OCR识别",
                        component: (resolve) => require(["@/components/dev/ocr.vue"], resolve)
                    },
                ],
            },
        ];
    //$end
    let vueRouter = new VueRouter({routes: router});
    vueRouter.beforeEach((to, from, next) => {
        /* 路由发生变化修改页面title */
        if (to.meta.title) {
            document.title = to.meta.title;
        } else {
            document.title = setting.systemTitle;
        }
        next()
    })

    return vueRouter;
}
