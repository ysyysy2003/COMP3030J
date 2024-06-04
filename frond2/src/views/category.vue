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
                <h3 class="block-title">Category</h3>
                <div>

                  <div class="container">
                    <div class="handle-box">
                      <el-input v-model="query_username" placeholder="search" class="handle-input mr10" @keyup.enter.native="handleSearch"  style="width: 200px"/>
                      <el-button type="primary" style="margin-left: 10px" icon="el-icon-plus" @click="handleCreate">新增</el-button>
                    </div>
                    <el-table :data="tableData" border class="table" ref="multipleTable"  height="500px" header-cell-class-name="table-header">
                      <el-table-column prop="name" align="center" label="name"></el-table-column>
                      <el-table-column prop="info" align="center" label="info"></el-table-column>
                      <el-table-column  label="operation" width="160" align="center">
                        <template slot-scope="scope">
                          <el-button  type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">edit</el-button>
                          <el-button  type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">delete</el-button>
                        </template>
                      </el-table-column>
                    </el-table>
                    <div class="pagination" style="margin: 0 30%;">
                      <el-pagination background layout="total, prev, pager, next" :current-page="current_page"
                                     :page-size="page_size" :total="page_total" @current-change="handleCurrentChange"/>
                    </div>
                  </div>

                  <el-dialog title="Edit" :visible.sync="editVisible" width="30%">
                    <el-form label-width="100px">
                      <el-form-item label="name" required>
                        <el-input v-model="form.name" disabled></el-input>
                      </el-form-item>
                      <el-form-item label="info" >
                        <el-input v-model="form.info" maxlength="255" show-word-limit>></el-input>
                      </el-form-item>
                    </el-form>
                    <template #footer>
                <span class="dialog-footer">
                    <el-button @click="editVisible = false">取 消</el-button>
                    <el-button type="primary" @click="saveEdit">确 定</el-button>
                </span>
                    </template>
                  </el-dialog>

                  <el-dialog title="Add" :visible.sync="createVisible" width="30%">
                    <el-form label-width="100px">
                      <el-form label-width="100px">
                        <el-form-item label="name" required>
                          <el-input v-model="form.name" ></el-input>
                        </el-form-item>
                        <el-form-item label="info" >
                          <el-input v-model="form.info" maxlength="255" show-word-limit>></el-input>
                        </el-form-item>
                      </el-form>
                    </el-form>
                    <template #footer>
        <span class="dialog-footer">
            <el-button @click="createVisible = false">cancel</el-button>
            <el-button type="primary" @click="saveCreate">submit</el-button>
        </span>
                    </template>
                  </el-dialog>
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
  mounted () {
    new WOW.WOW().init();
    this.getData()
  },
  data () {
    return {
      username: localStorage.getItem('ms_username'),
      ms_id: localStorage.getItem('ms_id'),
      role: {
        1: '管理员',
        3: '用户'
      },
      role2:{
        1:'正常',
        3: '封禁'
      },
      artData: [],
      categoryData: [],
      form: {
        id: 1,
        name: "",
        info: '',
      },
      status_type:'',
      query_username:'',
      tableData:[],
      current_page:1,
      page_total:0,
      page_size:10,
      max_value:'',
      createVisible: false,
      acton_value: `http://127.0.0.1:8000/api/v1/category/get_img/`,
      acton_value2: `http://127.0.0.1:8000/api/v1/category/get_mp4/`,
      editVisible: false,
      idx: -1,
    }
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
    resetForm(formName) {
      this.refs[formName].resetFields();
    },
    getData () {
      this.axios.get(`/api/v1/category/`)
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
      this.axios.get(`/api/v1/category/?page=${val}&search=${this.query_username}`)
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
      this.axios.get(`/api/v1/category/?search=` + username)
        .then(response => {
          this.tableData = response.data.results;
          this.page_total = response.data.count
          this.page_size = response.data.pageSize
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    createData () {
      this.axios.post('/api/v1/category/',
        {
          name: this.form.name,
          info: this.form.info,
        }).then(response => {
        Message.success(`success`);
        this.getData()
      }).catch(err => {
        Message.error(err.response.data)
      });
    },
    updateData () {
      this.axios.patch(`/api/v1/category/${this.form.id}/`,{
        name: this.form.name,
        info: this.form.info,
      }).then(response => {
        Message.success(`success`);
        this.getData()
      }).catch(err => {
        Message.error(err.response.statusText)
        // }
      });
    },
    deleteData (index) {
      this.axios.delete(`/api/v1/category/${index}/`).then(response => {
        Message.success(`success`);
        this.handleSearch()
      }).catch(err => {
        Message.success(`failure`);
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
    handleEdit (index, row) {
      console.log(index, row)
      Object.keys(this.form).forEach((item) => {
        this.form[item] = row[item];
      });
      this.editVisible = true;
    },
    handleCreate() {
      this.form ={
        id: 1,
        name: "",
        info: ''
      }
      this.createVisible = true;
    },
    saveCreate() {
      this.createData();
      this.createVisible = false;
    },
    saveEdit() {
      this.updateData()
      this.editVisible = false;
    },
  }
}
</script>

<style scoped>

</style>
