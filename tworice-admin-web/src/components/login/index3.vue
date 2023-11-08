<template>
      <div class="login tworice-login-bg">
          <el-col :span="24">
                  <el-col :span="24" class="login-top"></el-col>
                  <el-col :span="24" class="login-middle">
                        <el-col :md="14" class="min-height"></el-col>
                        <el-col :md="8" class="login-content">
                              <el-col :span="24" class="content-title">
                                    {{$setting.systemName}}
                              </el-col>
                              <el-col :span="24" class="content-form">
                                    <el-col :span="24">
                                          <el-input placeholder="请输入用户名" ref='userInput' type="text" suffix-icon="el-icon-user" v-model="username" @keyup.enter.native="login" @blur="isEmpty('u')"></el-input>
                                    </el-col>
                                    <el-col :span="24">
                                          <div class="form-rule" ref="userCheck"></div>
                                    </el-col>
                                    <el-col :span="24">
                                          <el-input placeholder="请输入密码" class="pw-input" type="password" suffix-icon="el-icon-lock" v-model="password" @keyup.enter.native="login" @blur="isEmpty('p')"></el-input>
                                    </el-col>
                                    <el-col :span="24">
                                          <div class="form-rule" ref="pwCheck"></div>
                                    </el-col>
                                    <el-col :span="24">
                                          <el-col :span="12">
                                                <el-input placeholder="请输入右侧结果" maxlength="6" ref='captchaInput' type="text" v-model="captcha" @keyup.enter.native="login" @blur="isEmpty('c')"></el-input>
                                          </el-col>
                                          <el-col :span="12" class="captcha-box">
                                                <img src="" alt="" height="40px" ref="captcha" @click="initCaptcha" title="点击换一张">
                                          </el-col>
                                    </el-col>
                                    <el-col :span="24">
                                          <div class="form-rule" ref="captchaCheck"></div>
                                    </el-col>
                              </el-col>
                              <el-col :span="24" class="content-submit" :class="username==''||password==''||captcha==''?'content-submit-disabled':''" @click.native="login">登录</el-col>
                              <el-col :span="24" class="reg-box"><el-link @click="toReg">注 册</el-link></el-col>
                        </el-col>
                        <el-col :md="2" class="min-height"></el-col>
                  </el-col>
                  <el-col :span="24" class="login-bottom"></el-col>
            </el-col>

            <!-- 弹出层 -->
            <el-dialog title="注册" :visible.sync="reg.dialogVisible" width="30%" :before-close="handleClose">
                  <el-form :model="reg.form" size="mini" :rules="reg.rules">
                        <el-form-item label="邮箱" :label-width="formLabelWidth" prop="loginName">
                              <el-input v-model="reg.form.loginName" @change="isChange = true" placeholder="登录邮箱"></el-input>
                        </el-form-item>
                        <el-form-item label="密码" :label-width="formLabelWidth" prop="passWord">
                              <el-input v-model="reg.form.passWord" @change="isChange = true" placeholder="登录密码"></el-input>
                        </el-form-item>
                        <el-form-item label="昵称" :label-width="formLabelWidth" prop="nickName">
                              <el-input v-model="reg.form.nickName" @change="isChange = true" placeholder="您的昵称"></el-input>
                        </el-form-item>
                        <el-col :span="24" class="reg-captcha-box">
                              <el-col :span="15">
                                    <el-input placeholder="请输入验证码" maxlength="6" type="text" v-model="reg.form.captcha"></el-input>
                              </el-col>
                              <el-col :span="9" class="send-captcha-box" @click.native="regCaptcha">
                                    {{reg.send_captcha}}
                              </el-col>
                        </el-col>
                  </el-form>
                  <span slot="footer" class="dialog-footer">
                        <el-button @click="reg.dialogVisible = false">取 消</el-button>
                        <el-button type="primary"  @click="submitReg">确 定</el-button>
                  </span>
            </el-dialog>
      </div>
</template>

