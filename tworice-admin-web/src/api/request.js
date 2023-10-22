import Vue from 'vue';
const service=Vue.prototype.$axios.create({
    baseURL: Vue.prototype.$url,
    timeout: 30000,// 超时
    withCredentials: false,// 禁用 Cookie 等信息
})
export default service;