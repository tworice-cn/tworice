<template>
    <div>
        <el-col :span="24" v-if="showLoginModel">
            <el-tabs v-model="login.loginModel">
                <el-tab-pane v-if="loginModel.includes('LOGIN_NAME')" name="LOGIN_NAME" label="账号登录"></el-tab-pane>
                <el-tab-pane v-if="loginModel.includes('EMAIL')" name="EMAIL" label="邮箱登录"></el-tab-pane>
                <el-tab-pane v-if="loginModel.includes('ID')" name="ID" label="唯一标识登录"></el-tab-pane>
                <el-tab-pane v-if="loginModel.includes('EMAIL_CAPTCHA')" name="EMAIL_CAPTCHA" label="邮箱验证码登录"></el-tab-pane>
                <el-tab-pane v-if="loginModel.includes('FACE')" name="FACE" label="人脸识别登录"></el-tab-pane>
            </el-tabs>
        </el-col>

        <el-col :span="24">
            <el-form @submit="loginSubmit" v-if="showState==='login' && ['LOGIN_NAME','EMAIL','ID'].includes(login.loginModel)">
                <el-col :span="24" class="content-form">
                    <el-col :span="24" class="content-form-prompt" v-if="showLabel">{{loginMode[login.loginModel]}}</el-col>
                    <el-col :span="24">
                        <el-input ref='userInput' v-model="login.loginName" :placeholder="'请输入'+loginMode[login.loginModel]"
                                  suffix-icon="el-icon-user"
                                  type="text" @blur="isEmpty('u')" @keyup.enter.native="loginSubmit"></el-input>
                    </el-col>
                    <el-col :span="24">
                        <div ref="userCheck" class="form-rule"></div>
                    </el-col>
                    <el-col :span="24" class="content-form-prompt" v-if="showLabel">
                        <el-col :span="12" class="item-left min-height">
                            密码
                        </el-col>
                        <el-col :span="12" class="item-right" v-if="showReg">
                            <el-link type="primary" @click="forgetPwd">忘记密码</el-link>
                        </el-col>
                    </el-col>
                    <el-col :span="24">
                        <el-input v-model="login.password" class="pw-input" placeholder="请输入密码"
                                  suffix-icon="el-icon-lock"
                                  type="password" @blur="isEmpty('p')" @keyup.enter.native="loginSubmit"></el-input>
                    </el-col>
                    <el-col :span="24">
                        <div ref="pwCheck" class="form-rule"></div>
                    </el-col>
                    <el-col :span="24">
                        <el-col :span="12">
                            <el-input ref='captchaInput' v-model="login.captcha" maxlength="6"
                                      placeholder="请输入右侧验证码"
                                      type="text" @blur="isEmpty('c')" @keyup.enter.native="loginSubmit"></el-input>
                        </el-col>
                        <el-col :span="12" class="captcha-box">
                            <img ref="captcha" alt="" height="40px" src="" title="点击换一张" @click="initCaptcha">
                        </el-col>
                    </el-col>
                    <el-col :span="24">
                        <div ref="captchaCheck" class="form-rule"></div>
                    </el-col>
                </el-col>
                
                <el-col :class="login.loginName===''||login.password===''||login.captcha===''?'content-submit-disabled':''"
                        :span="24"
                        class="content-submit"
                        @click.native="loginSubmit">{{loginText}}
                </el-col>
                <el-col :span="24" class="reg-box" v-if="showReg">
                    <el-link @click="toReg" class="to-reg-button">{{regText}}</el-link>
                </el-col>
            </el-form>
            <ReAuth v-if="showState==='reAuth'" :loginName="login.loginName" :reAuthKey="login.key"
                    :loginSuccess="checkLoginResult"></ReAuth>
            <EmailCaptcha v-if="login.loginModel === 'EMAIL_CAPTCHA'" :loginSuccess="checkLoginResult"></EmailCaptcha>
            <Face v-if="login.loginModel === 'Face'" :loginSuccess="checkLoginResult"></Face>
        </el-col>
        <!-- 弹出层 -->
        <el-dialog :before-close="$utils.handleClose" :visible.sync="reg.dialogVisible" title="注册" width="30%"
                   :append-to-body="true">
            <el-form ref="reg" :model="reg.form" :rules="reg.rules" size="mini">
                <el-form-item :label-width="formLabelWidth" label="邮箱" prop="email">
                    <el-input v-model="reg.form.email" placeholder="登录邮箱"></el-input>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="密码" prop="passWord">
                    <el-input v-model="reg.form.passWord" placeholder="登录密码"></el-input>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="昵称" prop="nickName">
                    <el-input v-model="reg.form.nickName" placeholder="您的昵称"></el-input>
                </el-form-item>
                <el-col :span="24" class="reg-captcha-box">
                    <el-col :span="13" class="reg-captcha-input-box">
                        <el-input v-model="reg.form.captcha" maxlength="6" placeholder="请输入验证码"
                                  type="text"></el-input>
                    </el-col>
                    <el-col :span="11" class="send-captcha-box" @click.native="regCaptcha">
                        {{ reg.send_captcha }}
                    </el-col>
                </el-col>
            </el-form>
            <span slot="footer" class="dialog-footer">
                        <el-button @click="reg.dialogVisible = false">取 消</el-button>
                        <el-button type="primary" @click="submitReg">确 定</el-button>
                  </span>
        </el-dialog>
    </div>
</template>

<script>
export {default} from './login.js';
</script>

<style scoped lang="less">
/**注册 */
.reg-box {
    height: 30px;
    line-height: 30px;
    text-align: center;
    font-size: 14px;
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

/*输入框提示语*/
.content-form-prompt {
    font-size: 14px;
    line-height: 30px;
}

.item-right {
    text-align: right;
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
</style>