<!--大背景图，圆角登录框-->
<template>
  <div class="login tworice-login-bg">
    <el-col :span="24">
      <el-col :span="24" class="login-top"></el-col>
      <el-col :span="24" class="login-middle">
        <el-col :md="8" class="min-height"></el-col>
        <el-col :md="8" class="login-content">
          <el-col :span="24" class="content-title">
            <!-- <i class="iconfont icon-logo"></i> -->
            登 录
          </el-col>
          <el-form @submit="loginSubmit">
            <el-col :span="24" class="content-form">
              <el-col :span="24">
                <el-input placeholder="请输入用户名" ref='userInput' type="text" suffix-icon="el-icon-user" v-model="login.loginName" @keyup.enter.native="loginSubmit" @blur="isEmpty('u')"></el-input>
              </el-col>
              <el-col :span="24">
                <div class="form-rule" ref="userCheck"></div>
              </el-col>
              <el-col :span="24">
                <el-input placeholder="请输入密码" class="pw-input" type="password" suffix-icon="el-icon-lock" v-model="login.password" @keyup.enter.native="loginSubmit" @blur="isEmpty('p')"></el-input>
              </el-col>
              <el-col :span="24">
                <div class="form-rule" ref="pwCheck"></div>
              </el-col>
              <el-col :span="24">
                <el-col :span="12">
                  <el-input placeholder="请输入右侧结果" maxlength="6" ref='captchaInput' type="text" v-model="login.captcha" @keyup.enter.native="loginSubmit" @blur="isEmpty('c')"></el-input>
                </el-col>
                <el-col :span="12" class="captcha-box">
                  <img src="" alt="" height="40px" ref="captcha" @click="initCaptcha" title="点击换一张">
                </el-col>
              </el-col>
              <el-col :span="24">
                <div class="form-rule" ref="captchaCheck"></div>
              </el-col>
            </el-col>
            <el-col :span="24" class="content-submit" :class="login.username==''||login.password==''||login.captcha==''?'content-submit-disabled':''" @click.native="loginSubmit">登录</el-col>
          </el-form>
          <el-col :span="24" class="reg-box"><el-link @click="toReg">注 册</el-link></el-col>
        </el-col>
        <el-col :md="8" class="min-height"></el-col>
      </el-col>
      <el-col :span="24" class="login-bottom"></el-col>
    </el-col>

    <!-- 弹出层 -->
    <el-dialog title="注册" :visible.sync="reg.dialogVisible" width="30%" :before-close="$utils.handleClose">
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
          <el-col :span="13" class="reg-captcha-input-box">
            <el-input v-model="reg.form.captcha" maxlength="6" placeholder="请输入验证码" type="text"></el-input>
          </el-col>
          <el-col :span="11" class="send-captcha-box" @click.native="regCaptcha">
            {{ reg.send_captcha }}
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
export { default } from './login.js';
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

    height: 380px;
    background-color: rgba(255, 255, 255);
    border-radius: 18px;
    padding: 0 3vw;

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
      background:#00A3FF;
      line-height: 40px;
      text-align: center;
      // letter-spacing: 10px;
      border-radius: 3px;
      cursor: pointer;
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
}
.reg-captcha-box{
  height: 50px;
  margin-bottom: 30px;

  .reg-captcha-input-box{
    overflow: hidden;
  }

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