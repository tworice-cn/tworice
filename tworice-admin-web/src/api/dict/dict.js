import Vue from 'vue';
export function dictList(dictId){
    return Vue.prototype.$axios({
        url: 'admin/dictValue/list?dict='+dictId,
        method: 'GET'
    })
}