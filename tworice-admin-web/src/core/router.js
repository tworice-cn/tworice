import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export const constantRoutes = [{
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
},{
    path: "/admin",
    component: () => import("@/views/admin/index"),
    children: [],
}];

export default new Router({
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes,
    base: "/"
})

