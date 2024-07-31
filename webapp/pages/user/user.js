// pages/user/user.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    admin: {},
    role: {}
  },
  toJoin() {
    wx.navigateTo({
      url: '/pages/myJoin/myJoin',
    })
  },
  /**退出登录 */
  exit() {
    wx.clearStorageSync();
    wx.navigateTo({
      url: '/pages/login/login'
    })
  },
  /**编辑个人信息 */
  editInfo() {
    wx.navigateTo({
      url: '/pages/userInfo/userInfo'
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.showLogin();
  },

  showLogin() {
    let token = wx.getStorageSync('token') || null;
    if (token == null) {
      wx.showModal({
        title: '提示',
        content: '请先登录',
        showCancel: false,
        success: res => {
          if (res.confirm) {
            wx.navigateTo({
              url: '/pages/login/login'
            })
          }
        }
      })
    } else {
      this.setData({
        admin: wx.getStorageSync('admin'),
        role: wx.getStorageSync('role')
      })
    }
  },
  // 修改密码
  editPwd() {
    wx.showModal({
      title: '请输入新密码',
      content: '',
      placeholderText: '在这里输入新密码',
      editable: true,
      success: (res) => {
        if (res.confirm) {
          let passwordExd = /^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/
          if (!passwordExd.test(res.content)) {
            wx.showToast({
              title: '密码太过简单',
              icon: 'error'
            })
            return;
          }
          getApp().request.put('admin/admin/update', {
            id: wx.getStorageSync('admin').id,
            passWord: res.content
          }).then(res => {
            if (res.data.status.code < 300) {
              wx.showToast({
                title: '密码已更新'
              })
            }
          })
        }
      }
    });
  }
})