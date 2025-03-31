// pages/login/login.js
const host = getApp().host;
Page({

    /**
     * 页面的初始数据
     */
    data: {
        loginName: '',
        passWord: '',
        key: '',
        captcha: '',
        verCode: ''
    },
    initCaptcha() {
        getApp().request.get('/admin/login/captcha').then(res => {
            if (res.data.status.code == 204) {
                wx.showModal({
                    title: '提示',
                    content: '获取验证码失败',
                    showCancel: false,
                    confirmText: '重新获取',
                    success: () => {
                        this.initCaptcha()
                    }
                })
            } else {
                this.setData({
                    key: res.data.data.key,
                    captcha: res.data.data.captcha
                })
            }
        })
    },

    /**登录 */
    login() {
        wx.showLoading({
            title: '正在登录',
        })
        getApp().request.post('/admin/login', {
            loginName: this.data.loginName,
            password: this.data.passWord,
            key: this.data.key,
            captcha: this.data.verCode
        }).then(res => {
            console.log(res);
            if (res.data.status.code == 200) {
                wx.setStorageSync('token', res.data.data.token);
                wx.setStorageSync('admin', res.data.data.admin);
                wx.setStorageSync('role', res.data.data.roles[0]);
                wx.switchTab({
                    url: '/pages/user/user'
                })
                wx.showToast({
                    title: '登录成功',
                    icon: 'success'
                })
            } else {
                console.log(res);
                wx.showToast({
                    title: '登录失败',
                    icon: 'none'
                })
                this.initCaptcha();
            }
        })
    },
    toReg() {
        wx.navigateTo({
            url: '/pages/reg/reg',
        })
    },
    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {
        wx.clearStorageSync();
        this.initCaptcha();
    },
    inputName(e) {
        this.setData({
            loginName: e.detail.value
        })
    },
    inputPwd(e) {
        this.setData({
            passWord: e.detail.value
        })
    },
    inputCaptcha(e) {
        this.setData({
            verCode: e.detail.value
        })
    }

})