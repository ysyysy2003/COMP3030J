<template>
<div>
  <vHeader/>
  <!-- Start Category -->
  <section class="category-page section">
    <div class="container">
      <div class="row">
        <div class="col-lg-3 col-md-4 col-12">
          <div class="category-sidebar">
            <!-- Start Single Widget -->
            <div class="single-widget search">
              <h3>Search Product</h3>
<!--              <form action="#">-->
<!--                <input type="text" placeholder="Search Here...">-->
<!--                <button ><i class="lni lni-search-alt"></i></button>-->
              <el-input v-model="value1" placeholder="Search Product" class="handle-input mr10" @keyup.enter.native="getData" clearable></el-input>
<!--              </form>-->
            </div>
            <!-- End Single Widget -->

            <!-- Start Single Widget -->
            <div class="single-widget">
              <h3 @click="queryData('')" class="category-item">All Categories</h3>
              <ul class="list">
                    <li v-for="(value, index) in categoryData" :key="index" class="category-item">
                      <div @click="queryData(value.id)">  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{value.name}}</div>
                    </li>
                  </ul>
            </div>

<!--            <div class="single-widget banner">-->
<!--              <h3>Advertisement</h3>-->
<!--              <a >-->
<!--                <img src="../assets/images/banner/banner.jpg" alt="#">-->
<!--              </a>-->
<!--            </div>-->
            <!-- End Single Widget -->
          </div>
        </div>

        <div class="col-lg-9 col-md-8 col-12">
          <div class="category-grid-list">
            <div class="row">
              <div class="col-12">
                <div class="tab-content" id="nav-tabContent">
                  <div class="tab-pane fade show active" id="nav-grid" role="tabpanel"
                       aria-labelledby="nav-grid-tab">
                    <div class="row">
                      <div class="col-lg-4 col-md-6 col-12" v-for="(value, index) in tableData" :key="index">
                        <div class="single-item-grid">
                          <div class="image"  @click="to(value.id)">
                            <img :src="value.image" alt="#">
                            <i class=" cross-badge lni lni-bolt"></i>
                            <span class="flat-badge sale">Sale</span>
                          </div>
                          <div class="content">
                            {{value.c}}
                            <h3 class="title">
                              <a href="item-details.html">{{value.name}}</a>
                            </h3>
                            <p class="location"><a @click="queryData('Hotel')"><i class="lni lni-map-marker">
                            </i>{{value.city}}</a></p>
                            <ul class="info">
                              <li class="price">{{value.nums}}</li>
                            </ul>
                          </div>
                        </div>
                      </div>

                    </div>

                    <div class="pagination" style="margin-top: 10px">
                        <el-pagination background layout="total, prev, pager, next" :current-page="current_page"
                                       :page-size="page_size" :total="page_total" @current-change="handleCurrentChange"/>
                    </div>

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <a href="#" class="scroll-top btn-hover">
    <i class="lni lni-chevron-up"></i>
  </a>

  <v-footer/>
</div>
</template>

<script>
import {Message, MessageBox} from 'element-ui'
import vHeader from './Header'
import vFooter from './footer'
import WOW from 'wowjs'
export default {
  components: {
    vHeader,
    vFooter
  },
  name: 'show',
  created () {

  },
  mounted () {
    new WOW.WOW().init();
    if(this.$route.query.value1 !== undefined) {
      this.value1 = this.$route.query.value1
    }
    if(this.$route.query.value2 !== undefined) {
      this.value2 = this.$route.query.value2
    }
    this.getC()
    this.getData()
  },
  computed: {
    handleFile () {
    },
  },
  methods: {
    to(index) {
        this.$router.push({ path: '/detail', query: { value: index }});
    },
    getC () {
      this.axios.get('/api/v1/category/')
        .then(response => {
          this.categoryData = response.data.results;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    getData () {
      this.axios.get(`/api/v1/product/?category__id=${this.value2}&search=${this.value1}&status=1`)
        .then(response => {
          this.tableData = response.data.results;
          this.page_total = response.data.count
          this.page_size = response.data.pageSize
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    handleCurrentChange (val) {
      this.axios.get(`/api/v1/product/?page=${val}&category__id=${this.value2}&search=${this.value1}&status=1`)
        .then(response => {
          this.tableData = response.data.results;
          this.page_total = response.data.count
          this.page_size = response.data.pageSize
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    queryData (username)  {
      this.value2 = username
      this.axios.get(`/api/v1/product/?category__id=${this.value2}&status=1&search=` + this.value1)
        .then(response => {
          this.tableData = response.data.results;
          this.page_total = response.data.count
          this.page_size = response.data.pageSize
        })
        .catch(function (error) {
          console.log(error);
        });
    },
  },
  data () {
    return {
      info: '',
      categoryData: [],
      icon:         ["lni lni-dinner", "lni lni-control-panel", "lni lni-bullhorn", "lni lni-home", "lni lni-bolt",
        "lni lni-tshirt", "lni lni-diamond-alt", "lni lni-dinner", "lni lni-control-panel", "lni lni-bullhorn", "lni lni-home", "lni lni-bolt", "lni lni-tshirt", "lni lni-diamond-alt",],
      info_id: '',
      value1: '',
      value2: '',
      show: true,
      url:'',
      id: {
        id: 1,
        name: "",
        type: 1,
        price:"",
        years_area: "",
        category: '',
        author_topic: '',
        image: '',
        video: '',
        info: ''
      },
      ms_type: localStorage.getItem('ms_type'),
      ms_id: localStorage.getItem('ms_id'),
      status_type:'',
      user_commend: '',
      user_remind: '',
      query_username:'',
      tableData:[],
      user_list:[],
      user_id: '',
      star: 0,
      order: 0,
      commend:[],
      remind:[],
      current_page:1,
      activeIndex: '1',
      index: '1',
      star_index:{'id':0, 'star':0},
      page_total:0,
      page_size:10,
      max_value:'',
      art_list: [],
      createVisible: false,
      editVisible: false
    }
  },

}
</script>

<style scoped>

.category-item > div {
  cursor: pointer;
  transition: color 0.3s ease;
  color: initial;
}

.category-item > div:hover {
  color: blue;
}
</style>
 
