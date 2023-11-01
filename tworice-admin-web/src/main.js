import Vue from 'vue'
import App from './App.vue'
import './assets/css/icon.css'
import '@/assets/css/app.css'

import 'default-passive-events'
Vue.config.productionTip = false;

// 全局设置
import setting from './core/setting.js'
import utils from './core/utils.js'
Vue.prototype.$setting=setting;
Vue.prototype.$utils=utils;
Vue.prototype.$url = setting.baseURL;


// 全屏组件
import screenfull from './core/screenfull.js'
Vue.prototype.$screenfull=screenfull

// 主题
// import '@/assets/theme/mimicry-theme.less'
import '@/assets/theme/arco-pro-theme.less'
// import '@/assets/theme/default-theme.less'

// Echarts
import * as echarts from 'echarts';
Vue.prototype.$echarts=echarts;

// ElementUI
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);
import { Message,Notification } from 'element-ui';
Vue.prototype.$msg=Message;

// Loading加载界面
import Loading from './components/commons/loading.vue'
Vue.component("Loading",Loading);//注册全局组件

// Vue路由
import {setupRouter} from '@/core/router.js'
let router = setupRouter();

// Axios
import axios from 'axios'
Vue.prototype.$axios = axios;
axios.defaults.headers.common['token'] = '';
axios.defaults.headers.common['adminID'] = '';
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
// 添加一个请求拦截器
axios.interceptors.request.use(function (config) {
      let token = window.sessionStorage.getItem('token')||'';
      let admin = window.sessionStorage.getItem('admin')||{};
      config.headers.common['token'] = token;
      config.headers.common['adminID'] = admin.id;
      return config;
}, function (error) {
      return Promise.reject(error);
});
// 添加一个响应拦截器
axios.interceptors.response.use(
    function (response) {
          vue.loading=false;
          if (response.data.status) {
                vue.loading=false;
                let code=parseInt(response.data.status.code);
                if(code>=400){
                      Notification({ title: '提示', type: code===400?'info':(code===401?'warning':'error'), message: response.data.status.message });
                      if(code === 401) {router.push('/login');}
                } else if(code === 201){
                      Message({ type:'success', message:response.data.status.message });
                      response.data.status.code=200;
                }
          }
          return response;
    },()=> {
          Notification({ title: '提示', type: 'warning', message: '服务器连接异常' })
          vue.loading=false;
    }
)

// 设置全局前置守卫配置
router.beforeEach((to, from, next) => {
      /* 路由发生变化修改页面title */
      if (to.meta.title) {
            document.title = to.meta.title;
      } else {
            document.title = setting.systemTitle;
      }
      if(to.path === '/'){
            Vue.prototype.$axios.get(setting.baseURL+'admin/index/').then(()=>{
                  next(window.sessionStorage.getItem('index')||'/login');
            })
      }
      next()
});

// 初始化Vue
let vue=new Vue({
      router,
      render: h => h(App),
      data(){
            return{
                  loading:setting.loading // 全局属性，通过$root
            }
      }
}).$mount('#app');

// 全局函数
Vue.prototype.$mergeJSON=function(obj1,obj2){
      for (let key in obj2) {
            if (obj2[key] !== null && obj2[key] !== undefined && obj2[key] !== '') {
                  if (typeof obj2[key] === 'object' && !Array.isArray(obj2[key])) {
                        if (!obj1[key]) {
                              obj1[key] = {};
                        }
                        mergeJSON(obj1[key], obj2[key]);
                  } else {
                        obj1[key] = obj2[key];
                  }
            }
      }
      return obj1;
}

// 导出
export default Vue.prototype;