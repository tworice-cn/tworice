<!--机智库样式，左侧登录框，右侧背景图-->
<template>
    <div class="login tworice-login-bg">
        <el-col :span="24">
            <el-col :span="24" class="login-middle">
                <el-col :md="8" :xs="0" class="min-height login-left">
                    <el-col :span="24" class="login-top"></el-col>
                    <el-col :span="24" class="login-content">
                        <el-col :span="24" class="content-title">
                            <i>
                                <img alt="" src="/favicon.ico" width="60px">
                                <br/>
                            </i>
                        </el-col>
                        <el-col :span="24" class="content-title">
                            欢迎使用{{ $setting.systemName }}
                        </el-col>
                        <LoginForm regText="没有账号？点击注册"></LoginForm>
                    </el-col>
                </el-col>
                <el-col :md="16" :xs="24" class="login-right"></el-col>
            </el-col>
            <el-col :span="24" class="login-bottom"></el-col>
        </el-col>
    </div>
</template>

<script>
import LoginForm from '@/components/commons/loginForm/LoginForm.vue'

export default {
    components: {
        LoginForm
    },
}
</script>

<style lang="less">
/**背景 */
.login {
    height: 100vh;
    width: 100vw;
    // background: #304156;
}

.login-left {
    height: 100vh;
    background-color: #fff;
}

.login-right {
    height: 100vh;
    color: var(--themeColor);
    // line-height: 100vh;
    text-align: center;
    font-size: 50px;
    
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    
    background-image: url('~@/assets/img/loginBg.jpg');
    background-size: cover;
    background-position: center;
}

/**页面上方 */
.login-top {
    height: 20vh;
}

/**页面中间部分 */
.login-middle {
    .login-content {
        height: 380px;
        background-color: rgba(255, 255, 255);
        border-radius: 3px;
        padding: 0 3vw;
        
        .content-title {
            height: 10vh;
            text-align: center;
            font-size: 1.5rem;
            line-height: 10vh;
            letter-spacing: 6px;
        }
    }
}

.form-rule {
    height: 25px;
}

.captcha-box {
    display: flex;
    justify-content: center;
    
    img {
        cursor: pointer;
    }
}


</style>