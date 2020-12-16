<template>
    <div class='header'>
        <el-row>
            <el-col :span="18"><div class="grid-content1">链上奖学金系统</div></el-col>
            <el-col :span="3"><div class="grid-content2" id ="setting"  @click="dosomething()">
                <i class="el-icon-setting"></i>&nbsp;设置</div></el-col>
            <el-col :span="3"><div class="grid-content2" id = "quit" @click="safequit()">
                退出</div></el-col>
        </el-row>
        <hr/>
    </div>
</template>

<script>
export default {
    methods:{
        dosomething () {
            alert("shezhi");
        },
        safequit(){
            this.$router.push('/login');
        }
    }
}
</script>

<style scoped>
    .header{
        margin: 0 auto;
        width: 80%;
    }
    .el-row {
    margin-bottom: 20px;
  }
  .el-col {
    border-radius: 4px;
  }
  .grid-content1 {
    border-radius: 4px;
    color:black;
    float: left;
    margin-left: 5%;
    font-size: 24px;
    font-weight: bold;
  }
  .grid-content2 {
    border-radius: 4px;
    color:black;
    float: none;
    font-size: 20px;
    cursor:pointer;
  }
</style>