<template>
  <div>
    <v-header/>
    <section class="item-details section">
      <div class="container">
        <div class="top-area">
          <div class="row">
            <div class="col-lg-6 col-md-12 col-12">
              <div class="product-images">
                <main id="gallery">
                  <div class="main-img">
                    <img :src="tableData.image" alt="#">
                  </div>
                </main>
              </div>
            </div>
            <div class="col-lg-6 col-md-12 col-12">
              <div class="product-info">
                <h2 class="title">{{ tableData.name }}</h2>
                <p class="location"><i class="lni lni-map-marker"></i>{{ tableData.address }}</p>
                <h3 class="price">{{ tableData.nums }}</h3>
                <div class="list-info">
                  <h4>Informations</h4>
                  <ul>
                    <li><span>Condition:</span> {{ tableData.condition }}0% New</li>
                    <li><span>Tag:</span>{{ tableData.tag }}</li>
                    <li><span>Phone:</span>{{ tableData.phone }}</li>
                    <li>
                      <span>Collection：</span>
                      <i style="margin-top: 4px; color: #FFD700"  v-if="star===1" class="el-icon-star-on" @click="delFunc"></i>
                      <i v-else class="el-icon-star-off" style="margin-top: 4px; color: #FFD700"  @click="likeFunc"></i>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="item-details-blocks">
          <div class="row">
            <div class="col-lg-8 col-md-7 col-12" style="width: 100%">
              <!-- Start Single Block -->
              <div class="single-block description">
                <h3>Description</h3>
                <p style="white-space: normal;word-wrap: break-word; ">
                  {{ tableData.description }}
                </p>
              </div>
              <!-- End Single Block -->
              <div class="single-block description" style="padding-right: 50%" v-if="ms_id!=tableData.user">
                <h3>Exchange</h3>
                <form class="profile-setting-form" >
                  <div class="row">
                    <div class="col-lg-6 col-12">
                      <div class="form-group">
                        <label style="font-size: 16px; line-height: 20px">Product Name*</label><br/>
                        <el-select class="user-chosen-select" v-model="form.product2" placeholder="select" style="width: 300px">
                          <el-option v-for="(value, index) in productData" :key="index" :label="value.name" :value="value.id"/>
                        </el-select>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="form-group">
                        <label style="font-size: 16px; line-height: 20px">Amount*</label><br/>
                        <el-input-number v-model="form.nums" :min="0" :max="10000000" label="nums"></el-input-number>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="form-group message">
                        <label style="font-size: 16px; line-height: 20px">Note*</label><br/>
                        <el-input type="textarea" :rows="3" v-model="form.note" ></el-input>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="form-group message">
                        <label style="font-size: 16px; line-height: 20px">Phone*</label><br/>
                        <el-input v-model="form.phone" ></el-input>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="form-group message">
                        <label>Adress*</label><br/>
                        <el-input v-model="form.address" ></el-input>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="form-group button mb-0">
                        <el-button type="primary" class="btn" @click="updateData" style="margin-top: 10px">Submit</el-button>
                      </div>
                    </div>
                  </div>
                </form>

                <el-form-item label="category" >

                </el-form-item>

              </div>
              <!-- Start Single Block -->
              <div class="single-block comments">
                <h3>Comments</h3>
                <!-- Start Single Comment -->
                <div class="single-comment" v-for="(value, index) in tableData2" :key="index">
                  <img :src="value.user.image" alt="#">
                  <div class="content">
                    <h4>{{ value.user.username }}</h4>
                    <span>{{ value.create_time && value.create_time.length >= 18 ? value.create_time.substring(0, 18) : '' }}</span>
                    <p>
                      {{ value.info }}
                    </p>
                  </div>
                  <el-divider></el-divider>

                </div>
                <!-- End Single Comment -->
              </div>
              <!-- End Single Block -->
              <!-- Start Single Block -->
              <div class="single-block comment-form">
                <h3>Post a comment</h3>
                <form>
                  <div class="row">
                    <div class="col-12">
                        <el-input type="textarea" :rows="3" v-model="comment"  placeholder="Your Comments" />
                    </div>
                    <div class="col-12">
                      <div class="button">
                        <button class="btn" @click="commentFunc">Post Comment</button>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
              <!-- End Single Block -->
            </div>
            <div class="col-lg-4 col-md-5 col-12">
              <div class="item-details-sidebar">
                <!-- Start Single Block -->

                <!-- End Single Block -->
                <!-- Start Single Block -->
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
import vHeader from './Header'
import vFooter from './footer'
import {Message} from 'element-ui'
import WOW from 'wowjs'
export default {
  components: {
    vHeader,
    vFooter
  },
  name: 'detail',
  data() {
    return {
      form: {
        product2: '',
        nums: 1,
        node: '',
        phone: '',
        address: '',
      },
      productData: [],
      id: this.$route.query.value,
      username: localStorage.getItem('ms_username'),
      ms_id: localStorage.getItem('ms_id'),
      detail:[],
      tableData: {},
      comment: '',
      tableData2: [],
      star: 0,
      star_id: ''
    }
  },
  mounted () {
    new WOW.WOW().init();
    this.getData()
    this.getData3()
    this.getData2()
    this.getDetail()
  },
  methods: {
    getData () {
      this.axios.get(`/api/v1/product/${this.id}/`)
        .then(response => {
          this.tableData = response.data;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    getData2 () {
      this.axios.get(`/api/v1/operation/?product__id=${this.id}&type=2`)
        .then(response => {
          this.tableData2 = response.data.results;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    getData3 () {
      this.axios.get(`/api/v1/product/?user__id=${this.ms_id}`)
        .then(response => {
          this.productData = response.data.results;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    getDetail () {
      this.axios.get(`/api/v1/operation/?product__id=${this.id}&user__id=${this.ms_id}&type=1`)
        .then(response => {
          let result = response.data.results;
          if (result.length > 0 ){
            let lastValue = result[result.length - 1];
            this.star = parseInt(lastValue['info'])
            this.star_id = lastValue['id']
          }
        }).catch(function (error) {
          console.log(error);
        });
    },
    commentFunc(){
      this.axios.post(`/api/v1/operation/`,  {
        user: parseInt( this.ms_id),
        product: parseInt( this.id),
        type: 2,
        info: this.comment
      }).then(response => {
        Message.success('comment success')
        }).catch(function (error) {
          console.log(error);
        });
    },
    likeFunc(){
      this.axios.post(`/api/v1/operation/`,  {
        user: parseInt( this.ms_id),
        product: parseInt( this.id),
        type: 1,
        info: 1,
      }).then(response => {
        this.star = 1
        this.star_id = response.data.id
        Message.success('like success')
      }).catch(function (error) {
        console.log(error);
      });
    },
    delFunc(){
      this.axios.delete(`/api/v1/operation/${this.star_id}/`,  {
      }).then(response => {
        this.star = 0
        this.star_id = ''
        Message.success('success')
      }).catch(function (error) {
        console.log(error);
      });
    },
    updateData(){
      this.axios.post(`/api/v1/order/`,  {
        user1: parseInt( this.ms_id),
        product1: this.form.product2,

        user2: this.tableData.user,
        product2: parseInt(this.id),
        type: 3,
        note: this.form.note,
        nums2: this.form.nums,
        address: this.form.address,
        phone: this.form.phone,
      }).then(response => {
        Message.success('comment success')
      }).catch(function (error) {
        console.log(error);
      });
    }
  }
}
</script>


<style scoped>

</style>
