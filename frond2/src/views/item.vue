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
                <h3 class="block-title">Product</h3>
                <div>
                  <div class="container">
                    <div class="handle-box">
                      <el-input v-model="query_username" style="width: 200px" placeholder="查找" class="handle-input mr10" @keyup.enter.native="handleSearch" />
                    </div>
                    <el-table :data="tableData" border class="table" ref="multipleTable"  height="500px" header-cell-class-name="table-header">
                      <el-table-column prop="name" align="center" label="name">
                        <template slot-scope="scope">
                          <router-link :to="{ name: 'detail', query: { value: scope.row.id } }">
                            {{ scope.row.name }}
                          </router-link>
                        </template>
                      </el-table-column>
                      <el-table-column prop="c" align="center" label="category"></el-table-column>
                      <el-table-column  prop="image" align="center" label="img">
                        <template slot-scope="scope">
                          <img :src="scope.row.image" style="width: 100px; height: 80px;" />
                        </template>
                      </el-table-column>
                      <el-table-column prop="status" align="center" label="status">
                        <template #default="scope">
                          <el-tag>{{ role2[scope.row.status] }}</el-tag>
                        </template>
                      </el-table-column>
                      <el-table-column prop="status_info" align="center" label="comments" width="200px"></el-table-column>
                      <el-table-column  label="operation" width="160" align="center">
                        <template slot-scope="scope">
                          <el-button  type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">edit</el-button>
                          <el-button  type="text" icon="el-icon-edit" @click="handleApply(scope.$index, scope.row)" v-if="scope.row.status===3">check</el-button>
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
                      <el-form-item label="category" >
                        <el-select class="user-chosen-select" v-model="form.category">
                          <el-option v-for="(value, index) in categoryData" :key="index" :label="value.name" :value="value.id"/>
                        </el-select>
                      </el-form-item>
                      <el-form-item label="amount" >
                        <el-input-number v-model="form.nums" :min="0" :max="10000000" label="nums"></el-input-number>
                      </el-form-item>
                      <el-form-item label="description" >
                        <el-input type="textarea" :rows="3" v-model="form.description" ></el-input>
                      </el-form-item>
                      <el-form-item label="image">
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
                      </el-form-item>
                      <el-form-item label="condition">
                        <select class="user-chosen-select" v-model="form.condition">
                          <option v-for="(value, index) in 10" :key="index">{{value}}</option>
                        </select>
                      </el-form-item>
                      <el-form-item label="address" >
                        <el-input v-model="form.address" maxlength="100" show-word-limit>></el-input>
                      </el-form-item>
                      <el-form-item label="state" >
                        <el-input v-model="form.state" maxlength="20" show-word-limit>></el-input>
                      </el-form-item>
                      <el-form-item label="city" >
                        <el-input v-model="form.city" maxlength="20" show-word-limit>></el-input>
                      </el-form-item>
                    </el-form>
                    <template #footer>
                <span class="dialog-footer">
                    <el-button @click="editVisible = false">取 消</el-button>
                    <el-button type="primary" @click="saveEdit">确 定</el-button>
                </span>
                    </template>
                  </el-dialog>

                  <el-dialog title="Check" :visible.sync="applyVisible" width="30%">
                      <el-form label-width="150px">
                        <el-form-item label="Status" >
                          <el-select v-model="form.status" clearable>
                            <el-option :key=1 label="yes" :value=1></el-option>
                            <el-option :key=2 label="no" :value=2></el-option>
                          </el-select>
                        </el-form-item>
                        <el-form-item label="Review comments" >
                          <el-input v-model="form.status_info"  maxlength="100" show-word-limit></el-input>
                        </el-form-item>
                      </el-form>
                    <template #footer>
                      <span class="dialog-footer">
                          <el-button @click="applyVisible = false">取 消</el-button>
                          <el-button type="primary" @click="saveApply">确 定</el-button>
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
    this.getC()
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
    getC () {
      this.axios.get('/api/v1/category/')
        .then(response => {
          this.categoryData = response.data.results;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    resetForm(formName) {
      this.refs[formName].resetFields();
    },
    getData () {
      this.axios.get(`/api/v1/product/`)
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
      this.axios.get(`/api/v1/product/?page=${val}&search=${this.query_username}`)
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
      this.axios.get(`/api/v1/product/?search=` + username)
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
      this.axios.post('/api/v1/product/',
        {
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
        this.getData()
      }).catch(err => {
        Message.error(err.response.data)
      });
    },
    updateData () {
      this.axios.patch(`/api/v1/product/${this.form.id}/`,{
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
        this.getData()
      }).catch(err => {
        Message.error(err.response.statusText)
        // }
      });
    },

    updateData2(){
      this.axios.patch(`/api/v1/product/${this.apply_id}/`,{
        status: this.form.status ,
        status_info: this.form.status_info,
      }).then(response => {
        Message.success(`check success`);
        this.getData()
      }).catch(err => {
        Message.error(err.response.statusText)
        // }
      });
    },
    deleteData (index) {
      this.axios.delete(`/api/v1/product/${index}/`).then(response => {
        Message.success(`success`);
        this.handleSearch()
      }).catch(err => {
        Message.success(`defail`);
        Message.error(err.data);
      });
    },
    handleAvatarSuccess1(res, file) {
      let formData = new FormData();
      formData.append("file", file.raw);
      this.axios.post('/api/v1/product/get_img/', formData, {headers: {'Content-Type': 'multipart/form-data'}})
        .then(response => {
          console.log(response)
          this.form.image = 'http://127.0.0.1:8000' + response.data.data;
        })
        .catch(function (error) {
          console.log(error);``
        });
    },
    beforeAvatarUpload1(file) {
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
    handleApply(index, row) {
      this.apply_id = row.id
      this.applyVisible = true;
    },
    handleCreate() {
      this.form ={
        id: 1,
        name: "",
        category: '',
        price: '',
        description: '',
        image: '',
        condition: '',
        tag: '',
        Mobile: '',
        address: '',
        city: '',
        state: '',
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
    saveApply() {
      this.updateData2()
      this.applyVisible = false;
    },
  }
}
</script>

<style scoped>

</style>
