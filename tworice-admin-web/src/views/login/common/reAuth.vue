<template>
    <el-col :span="24">
        <el-form @submit="submit">
          <el-form-item>
            <el-input v-model="loginName" placeholder="登录邮箱" disabled></el-input>
          </el-form-item>
          <el-col :span="24" class="reg-captcha-box">
            <el-col :span="13" class="reg-captcha-input-box">
              <el-input v-model="varCode" maxlength="6" placeholder="请输入动态口令" type="text"></el-input>
            </el-col>
            <el-col :span="11" class="send-captcha-box" @click.native="reCaptcha" :class="time>1?'content-submit-disabled':''">
              {{ send_captcha }}
            </el-col>
          </el-col>
          <el-col :class="varCode==''?'content-submit-disabled':''" :span="24"
                  class="content-submit"
                  @click.native="submit">登录
          </el-col>
        </el-form>
    </el-col>
</template>

<script>

export default {
      name: "ReAuth",
      props: {
        loginName:{
          type:String
        },
        reAuthKey:{
          type:String
        },
        loginSuccess:{
          type: Function
        }
      },
      data() {
            return {
              varCode:'',
              send_captcha:'重新获取口令',
              time:30,
              interval:''
            };
      },
      methods: {
        submit(){
          if(this.varCode){
            let formData = new FormData();
            formData.append('key',this.reAuthKey);
            formData.append('varCode',this.varCode);
            this.$axios({
              url:this.$url+'/admin/login/reAuth',
              method:'POST',
              data:formData
            }).then(response=>{
              if (response.data.status.code === 200) {
                // 登录成功
                this.loginSuccess(response)
              }
            })
          }
        },
        reCaptcha(){
          let formData = new FormData();
          formData.append('key',this.reAuthKey);
          this.$axios({
            url:this.$url+'/admin/login/sendReAuthCaptcha',
            method:'POST',
            data:formData
          }).then(response=>{
            if (response.data.status.code === 200) {
              // 重置倒计时
              this.time = 30;
              this.interval = setInterval(() => {
                this.updateTime();
              }, 1000);
            }
          })
        },
        /**倒计时发送验证码 */
        updateTime() {
          if (this.time === 1) {
            window.clearInterval(this.interval);
            this.send_captcha = '获取动态口令';
          } else {
            this.time = this.time - 1;
            this.send_captcha = this.time + '秒后重新获取'
          }
        },
      },
      mounted(){
        this.time = 30;
        this.interval = setInterval(() => {
          this.updateTime();
        }, 1000);
      }
};
</script>

<style scoped>
.send-captcha-box{
  position: relative;
}
</style>