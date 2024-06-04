<template>
  <div>
    <v-header/>
    <section class="hero-area overlay">
      <div class="container">
        <div class="row">
          <div class="col-lg-10 offset-lg-1 col-md-12 col-12">
            <div class="hero-text text-center">
              <!-- Start Hero Text -->
              <div class="section-heading">
                <h2 class="wow fadeInUp" data-wow-delay=".10s">Welcome to Item exchange platform</h2>
                <p class="wow fadeInUp" data-wow-delay=".5s">At our marketplace, you are free to exchange a wide array
                  of goods. Remember, integrity is your most valuable asset.</p>
              </div>
              <!-- End Search Form -->
              <!-- Start Search Form -->
              <div class="search-form wow fadeInUp"   data-wow-delay=".7s">
                <div class="row">
                  <div class="col-lg-4 col-md-4 col-12 p-0">
                    <div class="search-input">
                      <label ><i class="lni lni-search-alt theme-color"></i></label>
<!--                      <input type="text" name="keyword" id="keyword" placeholder="Product keyword">-->
                      <el-input v-model="value1" placeholder="Search Product" class="handle-input mr10"/>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-3 col-12 p-0">
                    <div class="search-input">
                      <label><i class="lni lni-grid-alt theme-color"></i></label>
                      <select name="category" v-model="value2">
                        <option v-for="(value, index) in categoryData" :key="index"  :label="value.name" :value="value.id"></option>
                      </select>
                    </div>
                  </div>
                  <div class="col-lg-2 col-md-2 col-12 p-0">
                    <div class="search-btn button">
                      <button class="btn" @click="queryData"><i class="lni lni-search-alt"></i> Search</button>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End Search Form -->
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- End Hero Area -->

    <!-- Start Items Grid Area -->
    <section class="items-tab section">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title">
              <h2 class="wow fadeInUp" data-wow-delay=".4s">Trending Products</h2>
              <p class="wow fadeInUp" data-wow-delay=".6s">Easily uncover market trends with our featured categories:
                Latest Products for the newest arrivals, Popular Products for the top market picks, and Random Products for unexpected finds.</p>
            </div>
          </div>
        </div>
        <div class="row">
          <el-menu :default-active="select" class="el-menu-demo" mode="horizontal"  style="width: 435px; margin: auto; font-size: 24px; font-weight: 500" @select="handleSelect">
            <el-menu-item index="0">Latest Product</el-menu-item>
            <el-menu-item index="1">Popular Product</el-menu-item>
            <el-menu-item index="2">Random Product</el-menu-item>
          </el-menu>
          <div class="col-12">
            <div class="tab-content" id="nav-tabContent">
              <div class="tab-pane fade show active" id="nav-latest" role="tabpanel" aria-labelledby="nav-latest-tab">
                <div class="row">
                  <div class="col-lg-3 col-md-4 col-12" v-for="(value, index) in tableData[select]" :key="index">
                    <!-- Start Single Item -->
                    <div class="single-item-grid" @click="to(value.id)">
                      <div class="image">
                       <img :src="value.image" alt="#">
                        <i class=" cross-badge lni lni-bolt"></i>
                        <span class="flat-badge sale">Sale</span>
                      </div>
                      <div class="content">
                        <div class="tag">{{ value.category }}</div>
                        <h3 class="title">
                          <div>{{ value.name }}</div>
                        </h3>
                        <p class="location"><i class="lni lni-map-marker"></i>{{ value.city }}</p>
                        <ul class="info">
                          <li class="price">{{ value.nums }}</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                    <!-- End Single Item -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="call-action overlay section">
      <div class="container">
        <div class="row ">
          <div class="col-lg-8 offset-lg-2 col-12">
            <div class="inner">
              <div class="content">
                <h2 class="wow fadeInUp" data-wow-delay=".4s">Do you have something to exchange?</h2>
                <p class="wow fadeInUp" data-wow-delay=".6s">Post your product for free on Item exchange platform</p>
                <div class="button wow fadeInUp" data-wow-delay=".8s">
                  <router-link to="post" class="btn">Post an product now</router-link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="how-works section">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title">
              <h2 class="wow fadeInUp" data-wow-delay=".4s">How it Works</h2>
              <p class="wow fadeInUp" data-wow-delay=".6s">There are many variations of passages of Lorem
                Ipsum available, but the majority have suffered alteration in some form.</p>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-4 col-md-4 col-12">
            <!-- Start Single Work -->
            <div class="single-work wow fadeInUp" data-wow-delay=".2s">
              <span class="serial">01</span>
              <h3>Create Account</h3>
            </div>
            <!-- End Single Work -->
          </div>
          <div class="col-lg-4 col-md-4 col-12">
            <!-- Start Single Work -->
            <div class="single-work wow fadeInUp" data-wow-delay=".4s">
              <span class="serial">02</span>
              <h3>Post Your Product</h3>
            </div>
            <!-- End Single Work -->
          </div>
          <div class="col-lg-4 col-md-4 col-12">`
            <!-- Start Single Work -->
            <div class="single-work wow fadeInUp" data-wow-delay=".6s" style="margin-top: -23px">
              <span class="serial">03</span>
              <h3>Exchange Your Item</h3>
            </div>
            <!-- End Single Work -->
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
import  WOW  from 'wowjs'
export default {
  components: {
    vHeader,
    vFooter
  },
  data(){
    return{
      categoryData: [],
      tableData: [],
      value1: '',
      value2: '',
      value3: '',
      select: 0,
    }
  },
  mounted () {
    new WOW.WOW().init();
    this.getC()
    this.getI()
  },
  name: 'home',
  methods:{
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
    queryData ()  {
      this.$router.push({
        path: '/show',
        query: {
          value1: this.value1,
          value2: this.value2
        }
      });
    },
    handleSelect(key, keyPath) {
      this.select = key
    },
    getI ()  {
      this.axios.get(`/api/v1/product/get_intro/`)
        .then(response => {
          this.tableData = response.data.data;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
  }
}
</script>


<style scoped>
@import 'animate.css/animate.min.css';
</style>
