<template>
      <div class="user-center">
            <el-page-header @back="goBack" content="返回" class="back-box"></el-page-header>
            <el-col :span="24" class="top-box">
                  <div class="avatar-box">
                        <el-avatar src="/favicon.ico"></el-avatar>
                        <el-col :span="24" class="user-name">{{adminInfo.nickName}}</el-col>
                        <el-col :span="24" class="user-info">
                              <div class="info-item el-icon-male"> {{adminInfo.adminSex==1?'男':adminInfo.adminSex==2?'女':'未知'}}</div>
                              <div class="info-item el-icon-suitcase"> {{adminInfo.roleName}}</div>
                              <div class="info-item el-icon-location"> {{adminInfo.homePlace?adminInfo.homePlace:'未知'}}</div>
                        </el-col>
                  </div>
            </el-col>
            <el-col :span="24" class="bottom-box">
                  <el-tabs v-model="activeName">
                        <el-tab-pane label="用户信息" name="userInfo"></el-tab-pane>
                        <el-tab-pane label="操作日志" name="userLog" v-if="isMe"></el-tab-pane>
                        <el-tab-pane label="系统公告" name="systemNotice" v-if="isMe"></el-tab-pane>
                        <el-tab-pane label="反馈建议" name="feedback" v-if="isMe"></el-tab-pane>
                  </el-tabs>
                  <el-col :span="24" class="info-box" v-if="activeName=='feedback'">
                        <feedback></feedback>
                  </el-col>
                  <el-col :span="24" class="info-box" v-if="activeName=='userInfo'">
                        <el-col :span="24" class="info-title">
                              <el-col :span="12" class="title-left">用户信息</el-col>
                              <el-col :span="12" class="title-right"><i class="el-icon-edit" @click="formVisible=true" v-if="isMe"> 编辑</i></el-col>
                        </el-col>
                        <el-col :span="24" class="myinfo-box">
                              <el-descriptions class="margin-top" :column="1" border>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-user"></i>
                                                用户名
                                          </template>
                                          {{adminInfo.nickName}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-coordinate"></i>
                                                角色
                                          </template>
                                          {{adminInfo.roleName}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-male"></i>
                                                性别
                                          </template>
                                          {{adminInfo.adminSex==1?'男':adminInfo.adminSex==2?'女':'未知'}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-mobile-phone"></i>
                                                手机号
                                          </template>
                                          {{adminInfo.adminPhone}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-message"></i>
                                                邮箱
                                          </template>
                                          {{adminInfo.adminEmail}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-location-outline"></i>
                                                居住地
                                          </template>
                                          {{adminInfo.homePlace}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-office-building"></i>
                                                联系地址
                                          </template>
                                          {{adminInfo.contactAddress}}
                                    </el-descriptions-item>
                                    <el-descriptions-item>
                                          <template slot="label">
                                                <i class="el-icon-tickets"></i>
                                                备注
                                          </template>
                                          {{adminInfo.adminNote}}
                                    </el-descriptions-item>
                              </el-descriptions>
                        </el-col>
                  </el-col>
                  
                  
                  <el-col :span="24" class="info-box" v-if="activeName=='userLog'">
                        <el-col :span="24" class="info-title">
                              操作记录
                        </el-col>
                        <el-col :span="24" class="info-item" v-for="(item,index) in logList" :key="index">
                              {{index+1}}. {{item.nickName}}于 {{$utils.formatDate(item.time)}} {{item.info}}
                        </el-col>
                        <el-col :span="24" class="none-more">- 没有更多了 -</el-col>
                  </el-col>

                  <el-col :span="24" class="info-box" v-if="activeName=='systemNotice'">
                        <el-col :span="24" class="info-title">
                              系统公告
                        </el-col>
                        <el-col :span="24" class="info-item" v-for="(item,index) in notice.list" :key="index">
                              <el-col :span="16" class="notice-left" @click.native="showNotice(item)">
                                    {{index+1}}. {{item.title}}
                              </el-col>
                              <el-col :span="8" class="notice-right">
                                    {{$utils.formatDate(item.createTime)}}
                              </el-col>
                        </el-col>
                        <el-col :span="24" class="none-more">- 没有更多了 -</el-col>
                  </el-col>
            </el-col>
            <el-dialog title="编辑我的信息" :visible.sync="formVisible" width="40%" :before-close="$utils.handleClose">
                  <el-form :model="adminInfo">
                        <el-form-item label='用户名' :label-width='$setting.formLabelWidth'>
                              <el-input placeholder='请输入用户名' v-model='adminInfo.nickName' size="small"></el-input>
                        </el-form-item>
                        <el-form-item label='性别' :label-width='$setting.formLabelWidth'>
                              <el-select v-model="adminInfo.adminSex" placeholder="请选择性别" size="small"  @change='isChange = true'>
                                    <el-option label="未知" :value="3"></el-option>
                                    <el-option label="男" :value="1"></el-option>
                                    <el-option label="女" :value="2"></el-option>
                              </el-select>
                        </el-form-item>
                        <el-form-item label='邮箱' :label-width='$setting.formLabelWidth'>
                              <el-input placeholder='请输入邮箱' v-model='adminInfo.adminEmail' @change='isChange = true' size="small"></el-input>
                        </el-form-item>
                        <el-form-item label='手机号' :label-width='$setting.formLabelWidth'>
                              <el-input placeholder='请输入手机号' v-model='adminInfo.adminPhone' @change='isChange = true' size="small"></el-input>
                        </el-form-item>
                        <el-form-item label='居住地' :label-width='$setting.formLabelWidth'>
                              <el-input placeholder='请输入居住地' v-model='adminInfo.homePlace' @change='isChange = true' size="small"></el-input>
                        </el-form-item>
                        <el-form-item label='联系地址' :label-width='$setting.formLabelWidth'>
                              <el-input placeholder='请输入联系地址' v-model='adminInfo.contactAddress' @change='isChange = true' size="small"></el-input>
                        </el-form-item>
                        <el-form-item label='备注' :label-width='$setting.formLabelWidth'>
                              <el-input type="textarea" :rows="2" placeholder='请输入备注' v-model='adminInfo.adminNote' @change='isChange = true' size="small"></el-input>
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button size="mini" @click="formVisible=false">取 消</el-button>
                        <el-button size="mini" type="primary" @click="submit">确 定</el-button>
                  </div>
            </el-dialog>
      </div>
</template>

<script>
import feedback from "@/components/feedback";
export default {
      name: "",
      props: [],
      components: { feedback },
      data() {
            return {
                  activeName:'userInfo',
                  userData:{},
                  logList:[],
                  formVisible:false,
                  adminInfo:{},
                  isChange:false,

                  notice:{
                        list:[],
                        page:1,
                        pageSize:10,
                        total:0,
                  },
                  isMe:false
            };
      }, 
      methods: {
            goBack(){
                  this.$router.go(-1);
            },
            showNotice(item){
                  // 跳转到showNotice路由并携带id参数
                  this.$router.push({path:'/notice/showNotice',query:{id:item.id}});
            },
            submit(){
                  this.$root.loading = true;
                  // 判断用户名是否被修改
                  if(this.adminInfo.nickName!=JSON.parse(window.localStorage.getItem('admin')).nickName){
                        this.updateNickName();
                  }
                  if(!this.isChange){
                        this.$root.loading=false;
                        this.formVisible = false;
                        return;
                  }
                  let formData = new FormData();
                  this.adminInfo.userId=this.userData.id;
                  Object.keys(this.adminInfo).map((key) => {
                        if (
                              this.adminInfo[key] != undefined &&
                              this.adminInfo[key] != ""
                        ) {
                              formData.append(key, this.adminInfo[key]);
                        }
                  });
                  this.$axios({
                        method: "POST",
                        url: this.$url + "/admin/adminInfo/add",
                        data: formData,
                  }).then(() => {
                        this.initAdminInfo();
                        this.formVisible = false;
                        this.$msg({
                          type:'success',
                          message:'更新成功'
                        })
                  });
            },
             updateNickName(){
                  if(this.adminInfo.nickName && this.adminInfo.nickName!=''){
                        let format=new FormData();
                        format.append("id",this.userData.id);
                        format.append("nickName",this.adminInfo.nickName);
                        this.$axios({
                              method:'post',
                              url:this.$url+"/admin/admin/add",
                              data:format
                        }).then(
                              ()=>{
                                  this.$notify.success({
                                    title: '提醒',
                                    message: '更新用户名成功，重新登录生效'
                                  });
                              }
                        )
                  }
            },
            init(){
                  let id = this.$route.params.id;
                  let admin=JSON.parse(window.localStorage.getItem("admin"))
                  if(admin.id==id){
                        this.isMe=true;
                  }
                  this.userData={
                        id:id
                  }
                  this.initLogList();
                  this.initAdminInfo();
                  this.initNotice();
            },
            initNotice(){
                  
                  this.$axios.get(this.$url+"admin/notice/list?page="+this.notice.page+"&pageSize="+this.notice.pageSize).then(
                        response=>{
                              this.notice.list=response.data.data.list;
                              this.notice.total=response.data.data.total;
                        }
                  )
            },
            initAdminInfo(){
                  this.$axios.get(
                              this.$url +"/admin/adminInfo/info/"+this.userData.id
                        )
                        .then((response) => {
                              let info=response.data.data.info;
                              if(info){
                                    this.adminInfo = info;
                                    this.adminInfo.roleName=info.roles[0].roleName;
                              }
                        });
            },
            initLogList(){
                  let roles=JSON.parse(window.localStorage.getItem('roles'));
                  let state=false;
                  roles.forEach(element => {
                        if(element.id<3){
                              state=true;
                              return;
                        }
                  });
                  if(state){
                        // 当前为管理员
                        this.$axios.get(this.$url+'/admin/log/adminList?pageSize=10&page=0&userId='+this.userData.id).then(
                              response=>{
                                    response.data.data.list.forEach(item=>{
                                          let logItem={
                                                nickName:item.admin,
                                                time:item.createTime,
                                                info:item.active
                                          }
                                          this.logList.push(logItem);
                                    })
                                    this.$axios.get(this.$url+'/admin/log/loginList?pageSize=10&page=0&loginName='+this.userData.loginName).then(
                                          loginLogresponse=>{
                                                loginLogresponse.data.data.list.forEach(item=>{
                                                      let logItem={
                                                            nickName:'账号'+this.userData.loginName,
                                                            time:item.createTime,
                                                            info:"登录"+(item.status==1?'成功':'失败')
                                                      }
                                                      this.logList.push(logItem);
                                                })
                                                this.logList.sort(function (a,b) {
                                                            return parseInt(b.time)-parseInt(a.time)
                                                      })
                                                this.logList=this.logList.slice(0,10);
                                          }
                                    )
                              }
                        )


                  }else{
                        // 当前为用户
                        this.$axios.get(this.$url+'/admin/log/loginList?pageSize=10&page=0&loginName='+this.userData.loginName).then(
                              response=>{
                                    let logList=response.data.data.list;
                                    logList.forEach(item=>{
                                          let logItem={
                                                nickName:'账号'+this.userData.loginName,
                                                time:item.createTime,
                                                info:"登录"+(item.status==1?'成功':'失败')
                                          }
                                          this.logList.push(logItem);
                                    })
                              }
                        )
                  }
            }
      },
      mounted(){
            this.init();
      }
};
</script>

<style lang="less" scoped>
.back-box{
      height: 50px;
      line-height: 50px;
}
.user-center{
      padding: 0 10px;
      cursor: default;
      .top-box{
            height: 200px;
            background-color: #cee9f7;
            border-radius: 4px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 16px;
            // background-image: url('~@/assets/img/');
            .avatar-box{
                  height: 150px;
                  width: 280px;
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  flex-direction: column;
                  font-size: 14px;

                  .el-avatar{
                        width: 64px;
                        height: 64px;
                        background-color: #ecf5ff;
                        margin-bottom: 12px;
                        padding: 15px;
                  }
                  .user-name{
                        text-align: center;
                        margin-bottom: 16px;
                        font-size: 16px;
                  }
                  .user-info{
                        text-align: center;
                        margin-bottom: 16px;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        .info-item{
                              margin-right: 18px;
                        }
                  }
            }
      }
      .bottom-box{
            padding-bottom: 20px;
            
            .info-box{
                  height: 500px;
                  background-color: #fff;
                  border-radius: 4px;
                  overflow: auto;
                  padding: 20px;

                  .info-title{
                        height: 60px;
                        line-height: 60px;
                        padding: 0 30px;
                        font-size: 16px;
                        .title-right{
                              text-align: right;
                              .el-icon-edit{
                                    cursor: pointer;
                              }
                        }
                  }
                  .info-item{
                        font-size: 14px;
                        padding: 10px 30px;
                        color: #1b1b1b;
                        
                        &:hover{
                              background-color: #cee9f780;
                        }
                        .notice-left{
                              cursor: pointer;
                        }
                        .notice-right{
                              text-align: right;
                              padding-right: 20px;
                        }
                  }
            }
            .myinfo-box{
                  padding: 0 30px;
                  font-size: 14px;
            }
      }
}

</style>