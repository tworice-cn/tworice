// pages/reg/reg.js
const host=getApp().host;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    role:4,
    captchaText:'发送验证码',
    time:0,// 倒计时
    interval:{},// 倒计时对象
    reg:{
      loginName:'',
      password:'',
      captcha:'',
      key:'',
      nickName:''
    }
  },

  /**注册 */
  toReg(){
    let i=1;
    Object.keys(this.data.reg).forEach(item=>{
      if(this.data.reg[item]==''){
        i--;
      }
    })
    if(i!=1){
      wx.showToast({
        title: '必填项不能为空',
        icon:'none'
      })
    }else{
      wx.showLoading({
        title: '正在注册',
      })
      getApp().request.post('/admin/login/reg',{
        loginName:this.data.reg.loginName,
        nickName:this.data.reg.nickName,
        passWord:this.data.reg.password,
        role:this.data.role,
        key:this.data.reg.key,
        captcha:this.data.reg.captcha
      }).then(res=>{
        wx.navigateBack();
        wx.showToast({
          title: res.data.status.message,
          icon:'none'
        })
      })
    }
  },

  /**发送验证码 */
  send_captcha(){
    if(this.data.time>0){
      wx.showToast({
        title: '请'+this.data.time+'秒后再试',
        icon:'none'
      })
    }else if(this.data.reg.loginName==''){
      wx.showToast({
        title: '邮箱不能为空',
        icon:'error'
      })
    }else{
      wx.showLoading({
        title: '正在发送',
      })
      this.setData({
        time:30
      },()=>{
        // 执行的业务逻辑
        getApp().request.get('/admin/login/regCaptcha?email='+this.data.reg.loginName).then(res=>{
          wx.showToast({
            title: '验证码已发送',
            icon:'success'
          });
          // 设置倒计时
          let interval=setInterval(()=>{
            this.updateTime();
          },1000);
          this.setData({
            interval:interval,
            'reg.key':res.data.data.key
          })
        })
      })
    }
  },
  updateTime(){
    if(this.data.time<1){
      clearInterval(this.data.interval)
      this.setData({
        captchaText:'发送验证码'
      })
    }else{
      this.setData({
        time:this.data.time-1,
        captchaText:this.data.time-1+'秒后重新发送'
      })
    }

  },

  /**切换菜单 */
  switch_menu(e){
    this.setData({
      role:e.currentTarget.dataset.role
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  loginName(e){
    this.setData({
      'reg.loginName':e.detail.value
    })
  },
  passWord(e){
    this.setData({
      'reg.password':e.detail.value
    })
  },
  captcha(e){
    this.setData({
      'reg.captcha':e.detail.value
    })
  },
  nickName(e){
    this.setData({
      'reg.nickName':e.detail.value
    })
  },
})