<script>
export default {
      props: [],
      data() {
            return {
                  formLabelWidth: '60px',
                  username:'',
                  password:'',
                  captcha:'',
                  key:'',
                  reg:{
                        time:30,
                        send_captcha:'发送验证码',
                        dialogVisible:false,
                        submitButton:true,
                        interval:'',// 倒计时
                        form:{
                              loginName:'',
                              passWord:'',
                              nickName:'',
                              captcha:'',
                              key:'',
                        },
                        rules:{
                              loginName:[
                                    { required: true, message: '请输入登录邮箱', trigger: 'blur' },
                                    { min: 6,message: '长度应大于或等于6 个字符', trigger: 'blur' }
                              ],
                              passWord:[
                                    { required: true, message: '请输入登录密码', trigger: 'blur' },
                                    { min: 6,message: '长度应大于或等于6 个字符', trigger: 'blur' },
                                    { pattern:/^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/, message: '密码应包含大小写字母及数字'}
                              ],
                              nickName:[
                                    { required: true, message: '请输入昵称', trigger: 'blur' }
                              ],
                        },
                  }
            }
      },
      methods:{
            /**提交注册 */
            submitReg(){
                  if(this.reg.form.loginName==''||this.reg.form.passWord==''||this.reg.form.nickName==''||this.reg.form.captcha==''||this.reg.form.key==''){
                        this.$msg({
                              type:'error',
                              message:'必填项不能为空'
                        })
                        return;
                  }
                  // 提交注册
                  let formData=new FormData();
                  Object.keys(this.reg.form).forEach(item=>{
                        formData.append(item,this.reg.form[item]);
                  })
                  this.$axios({
                        url:this.$url+'/admin/login/reg',
                        data:formData,
                        method:'post'
                  }).then(res=>{
                        this.$msg({
                              type:'info',
                              message:res.data.status.message
                        })
                        this.reg.dialogVisible=false;
                  })
            },
            /**倒计时发送验证码 */
            updateTime(){
                  if(this.reg.time==1){
                        window.clearInterval(this.reg.interval);
                        this.reg.send_captcha='发送验证码';
                  }else{
                        this.reg.time=this.reg.time-1;
                        this.reg.send_captcha=this.reg.time+'秒后重新发送'
                  }
            },
            /**发送注册验证码 */
            regCaptcha(){
                  if(this.reg.send_captcha!='发送验证码'){
                        return;
                  }
                  if(this.reg.form.loginName==''){
                        this.$msg({
                              type:'error',
                              message:'邮箱不能为空'
                        })
                        return;
                  }else{
                        this.$root.loading=true;
                        this.$axios.get(this.$url+'/admin/login/regCaptcha?email='+this.reg.form.loginName).then(res=>{
                              this.$msg({
                                    type:'info',
                                    message:res.data.status.message
                              })
                              if(res.data.status.code==200){
                                    this.reg.form.key=res.data.data.key;
                                    // 初始化倒计时
                                    this.reg.time=30;
                                    this.reg.interval=setInterval(()=>{
                                          this.updateTime();
                                    },1000);
                                    this.$root.loading=false;
                              }
                              
                        })
                  }
            },
            /**关闭注册窗口 */
            handleClose(done) {
                  this.$confirm('确认退出注册？')
                  .then(() => {
                        done();
                  })
                  .catch(() => {});
            },
            /**注册 */
            toReg(){
                  this.reg.dialogVisible=true;
            },
            login(){
                  //判空
                  if(this.username==''||this.password==''||this.captcha==''){
                        return
                  }
                  
                  // 显示加载画面
                  this.$root.loading=true;

                  let format = new FormData();
                  format.append("username",this.username);
                  format.append("password",this.password);
                  format.append("verCode",this.captcha);
                  format.append("key",this.key);
                  this.$axios({
                        method:'post',
                        url:this.$url+'/admin/login/',
                        data:format
                  }).then(
                        response=>{
                              if(response.data.status.code==200){
                                    // 登录成功
                                    window.localStorage.setItem("token",response.data.data.token)
                                    window.localStorage.setItem("admin",JSON.stringify(response.data.data.admin))
                                    window.localStorage.setItem("resources",JSON.stringify(response.data.data.resources))
                                    window.localStorage.setItem("roles",JSON.stringify(response.data.data.roles))
                                    this.$router.push('/admin');
                                    this.$msg({
                                          type:'success',
                                          message:response.data.status.message
                                    })
                              }else if (parseInt(response.data.status.code) == 400) {
                                    // 登录失败
                                    this.$msg({
                                          type:'info',
                                          message:response.data.status.message
                                    })
                                    this.initCaptcha();
                                    // this.username='';
                                    this.password='';
                                    this.captcha='';
                              }
                              this.$root.loading=false;
                        }
                  ).catch(()=>{
                        this.initCaptcha();
                  })
            },
            // 表单验证是否为空
            isEmpty(con){
                  if(con=='u'){
                        if(this.username==''){
                              this.$refs.userCheck.innerHTML='用户名不能为空'
                        }else{
                              this.$refs.userCheck.innerHTML=''
                        }
                  }else if(con=='p'){
                        if(this.password==''){
                              this.$refs.pwCheck.innerHTML='密码不能为空'
                        }else{
                              this.$refs.pwCheck.innerHTML=''
                        }
                  }else if(con=='c'){
                        if(this.captcha==''){
                              this.$refs.captchaCheck.innerHTML='验证码不能为空'
                        }else{
                              this.$refs.captchaCheck.innerHTML=''
                        }
                  }
            },
            // 初始化验证码
            initCaptcha(){
                  let param="";
                  if(this.reg.form.key!=''){
                        param+='?code='+this.reg.form.key
                  }
                  this.$axios.get(this.$url+'/admin/login/captcha'+param).then(
                        res=>{
                              if(res.data.status.code==204){
                                    this.$msg({
                                          type:'warning',
                                          message:res.data.status.message
                                    })
                              }else{
                                    this.key=res.data.data.key;
                                    this.$refs.captcha.src=res.data.data.captcha;
                              }
                        }
                  ).catch(()=>{
                        // this.initCaptcha()
                  })
            }
      },
      mounted(){
            this.initCaptcha()
            // 控制页面初始化，用户名输入框自动获取焦点
            // this.$nextTick(function(){
            //       this.$refs.userInput.focus()
            // })
      }
};
</script>

