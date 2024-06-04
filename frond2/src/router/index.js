import Vue from 'vue'
import VueRouter from 'vue-router'
import nav from '@/utils/nav'
import store from '../store'
Vue.use(VueRouter)

if (sessionStorage.getItem("token")){
    store.commit("set_token", sessionStorage.getItem("token"))
}
const routes = [
{
path: '/',
redirect: '/home'
},
{
path: "/login",
name: "Login",
meta: {
title: 'Login'
},
component: () => import ( /* webpackChunkName: "login" */ "../views/Login.vue")
},
{
path: "/item",
name: "item",
meta: {
title: 'item'
},
component: () => import ( /* webpackChunkName: "item" */ "../views/item.vue")
},
{
path: "/category",
name: "category",
meta: {
title: 'category'
},
component: () => import ( /* webpackChunkName: "category" */ "../views/category.vue")
},
{
path: "/show",
name: "show",
meta: {
title: 'show'
},
component: () => import ( /* webpackChunkName: "show" */ "../views/show.vue")
},
{
path: "/exchange_assistant",
name: "exchange_assistant",
meta: {
title: 'exchange_assistant'
},
component: () => import ( /* webpackChunkName: "exchange_assistant" */ "../views/chartgpt.vue")
},
{
path: "/home",
name: "home",
meta: {
title: 'home'
},
component: () => import ( /* webpackChunkName: "home" */ "../views/home.vue")
},
{
path: "/detail",
name: "detail",
meta: {
title: 'detail'
},
component: () => import ( /* webpackChunkName: "detail" */ "../views/detail.vue")
},
{
path: "/post",
name: "post",
meta: {
title: 'post'
},
component: () => import ( /* webpackChunkName: "post" */ "../views/post.vue")
},
{
path: "/users",
name: "users",
meta: {
title: 'users'
},
component: () => import ( /* webpackChunkName: "users" */ "../views/users.vue")
},
{
path: "/apply",
name: "apply",
meta: {
title: 'apply'
},
component: () => import ( /* webpackChunkName: "apply" */ "../views/apply.vue")

},
{
path: "/order",
name: "order",
meta: {
title: 'order'
},
component: () => import ( /* webpackChunkName: "order" */ "../views/order.vue")

},
{
path: "/about",
name: "about",
meta: {
title: 'about'
},
component: () => import ( /* webpackChunkName: "about" */ "../views/about.vue")
},
{
path: "/favourite",
name: "favourite",
meta: {
title: 'favourite'
},
component: () => import ( /* webpackChunkName: "favourite" */ "../views/favourite.vue")
},      {
path: "/myitem",
name: "myitem",
meta: {
title: 'myitem'
},
component: () => import ( /* webpackChunkName: "myitem" */ "../views/myitem.vue")
},
{
path: "/profile",
name: "profile",
meta: {
title: 'profile'
},
component: () => import ( /* webpackChunkName: "profile" */ "../views/profile.vue")
},

];


const router = new VueRouter({
    routes,
     scrollBehavior (to, from, savedPosition) {
        if (savedPosition) {
          return savedPosition
        } else {
          return {
            x: 0,
            y: 0
          }
        }
      }
});


router.beforeEach((to, from, next) => {
  document.title = `${to.meta.title}`
  const role = localStorage.getItem('ms_username')
  if (to.path !== '/login' && store.state.token.length === 0) {
    next('/login')
  } else if (to.meta.permission) {
    role === 'admin'
      ? next()
      : next('/403')
  } else {
    next()
  }
})
export default router;

