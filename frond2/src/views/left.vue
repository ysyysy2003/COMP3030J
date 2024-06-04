<template>
  <div class="col-lg-3 col-md-12 col-12">
    <div class="dashboard-sidebar">
      <div class="user-image">
        <img :src="ms_image" alt="#">
        <h3>{{username}}</h3>
      </div>
      <div class="dashboard-menu">
        <ul>
          <div v-if="ms_type==1">
            <li><router-link  to="item"><i class="lni lni-bolt-alt"></i> Product Manager</router-link></li>
            <li><router-link to="Category"><i class="lni lni-bookmark"></i> Category Manager</router-link></li>
            <li><router-link to="users"><i class="lni lni-user"></i> Users Manager</router-link></li>
          </div>
          <div v-else>
          <li><router-link to="favourite"><i class="lni lni-user"></i> My Favourite</router-link></li>
            <li><router-link to="profile"><i class="lni lni-pencil-alt"></i> Edit Profile</router-link></li>
            <li><router-link  to="myitem"><i class="lni lni-bolt-alt"></i> My Product</router-link></li>
            <li><router-link to="post"><i class="lni lni-circle-plus"></i> Post An Ad</router-link></li>
            <li><router-link to="order"><i class="lni lni-printer"></i> Order</router-link></li>
          <li><router-link to="apply"><i class="lni lni-printer"></i> Apply</router-link></li>
          </div>
        </ul>
        <div class="button">
          <div class="btn" @click="handleCommand">Logout</div>
        </div>
      </div>
    </div>
    <!-- Start Dashboard Sidebar -->
  </div>
</template>

<script>
export default {
  name: 'left',
  data(){
    return{
      username: localStorage.getItem('ms_username'),
      user_id: localStorage.getItem('ms_id'),
      ms_type: localStorage.getItem('ms_type'),
      ms_image: localStorage.getItem('ms_image'),
    }
  },
  methods: {
    handleCommand (command) {
        localStorage.removeItem('ms_username')
        localStorage.removeItem('ms_type')
        localStorage.removeItem('ms_id')
        this.$router.push('/login')
    },
  }
}
</script>

<style scoped>

</style>
