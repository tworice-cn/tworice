import Vue from 'vue';
export function type(){
    return Vue.prototype.$axios({
        url: '/client/systemFeedback/type',
        method: 'get'
    })
}