<style lang="less">
/**背景 */
.login{
      height: 100vh;
      width: 100vw;
      // background: #304156;
}

/**页面上方 */
.login-top{
      height: 20vh;
}
/**页面中间部分 */
.login-middle{
      .login-content{
            color: #000;
            height: 380px;
            background-color: rgba(255, 255, 255,0.3);
            border-radius: 18px;
            padding: 0 3vw;

            .el-input__inner{
                  background-color: rgba(255, 255, 255,0);
                  color: #000;
            }
            .content-title{
                  height: 10vh;
                  text-align: center;
                  font-size: 1.5rem;
                  line-height: 10vh;
                  letter-spacing: 6px;
                  font-weight: 700;
            }
            .content-submit{
                  position: relative;
                  height: 40px;
                  color: white;
                  background:rgba(255, 255, 255,0);
                  border: 1px solid #fff;
                  line-height: 40px;
                  text-align: center;
                  // letter-spacing: 10px;
                  border-radius: 3px;
                  cursor: pointer;
                  color: #000;
            }
            .content-submit-disabled::after{
                  position: absolute;
                  top: 0;
                  left: 0;
                  width: 100%;
                  height: 100%;
                  background-color: rgba(255, 255, 255, .5);
                  border-radius: 3px;
                  content: '';
                  cursor: not-allowed;
            }
      }
}
.form-rule{
      height: 25px;
}
.captcha-box{
      display: flex;
      justify-content: center;

      img{
            cursor: pointer;
      }
}
/**注册 */
.reg-box{
      height: 30px;
      line-height: 30px;
      text-align: center;
      font-size: 12px;
      .el-link--inner{
            color: #000;
      }
      
}
.reg-captcha-box{
      height: 50px;
      margin-bottom: 30px;

      input{
            height: 40px;
      }

      .send-captcha-box{
            height: 40px;
            line-height: 40px;
            font-weight: 700;
            background-color: #409EFF;
            color: white;
            text-align: center;
            cursor: pointer;
      }
}
</style>