<template>
  <header class="header navbar-area">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-12">
          <div class="nav-inner">
            <nav class="navbar navbar-expand-lg">
              <div style="font-size: 24px; color: #1a1e21;font-weight: 500" @click="home">
                <img src="../assets/images/logo/logo.jpg" alt="Logo" style="width: 70px;height: 70px"> Item exchange platform
              </div>
              <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                <ul id="nav" class="navbar-nav ms-auto">
                  <li class="nav-item">
                    <router-link class=" dd-menu collapsed" to="home"
                                 data-bs-toggle="collapse" data-bs-target="#submenu-1-3"
                                 aria-controls="navbarSupportedContent" aria-expanded="false"
                                 aria-label="Toggle navigation"> Home  </router-link>
                  </li>
                  <li class="nav-item">
                    <router-link class=" dd-menu collapsed" to="show"
                       data-bs-toggle="collapse" data-bs-target="#submenu-1-3"
                       aria-controls="navbarSupportedContent" aria-expanded="false"
                       aria-label="Toggle navigation"> Product  </router-link>
                  </li>
                  <li class="nav-item">
                    <a class="dd-menu collapsed"
                       data-bs-toggle="collapse" data-bs-target="#submenu-1-4"
                       aria-controls="navbarSupportedContent" aria-expanded="false"
                       aria-label="Toggle navigation">Pages</a>
                    <ul class="sub-menu mega-menu collapse" id="submenu-1-4">
                      <li class="single-block">
                        <ul>
                          <li class="mega-menu-title">Essential Pages</li>
                          <li class="nav-item"><router-link to="about">About Us</router-link></li>
                          <li class="nav-item"><router-link to="exchange_assistant">Exchange assistant</router-link></li>
                          <li class="nav-item"><router-link to="login">Sign In</router-link></li>
                        </ul>
                      </li>
                      <li class="single-block">
                        <ul>
                          <li class="mega-menu-title">Dashboard</li>
                          <div  v-if="ms_type==3">
                            <li class="nav-item"><router-link to="profile">My Profile</router-link></li>
                            <li class="nav-item"><router-link to="myitem">My Product</router-link></li>
                            <li class="nav-item"><router-link to="favourite">MY Favorite</router-link></li>
                            <li class="nav-item"><router-link to="order">MY Order</router-link></li>
                            <li class="nav-item"><router-link to="apply">MY Apply</router-link></li>
                            <li class="nav-item"><router-link to="post">Ad post</router-link></li>
                          </div>
                            <div  v-if="ms_type==1">
                              <li class="nav-item"><router-link  to="item">Product Manager</router-link></li>
                              <li class="nav-item"><router-link to="Category">Category Manager</router-link></li>
                              <li class="nav-item"><router-link to="users">Users Manager</router-link></li>
                            </div>
                        </ul>
                      </li>
                    </ul>
                  </li>
                </ul>
              </div>

              <div class="login-button" >
                <ul>
                  <li v-if="!username">
                    <router-link  to="login"><i class="lni lni-user"></i> Login</router-link>
                  </li>
                  <li v-else>
                    <router-link  to="profile"><i class="lni lni-user"></i> {{ username }}</router-link>
                  </li>
                </ul>
              </div>

              <div class="button header-button" v-if="ms_type==3">
                <router-link to="post" class="tags-li-title btn" >
                  Post a Product
                </router-link>
              </div>
              <div class="button header-button" v-if="ms_type==1">
                <router-link to="item" class="tags-li-title btn" >
                  Mange Product
                </router-link>
              </div>
            </nav> <!-- navbar -->
          </div>
        </div>
      </div> <!-- row -->
    </div> <!-- container -->
  </header>
</template>
<script>
import {Message} from 'element-ui'
import WOW from 'wowjs'

export default {
  mounted () {
    new WOW.WOW().init();
  },
  methods: {
    show(){
      this.$router.push('/show')
    },
    home(){
      this.$router.push('/home')
    },
  },
  data () {
    return {
      username: localStorage.getItem('ms_username'),
      user_id: localStorage.getItem('ms_id'),
      ms_type: localStorage.getItem('ms_type'),
      ms_image: localStorage.getItem('ms_image'),
      message: 2,
      collapse: false,
      new_local: '',
      user_password: '',
      user_password2:'',
      user_password_old: '',
      editVisible: false,
      editVisible2: false
    }
  }
}
</script>
<style scoped>

</style>
