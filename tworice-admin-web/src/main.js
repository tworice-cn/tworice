import Vue from 'vue'
import App from './App.vue'
import './assets/css/icon.css'
import './assets/css/app.css'

import 'default-passive-events'
Vue.config.productionTip = false;

// 全局设置
import setting from './core/setting.js'
import utils from './core/utils.js'
Vue.prototype.$setting=setting;
Vue.prototype.$utils=utils;
Vue.prototype.$url = setting.baseURL;

// Vue路由
import {setupRouter} from '@/core/router.js'
let router = setupRouter(setting);

// 初始化Vue
let vue=new Vue({
      router,
      render: h => h(App),
      data(){
            return{
                  loading:false // 全局属性，通过$root
            }
      }
}).$mount('#app')

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
import { Message } from 'element-ui';
Vue.prototype.$msg=Message;

// TDesign
import TDesign from 'tdesign-vue';
Vue.use(TDesign);

// Loading加载界面
import Loading from './components/commons/loading.vue'
Vue.component("Loading",Loading);//注册全局组件

// Axios
import {setupAxios} from '@/core/axiosConfig.js'
Vue.prototype.$axios = setupAxios(vue,router);







