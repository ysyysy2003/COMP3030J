<template>
  <div>
  <vHeader/>
  <section class="login section" v-show="register===false" >
    <div class="container">
      <div class="row">
        <div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-12">
          <div class="form-head">
            <h4 class="title">Login</h4>
            <form action="#!" method="post">
              <div class="form-group">
                <label>Username</label>
                <el-input v-model="param.username" placeholder="账号"> <template #prepend>
                  <el-button icon="el-icon-user"></el-button>
                </template></el-input>
              </div>
              <div class="form-group">
                <label>Password</label>
                <el-input type="password" placeholder="输入密码" v-model="param.password"  show-password>
                  <template #prepend>
                    <el-button icon="el-icon-lock"></el-button>
                  </template>
                </el-input>
              </div>
              <div class="button">
                <el-button type="primary" @click="submitForm()" class="btn">Login Now</el-button>
              </div>
              <p class="outer-link">Don't have an account? <span @click="register=true" style="color: #0d6efd">Register here</span>
              </p>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
    <section class="login registration section" v-show="register" >
      <div class="container">
        <div class="row">
          <div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-12">
            <div class="form-head">
              <h4 class="title">Registration</h4>
              <form action="#!" method="post">
                <div class="form-group">
                  <label>Name</label>
                  <el-input v-model="param.username" placeholder="账号"   maxlength="10"
                            show-word-limit>
                    <template #prepend>
                      <el-button icon="el-icon-user"></el-button>
                    </template>
                  </el-input>
                </div>
                <div class="form-group">
                  <label>Password</label>
                  <el-input type="password" placeholder="输入密码" v-model="param.password"  show-password   maxlength="20"
                            show-word-limit>
                    <template #prepend>
                      <el-button icon="el-icon-lock"></el-button>
                    </template>
                  </el-input>
                </div>
                <div class="form-group">
                  <label>Confirm Password</label>
                  <el-input type="password" placeholder="输入密码" v-model="param.password_2"  show-password   maxlength="20"
                            show-word-limit>
                    <template #prepend>
                      <el-button icon="el-icon-lock"></el-button>
                    </template>
                  </el-input>
                </div>
                <div class="button">
                  <el-button type="primary" @click="register_func()" class="btn">submit</el-button>
                </div>
                <p class="outer-link">Already have an account? <span @click="register=false"  style="color: #0d6efd">Login Now</span>
                </p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
    <v-footer/>
  </div>
</template>

<script>
import {Message, MessageBox} from 'element-ui'
import vHeader from './Header'
import vFooter from './footer'
export default {
  components: {
    vHeader,
    vFooter
  },
  methods: {
    submitForm  () {
      let that = this
      this.axios.post('/api/login/', {username: this.param.username, password: this.param.password})
        .then(function (response) {
          console.log(response)
          if (response.data.status===3){
            Message.error("账号已被禁用")
          }else{
            localStorage.setItem('ms_id', response.data.id)
            localStorage.setItem('ms_type', response.data.type)
            localStorage.setItem('ms_username', response.data.username)
            localStorage.setItem('company', response.data.company)
            localStorage.setItem('ms_image', response.data.image)
            localStorage.setItem('about', response.data.about)
            localStorage.setItem('is_superuser', response.data.is_superuser)
            that.$store.commit('set_token', 'JWT' + ' ' + response.data.token)
            if (that.$store.state.token) {
              Message.success('login success')
              if (response.data.type === 1){
                that.$router.push('/home')
              }else{
                that.$router.push('/home')
              }

            }
          }
        })
        .catch(err => {
          Message.error(err.response.data.non_field_errors[0])
        })
    },
    register_func () {
      let that = this
      if (this.param.password !== this.param.password_2) {
        Message.error('password not same')
      } else {
        this.axios.post('/api/v1/user/', {username: this.param.username, password: this.param.password, password_2: this.param.password_2, nick_name: '游客', type: 3})
          .then(function (response) {
              Message.success('success')
              that.register = false
          })
          .catch(err => {
            Message.error(err.response.data['username'])
          })
      }
    }
  },
  data () {
    this.$store.commit('clearTags')
    return {
      param: {
        username: '',
        password: '',
        password_2: ''
      },
      rules: {
        username: [
          {
            required: true,
            message: '请输入用户名',
            trigger: 'blur'
          }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ]
      },
      login: null,
      register: false
    }
  }
}
</script>

<style scoped>
.login-wrap {
    position: relative;
    width: 100%;
    height: 100%;
    /*background-image: url(../assets/img/login.jpg);*/
    background-size: 100%;
}
.ms-title {
    width: 100%;
    line-height: 50px;
    text-align: center;
    font-size: 20px;
    color: #000;
    border-bottom: 1px solid #ddd;
}
.ms-login {
    position: absolute;
    left: 50%;
    top: 50%;
    width: 350px;
    margin: -190px 0 0 -175px;
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.3);
    overflow: hidden;
}
.ms-content {
    padding: 30px 30px;
}
.login-btn {
    text-align: center;
}
.login-btn button {
    width: 100%;
    height: 36px;
    margin-bottom: 10px;
}
.login-tips {
    font-size: 12px;
    line-height: 30px;
    color: #fff;
}
</style>
