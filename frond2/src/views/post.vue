<template>
  <div>
    <v-header/>
    <section class="dashboard section">
      <div class="container">
        <div class="row">
          <vleft/>
          <div class="col-lg-9 col-md-8 col-12">
            <div class="main-content">
              <!-- Start Post Ad Block Area -->
              <div class="dashboard-block mt-0">
                <h3 class="block-title">Post Ad</h3>
                <div class="inner-block">
                  <!-- Start Post Ad Tab -->
                  <div class="post-ad-tab">
                    <div class="tab-content" id="nav-tabContent">
                      <div class="tab-pane fade show active" id="nav-item-info" role="tabpanel"
                           aria-labelledby="nav-item-info-tab">
                        <!-- Start Post Ad Step One Content -->
                        <div class="step-one-content">
                          <form class="default-form-style">
                            <div class="row">
                              <div class="col-12">
                                <div class="form-group">
                                  <label>Product Name*</label>
                                  <el-input v-model="form.name" maxlength="20" show-word-limit>></el-input>
                                </div>
                              </div>
                              <div class="col-12">
                                <div class="form-group">
                                  <label>Category*</label>
                                  <div class="selector-head">
                                    <select class="user-chosen-select" v-model="form.category">
                                      <option v-for="(value, index) in categoryData" :key="index" :label="value.name" :value="value.id"/>
                                    </select>
                                  </div>
                                </div>
                              </div>
                              <div class="col-12">
                                <div class="form-group">
                                  <label>amount*</label>
                                  <el-input-number v-model="form.nums" :min="0" :max="10000000" label="nums"></el-input-number>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>description*</label>
                                  <el-input type="textarea" :rows="3" v-model="form.description" ></el-input>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>Product Img*</label>
                                  <el-upload
                                    class="avatar-uploader"
                                    :show-file-list="false"
                                    :action="acton_value"
                                    :on-success="handleAvatarSuccess1"
                                    :limit="1"
                                    :before-upload="beforeAvatarUpload1">
                                    <img v-if="form.image" :src="form.image" class="avatar" alt="" style="background-size: contain" width="360px" height="180px"/>
                                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                  </el-upload>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>Condition*</label>
                                  <div class="selector-head">
                                    <select class="user-chosen-select" v-model="form.condition">
                                      <option v-for="(value, index) in 10" :key="index">{{value}}</option>
                                    </select>
                                  </div>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>Tag*</label>
                                  <el-input v-model="form.tag" maxlength="50" show-word-limit>></el-input>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>Address*</label>
                                  <el-input v-model="form.address" maxlength="100" show-word-limit>></el-input>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>State*</label>
                                  <el-input v-model="form.state" maxlength="20" show-word-limit>></el-input>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group">
                                  <label>City*</label>
                                  <el-input v-model="form.city" maxlength="20" show-word-limit>></el-input>
                                </div>
                              </div>

                              <div class="col-12">
                                <div class="form-group button mb-0">
                                  <el-button type="primary" @click="createData">确 定</el-button>
                                </div>
                              </div>
                            </div>
                          </form>
                        </div>
                        <!-- Start Post Ad Step One Content -->
                      </div>

                    </div>
                  </div>
                  <!-- End Post Ad Tab -->
                </div>
              </div>
              <!-- End Post Ad Block Area -->
            </div>
          </div>
        </div>
      </div>
    </section>
    <v-footer/>
  </div>

</template>

<script>
import vHeader from './Header'
import vFooter from './footer'
import vleft from './left'
import {Message} from 'element-ui'
import WOW from 'wowjs'
export default {
  components: {
    vHeader,
    vleft,
    vFooter
  },
  name: 'post',
  data(){
    return {
      categoryData: [],
      acton_value: `http://127.0.0.1:8000/api/v1/product/get_img/`,
      username: localStorage.getItem('ms_username'),
      ms_id: localStorage.getItem('ms_id'),
      form: {
        name: "",
        category: '',
        nums: '',
        description: '',
        image: '',
        condition: '',
        tag: '',
        Mobile: '',
        address: '',
        City: '',
        State: '',
      },
    }
  },
  mounted () {
    new WOW.WOW().init();
    this.getC()
  },
  methods: {
    getC () {
      this.axios.get('/api/v1/category/')
        .then(response => {
          this.categoryData = response.data.results;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    createData () {
      this.axios.post('/api/v1/product/',
        {
          user: this.ms_id,
          name: this.form.name,
          category: this.form.category,
          nums: this.form.nums,
          description: this.form.description,
          image: this.form.image,
          condition: this.form.condition,
          tag: this.form.tag,
          Mobile: this.form.Mobile,
          address: this.form.address,
          city: this.form.city,
          state: this.form.state,
        }).then(response => {
        Message.success(`success`);
        // this.getData()
      }).catch(err => {
        Message.error(err.response.data)
      });
    },
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
  }
}
</script>

<style scoped>
.mapouter {
  position: relative;
  text-align: right;
  height: 300px;
  width: 100%;
}
.gmap_canvas {
  overflow: hidden;
  background: none !important;
  height: 300px;
  width: 100%;
}
</style>
