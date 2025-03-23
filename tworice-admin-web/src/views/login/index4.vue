<!--左右分栏样式-->
<template>
    <div class="login tworice-login-bg">
        <el-col :span="24">
            <el-col :span="24" class="login-middle">
                <el-col :md="12" :xs="0" class="min-height login-left">
                    <i>
                        <img alt="" src="/favicon.ico" width="100px">
                        <br/>
                    </i>
                    {{ $setting.systemName }}
                </el-col>
                <el-col :md="12" :xs="24" class="login-right">
                    <el-col :span="24" class="login-top"></el-col>
                    <el-col :span="24" class="login-content">
                        <el-col :span="24" class="content-title">
                            登 录
                        </el-col>
                        <LoginForm></LoginForm>
                    </el-col>
                </el-col>
            </el-col>
            <el-col :span="24" class="login-bottom"></el-col>
        </el-col>
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
    // background: #304156;
}

.login-left {
    height: 100vh;
    background-color: #000;
    color: #3683e8;
    // line-height: 100vh;
    text-align: center;
    font-size: 50px;
    
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
}

.login-right {
    height: 100vh;
    background-color: #fff;
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
        padding: 0 10vw;
        
        .form-item {
            line-height: 40px;
            
            .item-left {
                text-align: left;
            }
            
            .item-right {
                text-align: right;
            }
        }
        
        .content-title {
            height: 10vh;
            text-align: center;
            font-size: 1.5rem;
            line-height: 10vh;
            letter-spacing: 6px;
        }
        
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
}

.reg-captcha-box {
    height: 50px;
    margin-bottom: 30px;
    
    .reg-captcha-input-box {
        overflow: hidden;
    }
    
    el-input {
        height: 40px;
    }
    
    .send-captcha-box {
        height: 40px;
        line-height: 40px;
        font-weight: 700;
        background-color: var(--themeColor);
        color: white;
        text-align: center;
        cursor: pointer;
    }
}
</style>