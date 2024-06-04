<template>
  <div>
    <v-header/>
    <section class="dashboard section">
      <div class="container">
        <div class="row">
        <vleft/>
          <div class="col-lg-9 col-md-8 col-12">
            <div class="main-content">
              <!-- Start Profile Settings Area -->
              <div class="dashboard-block mt-0 profile-settings-block">
                <h3 class="block-title">Profile Settings</h3>
                <div class="inner-block">
<!--                  <div class="image">-->
<!--                    <img :src="ms_image" alt="#">-->
<!--                  </div>-->
                  <form class="profile-setting-form" >
                    <div class="row">
                      <div class="col-lg-6 col-12">
                        <div class="form-group">
                          <label>Company*</label>
                          <el-input v-model="form.company" placeholder="Co., Ltd"  maxlength="20"
                                    show-word-limit>></el-input>
                        </div>
                      </div>
                      <div >
                        <div class="col-lg-6 col-12">
                          <div class="form-group">
                          <label>Profile Image*</label>
                          <el-upload
                            class="avatar-uploader"
                            :show-file-list="true"
                            :action="acton_value"
                            :on-success="handleAvatarSuccess1"
                            :limit="5"
                            :before-upload="beforeAvatarUpload1">
                            <img v-if="form.image" :src="form.image" class="avatar" alt="" style="background-size: contain" width="200px" height="150px"/>
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                          </el-upload>
                          </div>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="form-group message">
                          <label>About You*</label>
                          <el-input type="textarea" :rows="3" v-model="form.about" ></el-input>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="form-group button mb-0">
                          <el-button type="primary" class="btn" @click="updateData">Update Profile</el-button>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
              <!-- End Profile Settings Area -->
              <!-- Start Password Change Area -->
              <div class="dashboard-block password-change-block">
                <h3 class="block-title">Change Password</h3>
                <div class="inner-block">
                  <form class="default-form-style" >
                    <div class="row">
                      <div class="col-12">
                        <div class="form-group">
                          <label>New Password*</label>
                          <el-input type="password" placeholder="Enter new password" v-model="param.password"  show-password   maxlength="20"
                                    show-word-limit/>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="form-group">
                          <label>Retype Password*</label>
                          <el-input type="password" placeholder="Retype password" v-model="param.password_2"  show-password   maxlength="20"
                                    show-word-limit/>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="form-group button mb-0">
                          <el-button type="primary" class="btn" @click="updatePass">Update Password</el-button>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
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
import vleft from './left'
export default {
  components: {
    vHeader,
    vleft,
    vFooter
  },
  name: 'profile',

  methods: {
    handleAvatarSuccess1 (res, file) {
      let formData = new FormData();
      formData.append("file", file.raw);
      this.axios.post('/api/v1/product/get_img/', formData, {headers: {'Content-Type': 'multipart/form-data'}})
        .then(response => {
          console.log(response)
          this.form.image = 'http://127.0.0.1:8000' + response.data.data;
        })
        .catch(function (error) {
          console.log(error);
          ``
        });
    },
    beforeAvatarUpload1 (file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 5;
      if (!(isJPG)) {
        Message.error('Only JPG format is allowed!');
        return false
      }
      if (!isLt2M) {
        Message.error('The uploaded profile picture size must not exceed  5MB!');
        return false
      }
      return true
    },
    updatePass () {
      if (this.param.password === this.param.password_2) {
        this.axios.post(`/api/v1/user/password/`, {
          password: this.param.password
        }).then(response => {
          Message.success(`success`);
        }).catch(err => {
          Message.error(err.response.data)
          // }
        });
      } else {
        Message.error(`密码不一致, 请重试。`);
      }
    },
    updateData () {
      this.axios.patch(`/api/v1/user/${this.user_id}/`,{
        about: this.form.about,
        company: this.form.company,
        image: this.form.image,
      }).then(response => {
        Message.success(`success`);
        localStorage.setItem('company', this.form.company)
        localStorage.setItem('ms_image',this.form.image)
        localStorage.setItem('about', this.form.about)
      }).catch(err => {
        Message.error(err.response.statusText)
        // }
      });
    },
  },
  data(){
    return{
      acton_value: `http://127.0.0.1:8000/api/v1/product/get_img/`,
      username: localStorage.getItem('ms_username'),
      user_id: localStorage.getItem('ms_id'),
      ms_image: localStorage.getItem('ms_image'),
      company: localStorage.getItem('company'),
      about: localStorage.getItem('about'),
      form: {
        company: localStorage.getItem('company'),
        image: localStorage.getItem('ms_image'),
        about: localStorage.getItem('about'),
      },
      param: {
        username: '',
        password: '',
        password_2: ''
      },
    }
  }
}
</script>

<style scoped>
.el-upload--text {
  background-color: #fff;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  box-sizing: border-box;
  width: 360px;
  height: 180px;
  text-align: center;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.el-upload--text .el-icon-upload {
  font-size: 67px;
  color: #97a8be;
  margin: 40px 0 16px;
  line-height: 50px;
}

.el-upload--text {
  color: #97a8be;
  font-size: 14px;
  text-align: center;
}

.el-upload--text em {
  font-style: normal;
}

</style>
