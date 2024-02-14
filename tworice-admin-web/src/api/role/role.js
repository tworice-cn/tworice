import Vue from 'vue';
export function list(){
    return Vue.prototype.$axios({
        url: 'admin/system/role/list',
        method: 'GET'
    })
}