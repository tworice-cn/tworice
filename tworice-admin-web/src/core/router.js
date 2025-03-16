import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export const constantRoutes = [
    {
        path: "/",
        redirect: "/admin"
    },
    {
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
    }, {
        path: "/admin/userCenter/:id",
        component: () => import("@/views/admin/userCenter/userCenter.vue"),
        meta: {title: "用户中心"}
    }, {
        path: "/home", /*客户端*/
        name: "欢迎",
        component: () => import("@/views/front/index/index.vue"),
        children: [],
    }, {
        path: "/admin",
        component: () => import("@/views/admin/index"),
        children: [
            {
                path: "/admin/home",
                name: "首页",
                component: () => import("@/views/admin/home.vue"),
                meta: {title: "首页"}
            },
            {
                path: "showNotice",
                name: '查看公告',
                component: () => import("@/views/admin/showNotice.vue"),
                meta: {title: "查看公告"}
            }
        ],
    },
    {
        path: "/404",
        component: () => import("@/views/admin/404/404.vue"),
        meta: {title: "404"}
    }
];

// 防止连续点击多次路由报错
let routerPush = Router.prototype.push;
let routerReplace = Router.prototype.replace;
// push
Router.prototype.push = function push(location) {
    return routerPush.call(this, location).catch(err => err)
}
// replace
Router.prototype.replace = function push(location) {
    return routerReplace.call(this, location).catch(err => err)
}

export default new Router({
    scrollBehavior: () => ({y: 0}),
    routes: constantRoutes,
    base: "/"
})

