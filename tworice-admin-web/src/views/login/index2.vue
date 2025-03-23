<!--右侧登录栏占比1/5半透明，大背景图-->
<template>
    <div class="login tworice-login-bg">
        <el-col :span="24">
            
            <el-col :span="24" class="login-middle">
                <el-col :md="18" class="min-height login-left-content"></el-col>
                <el-col :md="6" class="login-content">
                    <el-col :span="24" class="login-top"></el-col>
                    <el-col :span="24" class="content-title">
                        <!-- <i class="iconfont icon-logo"></i> -->
                        系统登录
                    </el-col>
                    <LoginForm :show-reg="false"></LoginForm>
                </el-col>
            </el-col>
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
}

/**页面上方 */
.login-top {
    height: 20vh;
}

/**页面中间部分 */
.login-middle {
    .login-content {
        
        height: 100vh;
        background-color: #22a32674;
        border-radius: 3px;
        padding: 0 2vw;
        color: white;
        
        
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
            // letter-spacing: 10px;
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
</style>