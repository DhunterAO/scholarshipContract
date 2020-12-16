<template>
    <div class="user-home">
        <el-container>
            <el-header><app-header/></el-header>
            <el-container class="contentContainer">
                <el-main>
                    <!--search/-->
                    <router-view/>
                </el-main>
            </el-container>
            <app-footer/>
        </el-container>
    </div>
</template>

<script>
import AppFooter from '../components/AppFooter.vue';
import AppHeader from '../components/AppHeader.vue';
//import AppSider from '../components/AppSider.vue';
export default {
  components: { AppHeader, AppFooter},
    data(){
        return{
        }
    },
    methods:{
        
    },
    created(){
        this.$router.push('./apply');
    }
    
}
</script>

<style scoped>
  .user-home{
      display: flex;
      flex-direction: column;
      height: 100%;
      font-size: 20px;
      margin-left: 10%;
      min-height: 930px;
  }
  
  .contentContainer {
    width:100%;
    height: 100%;
  }

  .contentInner{
      margin-left: 15%;
  }
</style>
