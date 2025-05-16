<template>
    <el-col :span="24">
        <el-form @submit="submit">
            <el-form-item>
                <el-input v-model="loginName" placeholder="登录邮箱"></el-input>
            </el-form-item>
            <el-col :span="24" class="reg-captcha-box">
                <el-col :span="13" class="reg-captcha-input-box">
                    <el-input v-model="varCode" maxlength="6" placeholder="请输入邮箱验证码" type="text"></el-input>
                </el-col>
                <el-col :span="11" class="send-captcha-box" @click.native="reCaptcha" :class="loginName=='' || time>1?'content-submit-disabled':''">
                    {{ send_captcha }}
                </el-col>
            </el-col>
            <el-col :class="varCode=='' || loginName==''?'content-submit-disabled':''" :span="24"
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
        loginSuccess:{
            type: Function
        }
    },
    data() {
        return {
            loginName:'', // 登录邮箱
            varCode:'',
            send_captcha:'获取验证码',
            time:0,
            interval:''
        };
    },
    methods: {
        submit(){
            if(this.varCode){
                let formData = new FormData();
                formData.append('loginName',this.loginName);
                formData.append('captcha',this.varCode);
                this.$axios({
                    url:this.$url+'/admin/login/emailLogin',
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
            this.$root.loading = true;
            let formData = new FormData();
            formData.append('email',this.loginName);
            this.$axios({
                url:this.$url+'/admin/login/emailCaptcha',
                method:'POST',
                data:formData
            }).then(response=>{
                if (response.data.status.code === 200) {
                    this.$message.success('发送成功');
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
                this.send_captcha = '获取验证码';
            } else {
                this.time = this.time - 1;
                this.send_captcha = this.time + '秒后重新获取'
            }
        },
    },
    mounted(){
        // this.time = 30;
        // this.interval = setInterval(() => {
        //     this.updateTime();
        // }, 1000);
    }
};
</script>

<style scoped>
.send-captcha-box {
    position: relative;
}
/* 发送验证码 */
.send-captcha-box {
    height: 40px;
    line-height: 40px;
    font-weight: 700;
    background-color: var(--themeColor);
    color: white;
    text-align: center;
    cursor: pointer;
}
/* 登录按钮 */
.content-submit {
    position: relative;
    height: 40px;
    color: white;
    background: var(--themeColor);
    line-height: 40px;
    text-align: center;
    border-radius: 3px;
    cursor: pointer;
}
.content-submit-disabled::after {
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

.reg-captcha-box {
    margin-bottom: 30px;
}
</style>