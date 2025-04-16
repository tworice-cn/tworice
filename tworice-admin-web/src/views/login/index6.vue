<!--机智库样式，左侧登录框，右侧背景图-->
<template>
    <div class="login tworice-login-bg">
        <el-col :span="6" class="min-height"></el-col>
        <el-col :span="12" class="min-height">
            <el-col :span="24" class="login-top"></el-col>
            <el-col :span="24" class="login-content">
                <el-col :span="12" class="content-ico">
                    <i>
                        <img alt="" src="/favicon.ico" width="80px">
                        <br/>
                    </i>
                </el-col>
                <el-col :span="12" class="content-form">
                    <el-col :span="24" class="content-title">
                        {{ $setting.systemName }}
                    </el-col>
                    <LoginForm regText="没有账号？点击注册"></LoginForm>
                </el-col>
            </el-col>
        </el-col>
        <el-col :span="6" class="min-height"></el-col>
    </div>
</template>

<script>
import LoginForm from '@/components/business/loginForm/LoginForm.vue'

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
.login-content {
    height: 450px;
    background-color: rgba(255, 255, 255);
    border-radius: 3px;
    overflow: hidden;
    
    .content-title {
        height: 10vh;
        text-align: center;
        font-size: 1.3rem;
        line-height: 10vh;
        letter-spacing: 6px;
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
.content-ico {
    background-color: #000;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}
.content-form{
    padding: 0 1vw;
}

</style>