<template>
  <div>
    <v-header/>
    <section class="dashboard section">
      <div class="container">
        <div class="row">
          <vleft/>
          <div class="col-lg-9 col-md-12 col-12">
            <div class="main-content">
              <div class="dashboard-block mt-0">
                <h3 class="block-title">Favourite</h3>
                <div>
                  <div class="container">
                    <div class="handle-box">
<!--                      <el-input v-model="query_username" style="width: 200px" placeholder="查找" class="handle-input mr10" @keyup.enter.native="handleSearch" />-->
                    </div>
                    <el-table :data="tableData" border class="table" ref="multipleTable"  height="500px" header-cell-class-name="table-header">
                      <el-table-column prop="product.name" align="center" label="name">
                        <template slot-scope="scope">
                          <router-link :to="{ name: 'detail', query: { value: scope.row.product.id } }">
                            {{ scope.row.product.name }}
                          </router-link>
                        </template>
                      </el-table-column>
                      <el-table-column  prop="product.image" align="center" label="img">
                        <template slot-scope="scope">
                          <img :src="scope.row.product.image" style="width: 100px; height: 80px;" />
                        </template>
                      </el-table-column>
                      <el-table-column prop="product.nums" align="center" label="amount"></el-table-column>
                      <el-table-column prop="product.condition" align="center" label="condition"></el-table-column>
                      <el-table-column prop="product.city" align="center" label="city"></el-table-column>
                      <el-table-column  label="operation" width="160" align="center">
                        <template slot-scope="scope">
                          <el-button  type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">delete</el-button>
                        </template>
                      </el-table-column>
                    </el-table>
                    <div class="pagination" style="margin: 0 30%;">
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
    </section>
    <v-footer/>
  </div>
</template>

<script>
import vHeader from './Header'
import vFooter from './footer'
import vleft from './left'
import {Message, MessageBox} from 'element-ui'
import WOW from 'wowjs'
export default {
  components: {
    vHeader,
    vleft,
    vFooter
  },
  name: 'profile',

  data () {
    return {
      username: localStorage.getItem('ms_username'),
      ms_id: localStorage.getItem('ms_id'),
      ms_type: localStorage.getItem('ms_type'),
      role: {
        1: '管理员',
        3: '用户'
      },
      role2:{
        1:'同意',
        2: '拒绝',
        3: '审核中'
      },
      artData: [],
      categoryData: [],
      form: {
        id: 1,
        name: "",
        category: '',
        nums: '',
        description: '',
        image: '',
        condition: '',
        tag: '',
        Mobile: '',
        address: '',
        city: '',
        state: '',
        status_info:'',
        status:'',
      },
      apply_id: '',
      status_type:'',
      query_username:'',
      tableData:[],
      current_page:1,
      page_total:0,
      page_size:10,
      max_value:'',
      createVisible: false,
      applyVisible: false,
      acton_value: `http://127.0.0.1:8000/api/v1/product/get_img/`,
      acton_value2: `http://127.0.0.1:8000/api/v1/product/get_mp4/`,
      editVisible: false,
      idx: -1,
    }
  },
  mounted () {
    new WOW.WOW().init();
    this.getData()
  },
  methods: {
    submitForm(formName) {
      this.refs[formName].validate((valid) => {
        if (valid) {
          alert('submit!')
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    getData () {
      this.axios.get(`/api/v1/operation/?user__id=${this.ms_id}&type=1`)
        .then(response => {
          console.log(response)
          this.tableData = response.data.results;
          this.page_total = response.data.count
          this.page_size = response.data.pageSize
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    handleCurrentChange (val) {
      this.axios.get(`/api/v1/operation/?page=${val}&user__id=${this.ms_id}&type=1`)
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
      this.axios.get(`/api/v1/operation/?search=` + username)
        .then(response => {
          this.tableData = response.data.results;
          this.page_total = response.data.count
          this.page_size = response.data.pageSize
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    deleteData (index) {
      this.axios.delete(`/api/v1/operation/${index}/`).then(response => {
        Message.success(`success`);
        this.getData()
      }).catch(err => {
        Message.success(`defail`);
        Message.error(err.data);
      });
    },
    handleSearch () {
      this.queryData(this.query_username);
    },
    handleDelete (index, row) {
      MessageBox.confirm("Are you sure？", "warning", {
        type: "warning",
      }).then(() => {
        this.deleteData(row.id)
      })
        .catch((err) => {
          console.log(err)
        });
    },
  }
}
</script>

<style scoped>

</style>
