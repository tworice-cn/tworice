// pages/info/info.js
const host=getApp().host;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    admin:{},
    info:{},
    role:{},
    classify:[],
    classifyIndex:'',
    city:''
  },

  /**提交用户信息 */
  submitUser(){
    this.data.info.userId=this.data.admin.id;
    let info={};
    Object.keys(this.data.info).map((key) => {
      if(this.data.info[key]){
        info[key]=this.data.info[key]
      }
  });

    getApp().request.post('/admin/adminInfo/add',info).then(res=>{
      wx.showToast({
        title: '保存成功',
        icon:'success'
      })
      this.initInfo();
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      admin:wx.getStorageSync('admin'),
      role:wx.getStorageSync('role')
    },()=>{
        this.initUser();
    })
  },

  /**初始化用户信息 */
  initUser(){
    getApp().request.get('/admin/adminInfo/info/'+this.data.admin.id).then(res=>{
      this.setData({
        info:res.data.data.info
      })
    })
  },

  inputPhone(e){
    this.setData({
      'info.adminPhone':e.detail.value
    })
  },
  inputAdminEmail(e){
    this.setData({
      'info.adminEmail':e.detail.value
    })
  },
  inputNickName(e){
    this.setData({
      'info.nickName':e.detail.value
    })
  },
  inputAdminNote(e){
    this.setData({
      'info.adminNote':e.detail.value
    })
  }
})