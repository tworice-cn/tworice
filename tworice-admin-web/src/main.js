import Vue from 'vue'
import App from './App.vue'
import './assets/css/icon.css'
import '@/assets/css/app.css'
import '@/assets/css/layout.css'
import 'default-passive-events'
import RouterUtils from './util/RouterUtils.js'
Vue.config.productionTip = false;
import { createAxiosService } from '@/core/axios-service'

// 全局设置
import setting from './core/setting.js'
import utils from './util/Utils.js'
import storage from './util/StorageUtils'
import screenfull from './util/Screenfull.js'
Vue.prototype.$setting=setting;
Vue.prototype.$utils=utils;
Vue.prototype.$storage=storage;
Vue.prototype.$url = setting.baseURL;
Vue.prototype.$screenfull=screenfull;// 全屏组件

// 增删改查通用方法
import CRUD from "@/api/CRUD";
Vue.prototype.$CRUD = CRUD;

// 主题
// import '@/assets/theme/mimicry-theme.less'
import '@/assets/theme/arco-pro-theme.less'
// import '@/assets/theme/default-theme.less'
// import '@/assets/theme/jzk-theme.less'

// ElementUI
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);
import { Message,Notification } from 'element-ui';
Vue.prototype.$msg = Message;

// Loading加载界面
import Loading from './components/commons/Loading.vue'
Vue.component("Loading",Loading);//注册全局组件

// Vue路由
import router from '@/core/router.js'

// Axios
// 创建 Axios 实例
const service = createAxiosService(router, setting.baseURL)
Vue.prototype.$axios = service

window.onbeforeunload = function () {//刷新会触发这个事件
      if(window.localStorage.getItem("resources")){
            sessionStorage.setItem("RefreshRouter", false);
                  }
};
// 设置全局前置守卫配置
router.beforeEach((to, from, next) => {
      RouterUtils.refreshRouter(router,to).then(() => {
            /* 路由发生变化修改页面title */
            document.title = to.meta.title ? to.meta.title : setting.systemTitle;
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