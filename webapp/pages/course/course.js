// pages/course/course.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    list:[]
  },

  toDetail(e){
    wx.setStorageSync('course', e.currentTarget.dataset.id);
    wx.navigateTo({
      url: '/pages/courseDetail/courseDetail',
    })
  },

  toLogin(){
    wx.showModal({
      title: '提示',
      content: '请先登录',
      showCancel:false,
      success:res=> {
        if (res.confirm) {
          wx.navigateTo({
            url: '/pages/login/login'
          })
        }
      }
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {
    if(wx.getStorageSync('token')==null){
      this.toLogin();
    }
    getApp().request.get('/client/partyCourse/list?page=0&pageSize=100').then(res=>{
      this.setData({
        list:res.data.data.list
      })
    })
  },

})