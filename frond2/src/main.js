// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import store from './store'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import * as echarts from 'echarts'
import 'animate.css/animate.min.css';
import WOW from 'wowjs'; // 从 wowjs 对象中解构导入 WOW 类
Vue.prototype.$echarts = echarts
Vue.use(ElementUI)
Vue.use(VueAxios, axios)
Vue.config.productionTip = false
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>',
  render: h => h(App),
  mounted() {
    new WOW.WOW().init();// 初始化 WOW.js
  }
})
axios.defaults.baseURL = '/api'
axios.interceptors.request.use(function (config) {
  if (store.state.token) {
    config.headers.common['Authorization'] = store.state.token
  }
  return config
}, function (error) {
  router.push('/login')
  return Promise.reject(error)
})
// Vue.prototype.$http = axios
