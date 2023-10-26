<template>
  <div class="login tworice-login-bg">
    <el-col :span="24">
      <el-col :span="24" class="login-middle">
        <el-col :md="12" class="min-height login-left">
          <i>
            <img alt="" src="/favicon.ico" width="100px">
            <br/>
          </i>
          {{ $setting.systemName }}
        </el-col>
        <el-col :md="12" class="login-right">
          <el-col :span="24" class="login-top"></el-col>
          <el-col :span="24" class="login-content">
            <el-col :span="24" class="content-title">
              登 录
            </el-col>
            <el-col :span="24" class="content-form">
              <el-col :span="24">
                <el-input ref='userInput' v-model="login.username" placeholder="请输入用户名" suffix-icon="el-icon-user"
                          type="text" @blur="isEmpty('u')" @keyup.enter.native="loginSubmit"></el-input>
              </el-col>
              <el-col :span="24">
                <div ref="userCheck" class="form-rule"></div>
              </el-col>
              <el-col :span="24">
                <el-input v-model="login.password" class="pw-input" placeholder="请输入密码" suffix-icon="el-icon-lock"
                          type="password" @blur="isEmpty('p')" @keyup.enter.native="loginSubmit"></el-input>
              </el-col>
              <el-col :span="24">
                <div ref="pwCheck" class="form-rule"></div>
              </el-col>
              <el-col :span="24">
                <el-col :span="12">
                  <el-input ref='captchaInput' v-model="login.captcha" maxlength="6" placeholder="请输入右侧验证码"
                            type="text" @blur="isEmpty('c')" @keyup.enter.native="loginSubmit"></el-input>
                </el-col>
                <el-col :span="12" class="captcha-box">
                  <img ref="captcha" alt="" height="40px" src="" title="点击换一张" @click="initCaptcha">
                </el-col>
              </el-col>
              <el-col :span="24" class="form-item">
                <el-col :span="12" class="item-left">
                  <el-checkbox v-model="login.remember">记住我</el-checkbox>
                </el-col>
                <el-col :span="12" class="item-right">
                  <el-link type="primary" @click="forgetPwd">忘记密码？</el-link>
                </el-col>
              </el-col>
              <el-col :span="24">
                <div ref="captchaCheck" class="form-rule"></div>
              </el-col>
            </el-col>
            <el-col :class="login.username==''||login.password==''||login.captcha==''?'content-submit-disabled':''" :span="24"
                    class="content-submit"
                    @click.native="loginSubmit">登录
            </el-col>
            <el-col :span="24" class="reg-box">
              <el-link @click="toReg">注 册</el-link>
            </el-col>
          </el-col>
        </el-col>
      </el-col>
      <el-col :span="24" class="login-bottom"></el-col>
    </el-col>

    <!-- 弹出层 -->
    <el-dialog :before-close="$utils.handleClose" :visible.sync="reg.dialogVisible" title="注册" width="30%">
      <el-form ref="reg" :model="reg.form" :rules="reg.rules" size="mini">
        <el-form-item :label-width="formLabelWidth" label="邮箱" prop="loginName">
          <el-input v-model="reg.form.loginName" placeholder="登录邮箱" @change="isChange = true"></el-input>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="密码" prop="passWord">
          <el-input v-model="reg.form.passWord" placeholder="登录密码" @change="isChange = true"></el-input>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="昵称" prop="nickName">
          <el-input v-model="reg.form.nickName" placeholder="您的昵称" @change="isChange = true"></el-input>
        </el-form-item>
        <el-col :span="24" class="reg-captcha-box">
          <el-col :span="15">
            <el-input v-model="reg.form.captcha" maxlength="6" placeholder="请输入验证码" type="text"></el-input>
          </el-col>
          <el-col :span="9" class="send-captcha-box" @click.native="regCaptcha">
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
export { default } from './login.js';
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

  input {
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