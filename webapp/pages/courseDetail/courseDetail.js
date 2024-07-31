// pages/courseDetail/courseDetail.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    info:{},
    host:''
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {
    this.setData({
      info:wx.getStorageSync('course'),
      host:getApp().host
    })
  },
})