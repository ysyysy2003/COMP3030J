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
                <h3 class="block-title">User Manage</h3>
                <div>
                  <div class="container">
                    <div class="handle-box">
                      <el-input v-model="query_username" placeholder="search" style="width: 200px" class="handle-input mr10" @keyup.enter.native="handleSearch" />
                      <el-button type="primary" style="margin-left: 10px" icon="el-icon-plus" @click="handleCreate">Add</el-button>
                    </div>
                    <el-table :data="tableData" border class="table" ref="multipleTable"  height="500px"  header-cell-class-name="table-header">
                      <el-table-column prop="username" align="center" label="account"></el-table-column>
                      <el-table-column prop="type" align="center"   label="status">
                        <template #default="scope">
                          <el-tag>{{ role2[scope.row.status] }}</el-tag>
                        </template>
                      </el-table-column>
                      <el-table-column prop="type" align="center"   label="type">
                        <template #default="scope">
                          <el-tag>{{ role[scope.row.type] }}</el-tag>
                        </template>
                      </el-table-column>
                      <el-table-column  label="operate" width="240" align="center">
                        <template slot-scope="scope">
                          <el-button  type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">Edit</el-button>
                          <el-button  type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">Delete</el-button>
                        </template>
                      </el-table-column>
                    </el-table>
                    <div class="pagination" style="margin: 0 30%;">
                      <el-pagination background layout="total, prev, pager, next" :current-page="current_page"
                                     :page-size="page_size" :total="page_total" @current-change="handleCurrentChange"/>
                    </div>
                  </div>
                  <!-- 编辑弹出框 -->
                  <el-dialog title="Edit" :visible.sync="editVisible" width="30%">
                    <el-form label-width="100px">
                      <el-form-item label="account" required>
                        <el-input v-model="form.username"  :disabled="true"></el-input>
                      </el-form-item>
                      <el-form-item label="status" required>
                        <el-select v-model="form.status" clearable>
                          <el-option :key=1 label="yes" :value=1></el-option>
                          <el-option :key=3 label="no" :value=3></el-option>
                        </el-select>
                      </el-form-item>
                      <el-form-item label="type" required>
                        <el-select v-model="form.type" clearable>
                          <el-option :key=1 label="admin" :value=1></el-option>
                          <el-option :key=3 label="user" :value=3></el-option>
                        </el-select>
                      </el-form-item>
                    </el-form>
                    <template #footer>
                <span class="dialog-footer">
                    <el-button @click="editVisible = false">cancel</el-button>
                    <el-button type="primary" @click="saveEdit">submit</el-button>
                </span>
                    </template>
                  </el-dialog>
                  <!-- 新增弹出框 -->
                  <el-dialog title="Add" :visible.sync="createVisible" width="30%">
                    <el-form label-width="100px">
                      <el-form-item label="account" required>
                        <el-input v-model="form.username"></el-input>
                      </el-form-item>
                      <el-form-item label="status" required>
                        <el-select v-model="form.status" clearable>
                          <el-option :key=1 label="yes" :value=1></el-option>
                          <el-option :key=3 label="no" :value=3></el-option>
                        </el-select>
                      </el-form-item>
                      <el-form-item label="type" required>
                        <el-select v-model="form.type" clearable>
                          <el-option :key=1 label="admin" :value=1></el-option>
                          <el-option :key=3 label="user" :value=3></el-option>
                        </el-select>
                      </el-form-item>
                      <el-form-item label="password" required>
                        <el-input v-model="form.password"  show-password   maxlength="20"
                                  show-word-limit></el-input>
                      </el-form-item>
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
import vleft from './left'
import vFooter from './footer'
import {Message, MessageBox} from 'element-ui'
import WOW from 'wowjs'
export default {
  components: {
    vHeader,
    vleft,
    vFooter
  },
  name: 'users',
  mounted () {
    new WOW.WOW().init();
    this.getData()
  },
  data () {
    return {
      role: {
        1: 'admin',
        3: 'user'
      },
      role2:{
        1:'yes',
        3: 'no'
      },
      status_type:'',
      query_username:'',
      tableData:[],
      current_page:1,
      page_total:0,
      page_size:10,
      max_value:'',
      createVisible: false,
      editVisible: false,

      form: {
        id: "",
        username: "",
        type: '',
        status: 1,
        password: ''
      },
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
      this.axios.get('/api/v1/user/')
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
      this.axios.get(`/api/v1/user/?page=${val}&search=${this.query_username}`)
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
      this.axios.get('/api/v1/user/?search=' + username)
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
      this.axios.post('/api/v1/user/',
        {username: this.form.username,
          type: this.form.type,
          password:this.form.password,
          status: this.form.status,
        }).then(response => {
        Message.success(`success`);
        this.getData()
      }).catch(err => {
        Message.error(err.response.data['username'][0])
      });
    },
    updateData () {
      this.axios.patch(`/api/v1/user/${this.form.id}/`,{
        type: this.form.type,
        status: this.form.status,
      }).then(response => {
        Message.success(`success`);
        this.getData()
      }).catch(err => {
        Message.error(err.response.statusText)
        // }
      });
    },
    deleteData (index) {
      this.axios.delete(`/api/v1/user/${index}/`).then(response => {
        Message.success(`success`);
        this.getData()
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
      // idx = index;
      console.log(index, row)
      Object.keys(this.form).forEach((item) => {
        this.form[item] = row[item];
      });
      this.form.password = ''
      this.editVisible = true;
    },
    handleEdit2(index, row){
      this.axios.patch(`/api/v1/user/${row.id}/`,{status: row.status===1?2:1
      }).then(response => {
        Message.success(`success`);
        this.getData()
      }).catch(err => {
        Message.error(err.response.statusText)
        // }
      });
    },
    handleCreate() {
      this.form ={
        id: "",
        username: "",
        type: '',
        password: "",
        status: "",
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
