<template>
    <div class="demo-home">
        <div class="apply-main-container">
            <el-row align="middle" justify="start" type="flex">
            <el-col align="start">
                <h1>  奖学金名称  </h1>
            </el-col>
            </el-row>
            <el-row align="middle" justify="start" style="margin-top: 20px" type="flex">
            <el-col align="start">
                <el-select
                placeholder="请选择奖学金"
                style="width: 30vw"
                v-model="selected_scholarship"
                >
                <el-option
                    :key="item.id"
                    :label="item.title"
                    :value="item.id"
                    v-for="item in avail_scholarships"
                ></el-option>
                </el-select>
            </el-col>
            </el-row>
            <el-divider></el-divider>
            <el-row align="middle" justify="start" type="flex">
            <el-col align="start">
                {{ scholarship_info }}
            </el-col>
            </el-row>
            <div class="apply" v-if="selected_scholarship!=''">
                <el-divider></el-divider>
                <el-row align="middle" justify="start" type="flex">
                <el-col align="start">
                    <h1>  申请  </h1>
                </el-col>
                </el-row>
                <el-form style="width:100%">
                    <el-form-item label="请输入公钥地址">
                        <el-input style="width:80%" v-model="pub_addr" placeholder="必填"></el-input>
                    </el-form-item>
                    <el-form-item label="请提交证明文件">
                        <el-upload
                            class="upload-demo"
                            action
                            drag
                            :on-remove="handleRemove"
                            :auto-upload="false"
                            :before-remove="beforeRemove"
                            :limit="1"
                            :on-exceed="handleExceed"
                            :on-change="handleChange"
                            :file-list="fileList">
                            <el-button size="small" type="primary">点击上传</el-button>
                            <div slot="tip" class="el-upload__tip">只能上传txt文件，且不超过500kb</div>
                        </el-upload>
                    </el-form-item>
                    <el-button type="primary" @click="submitApply">
                        申请 
                        {{ avail_scholarships.filter((entry) => entry.id == selected_scholarship)[0].title }}
                    </el-button>
                </el-form>
            </div>
        </div>
            <div id="add">
                <el-button @click="add_num">ADD</el-button>
                <el-input-number
                    v-model="add_one"
                ></el-input-number>
                <el-input-number
                    v-model="add_two"
                ></el-input-number>
                <span> = {{ add_res }}</span>
            </div>
            
    </div>
</template>

<script>

import AppFooter from '../components/AppFooter.vue';
import AppHeader from '../components/AppHeader.vue';
import { contract } from '../main'
export default {
    components: { AppHeader, AppFooter },
    data(){
        return{
          cur: 0,
          add_one: 0,
          add_two: 0,
          add_res: 0,
          add: contract.methods.add,
          pub_addr: "",
          avail_scholarships: [],
          fileList: [],
          selected_scholarship: "",
          proof_strs: ""
        }
    },
    methods:{
        add_num(){
            this.add(this.add_one, this.add_two).call().then((res) => {this.add_res = res});
        },
        beforeRemove(file,fileList){
            return this.$confirm('确定取消上传文件'+file.name+'吗?', '提示', {
                   confirmButtonText: '确定',
                   cancelButtonText: '取消',
                   type: 'warning'
                  }); 
        },
        handleExceed(file,fileList){
            console.log(fileList.length);
            this.$message.warning("只能选择1个文件！");
        },
        handleError(err, file, fileList){
            console.log(err);
            this.$message.error("文件上传失败")
        },
        handleRemove(file,fileList){
            console.log(file);
            this.fileList = [];
        },
        handleChange(file,fileList){
            if(file){
                console.log('Upload file '+ file.name);

                this.fileList.push(file);

                let read = new FileReader();
                read.readAsBinaryString(file.raw);
                let self = this;
                read.onloadend = function(){
                    let result = read.result;
                    console.log(result.length);
                    //result = result.slice(0, result.length);
                    //console.log(result);
                    self.proof_strs = result.concat();
                }
                //fileList.push(file.name);
            }
        },
        submitApply(){
            //transfer pub_addr and proof to blockchain
            let strs = [], begin = 0, end = 0;
            console.log(this.proof_strs);
            while(true){
                begin = this.proof_strs.indexOf('"', end+1);
                if(begin == -1) break;
                end = this.proof_strs.indexOf('"', begin+1);
                strs.push(this.proof_strs.substr(begin+1, end-begin));
                //console.log(strs[strs.length - 1]);
            }
            //let proof1 = [strs[0], strs[1]];
            //let proof2 = [[strs[2], strs[3]], [strs[4], strs[5]]];
            //let proof3 = [strs[6], strs[7]];
            //let proof4 = [strs[8]];
            //console.log(proof1);
            /*
            this.auto_distribute(parseInt(selected_scholarship), 
            strs[0], strs[1], strs[2], strs[3], strs[4], strs[5], strs[6], strs[7], strs[8], pub_addr)
            .call().then(res => this.apply_res = res);
            */
        }
    },
    computed:{
        scholarship_info: function(){
            if(this.selected_scholarship == "") return "";
            return this.avail_scholarships.filter((entry) => entry.id == this.selected_scholarship)[0].description;
        }
    },
    created(){
        // default scholarship list
        
        this.avail_scholarships = [
            {
                title: "钟士模奖学金",
                price: 15000,
                description: "钟士模奖学金是为了纪念XXX，钟士模先生是电机工程和自动控制工程学家，中国自动控制学科和教育的开拓者之一，XXX",
                id: "0"
            },
            {
                title: "2020年研究生秋季奖学金",
                price: 3000,
                description: "2020年研究生秋季奖学金是XXX，总而言之还是非常厉害的XXX",
                id: "1"
            },
            {
                title: "2020年国奖答辩",
                price: 8000,
                description: "国家奖学金，顾名思义，是国家发的奖学金，作为大学生能获得国家奖学金是一项莫大的荣誉",
                id: "2"
            }
        ]
        // get available scholarship list from smart contract
        this.get_scholarship_list().call().then((ret) => {this.avail_scholarships = ret});
    }
}
</script>

<style scoped>
    .demo-home{
      font-size: 20px;
      align-content: flex-start;
      margin: 0 auto;
      width: 60%;
    }
    .grid-content2 {
    border-radius: 4px;
    color:black;
    float: none;
    font-size: 20px;
    cursor:pointer;
  }
  .tab-tilte{
            width: 90%;
    }
    .tab-tilte li{
        float: left;
        width: 25%;
        padding: 10px 0;
        text-align: center;
        background-color:#f4f4f4;
        cursor: pointer;
    }
     /* 点击对应的标题添加对应的背景颜色 */
    .tab-tilte .active{
        background-color: #09f;
         color: #fff;
    }
    /* .tab-content{
        float: left;
        width: 25%;
        line-height: 100px;
        text-align: center;
    } */
    .chooseup{
        margin-top: 10%;
    }
</style>
