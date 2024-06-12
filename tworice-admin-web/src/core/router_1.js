import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

export function setupRouter() {
    const router =


//$start
        [{
            path: "/login",
            component: () => import("@/views/login/index5.vue"),
            meta: {title: "登录"}
        }, {
            path: "/bigScreen",
            component: () => import("@/views/admin/home.vue"),
            meta: {title: "实时监控"}
        }, {
            path: "/download/:id",
            component: () => import("@/views/admin/file/download.vue"),
            meta: {title: "下载中心"}
        },{
            path: "/admin/userCenter/:id",
            component: () => import("@/views/admin/userCenter/userCenter.vue"),
            meta: {title: "用户中心"}
        }, {
            path: "/home", /*客户端*/
            name: "欢迎",
            component: () => import("@/views/front/index/index.vue"),
            children: [],
        }, {
            path: "/admin", /*管理端*/
            name: "首页",
            component: () => import("@/views/admin"),
            children: [{
                path: "home",
                name: "我的首页",
                component: (resolve) => require(["@/views/admin/home.vue"], resolve)
            }, {
                path: "file",
                name: "我的文件",
                component: (resolve) => require(["@/views/admin/file/systemFile.vue"], resolve)
            },

            ],
        }, {
            path: "/system",
            name: "系统管理",
            component: () => import("@/views/admin"),
            children: [{
                path: "resource",
                name: "资源菜单",
                component: (resolve) => require(["@/views/admin/resource.vue"], resolve)
            }, {
                path: "role",
                name: "角色管理",
                component: (resolve) => require(["@/views/admin/role.vue"], resolve)
            }, {
                path: "admin",
                name: "人员管理",
                component: (resolve) => require(["@/views/admin/admin.vue"], resolve)
            }, {
                path: "department",
                name: "部门管理",
                component: (resolve) => require(["@/views/admin/department.vue"], resolve)
            },],
        }, {
            path: "/info",
            name: "信息管理",
            component: () => import("../views/admin"),
            children: []
        }, {
            path: "/infra",
            name: "基础设施",
            component: () => import("../views/admin"),
            children: [{
                path: "notice",
                name: "公告信息",
                component: (resolve) => require(["@/views/admin/notice.vue"], resolve)
            }, {
                path: "showNotice",
                name: "查看公告",
                component: (resolve) => require(["@/views/admin/showNotice.vue"], resolve)
            }, {
                path: "feedback",
                name: "用户反馈",
                component: (resolve) => require(["@/views/admin/feedback/systemFeedback.vue"], resolve)
            }, {
                path: "feedbackType",
                name: "反馈类型",
                component: (resolve) => require(["@/views/admin/feedback/systemFeedbackType.vue"], resolve)
            },],
        }, {
            path: "/log",
            name: "日志管理",
            component: () => import("../views/admin"),
            children: [{
                path: "log",
                name: "操作日志",
                component: (resolve) => require(["@/views/admin/log.vue"], resolve)
            }, {
                path: "loginLog",
                name: "登录日志",
                component: (resolve) => require(["@/views/admin/loginLog.vue"], resolve)
            }, {
                path: "versionLog",
                name: "版本日志",
                component: (resolve) => require(["@/views/admin/versionLog.vue"], resolve)
            },],
        }, {
            path: "/tools",
            name: "系统工具",
            component: () => import("../views/admin"),
            children: [{
                path: "doc",
                name: "系统接口",
                component: (resolve) => require(["@/views/admin/doc.vue"], resolve)
            }, {
                path: "monitor",
                name: "系统监控",
                component: (resolve) => require(["@/views/admin/monitor.vue"], resolve)
            }, {
                path: "codeGeneration",
                name: "代码生成",
                component: (resolve) => require(["@/views/admin/codeGeneration/codeGeneration.vue"], resolve)
            }, {
                path: "online",
                name: "在线账户",
                component: (resolve) => require(["@/views/admin/online.vue"], resolve)
            }, {
                path: "dict",
                name: "字典管理",
                component: (resolve) => require(["@/views/admin/dict.vue"], resolve)
            }, {
                path: "whiteList",
                name: "访问白名单",
                component: (resolve) => require(["@/views/admin/whiteList.vue"], resolve)
            }, {
                path: "admin",
                name: "应用监控",
                component: (resolve) => require(["@/views/tools/SpringBootAdmin.vue"], resolve)
            },],
        }, {
            path: "/dev",
            name: "开发示例",
            component: () => import("../views/admin"),
            children: [{
                path: "editor",
                name: "富文本引入示例",
                component: (resolve) => require(["@/views/dev/editor.vue"], resolve)
            }, {
                path: "jump",
                name: "跳转页面",
                component: (resolve) => require(["@/views/dev/jump.vue"], resolve)
            }, {
                path: "upload",
                name: "文件上传",
                component: (resolve) => require(["@/views/dev/upload.vue"], resolve)
            }, {
                path: "alipay/:id",
                name: "支付示例",
                component: (resolve) => require(["@/views/dev/alipay.vue"], resolve)
            }, {
                path: "goods/:id",
                name: "商品详情页",
                component: (resolve) => require(["@/views/dev/goods.vue"], resolve)
            }, {
                path: "aes",
                name: "AES加密",
                component: (resolve) => require(["@/views/dev/aes.vue"], resolve)
            }, {
                path: "ocr",
                name: "OCR识别",
                component: (resolve) => require(["@/views/dev/ocr.vue"], resolve)
            }, {path: "ws", name: "WebSocket", component: (resolve) => require(["@/views/dev/ws.vue"], resolve)},],
        },];
//$end


    return new VueRouter({routes: router, base: "/"});
}
