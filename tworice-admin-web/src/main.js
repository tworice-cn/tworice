import Vue from 'vue'
import App from './App.vue'
import './assets/css/icon.css'
import '@/assets/css/app.css'
import Crypt from "@/components/commons/crypt/crypt";
import 'default-passive-events'
import RouterUtils from './util/RouterUtils.js'
Vue.config.productionTip = false;

// 全局设置
import setting from './core/setting.js'
import utils from './util/Utils.js'
import screenfull from './util/Screenfull.js'
Vue.prototype.$setting=setting;
Vue.prototype.$utils=utils;
Vue.prototype.$url = setting.baseURL;
Vue.prototype.$screenfull=screenfull;// 全屏组件

// 增删改查通用方法
import CRUD from "@/api/CRUD";
Vue.prototype.$CRUD = CRUD;

// 主题
// import '@/assets/theme/mimicry-theme.less'
// import '@/assets/theme/arco-pro-theme.less'
import '@/assets/theme/default-theme.less'
// import '@/assets/theme/jzk-theme.less'

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
import router from '@/core/router.js'

// Axios
import axios from 'axios'
let service = axios.create({
    baseURL: Vue.prototype.$url,
    timeout: 30000,// 超时
    withCredentials: false,// 禁用 Cookie 等信息
})
service.defaults.headers.common['token'] = '';
service.defaults.headers.common['adminID'] = '';
service.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
// 添加一个请求拦截器
service.interceptors.request.use(function (config) {
      let token = window.localStorage.getItem('token')||'';
      let admin = JSON.parse(window.localStorage.getItem('admin')||'{}');
      config.headers.common['token'] = token;
      config.headers.common['adminID'] = admin.id;
      return config;
}, function (error) {
      return Promise.reject(error);
});
// 添加一个响应拦截器
service.interceptors.response.use(
    function (response) {
          vue.loading=false;
          if (response.data.status) {
                vue.loading=false;
                let code=parseInt(response.data.status.code);
                if(code>=400){
                      Notification({ title: '提示', type: code===400?'info':(code===401?'warning':'error'), message: response.data.status.message });
                      if(code === 401) {router.push('/login');}
                } else if(code === 201){ // 显示通知
                      Message({ type:'success', message:response.data.status.message });
                      response.data.status.code=200;
                } else if(code === 202){ // 数据进行了加密
                      if(response.data.data.crypt){
                            response.data.data=JSON.parse(Crypt.decrypt(response.data.data));
                      }
                      response.data.status.code=200;
                }
          }
          return response;
    },()=> {
          Notification({ title: '提示', type: 'warning', message: '服务器连接异常' })
          vue.loading=false;
    }
)
Vue.prototype.$axios = service;

window.onbeforeunload = function () {//刷新会触发这个事件
      if(window.localStorage.getItem("resources")){
            sessionStorage.setItem("RefreshRouter", false);
                  }
};
// 设置全局前置守卫配置
router.beforeEach((to, from, next) => {
      RouterUtils.refreshRouter(router,to).then(() => {
            // router.push(to);
            /* 路由发生变化修改页面title */
            if (to.meta.title) {
                  document.title = to.meta.title;
            } else {
                  document.title = setting.systemTitle;
            }
            if (to.path === '/') {
                  if(setting.needLogin){
                        Vue.prototype.$axios.get(setting.baseURL + 'admin/index/').then(() => {
                              next(window.localStorage.getItem('index') || '/login');
                        });
                  }else{
                        next(setting.defaultTab || '/admin')
                  }
            }
            next()
      })
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

// 导出
export default Vue.prototype;