<!--右侧中间登录框，半透明，大背景图-->
<template>
    <div class="login tworice-login-bg">
        <el-col :span="24">
            <el-col :span="24" class="login-top"></el-col>
            <el-col :span="24" class="login-middle">
                <el-col :md="14" class="min-height">
                    <el-col :span="24" class="bg-left"></el-col>
                </el-col>
                <el-col :md="8" class="login-content">
                    <el-col :span="24" class="content-title">
                        {{ $setting.systemName }}
                    </el-col>
                    <LoginForm :showLabel="false"></LoginForm>
                </el-col>
                <el-col :md="2" class="min-height"></el-col>
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
input::placeholder {
    color: rgba(27, 27, 27, 0.7) !important;
}

/**背景 */
.login {
    height: 100vh;
    width: 100vw;
    // background: #304156;
    position: absolute;
    bottom: 0;
    left: 0;
    z-index: -2;
}

.bg-left {
    position: absolute;
    height: 100vh;
    bottom: 0;
    left: 0;
    background-image: url('~@/assets/img/bg1.png');
    background-size: 100% 100%;
    z-index: -1;
}

/**页面上方 */
.login-top {
    height: 20vh;
}

/**页面中间部分 */
.login-middle {
    .login-content {
        color: #000;
        height: 380px;
        background-color: rgba(255, 255, 255, 0.7);
        border-radius: 18px;
        padding: 0 3vw;
        
        .el-input__inner {
            background-color: rgba(255, 255, 255, 0);
            color: #000;
        }
        
        .content-title {
            height: 10vh;
            text-align: center;
            font-size: 1.5rem;
            line-height: 10vh;
            letter-spacing: 6px;
            font-weight: 700;
        }
        
        .content-submit {
            position: relative;
            height: 40px;
            color: white;
            background: rgba(255, 255, 255, 0);
            border: 1px solid #fff;
            line-height: 40px;
            text-align: center;
            // letter-spacing: 10px;
            border-radius: 3px;
            cursor: pointer;
            color: #000;
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

/**注册 */
.reg-box {
    height: 30px;
    line-height: 30px;
    text-align: center;
    font-size: 12px;
    
    .el-link--inner {
        color: #000;
    }
    
}

.reg-captcha-box {
    height: 50px;
    margin-bottom: 30px;
    
    .reg-captcha-input-box {
        overflow: hidden;
    }
    
    input {
        height: 40px;
    }
    
    .send-captcha-box {
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