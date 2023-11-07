import Vue from 'vue';
export function list(params){
    return Vue.prototype.$axios({
        url: '/admin/admin/list',
        method: 'get',
        params: params
    })
}