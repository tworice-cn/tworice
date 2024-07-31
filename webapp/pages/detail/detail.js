// pages/detail/detail.js
const host=getApp().host;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    info:{},
    host:'',
    num:10,// 当前已经报名人数
    status:false,
    current:''
  },

  /**点击报名 */
  handleReg(){
    wx.navigateTo({
      url: `/pages/appointment/appointment?name=${this.data.info.mealName}&price=${this.data.info.price}&mealId=${this.data.info.id}`,
    })
  },

  /**点击打电话 */
  handlePhone(){
    wx.makePhoneCall({
      phoneNumber: this.data.info.contact,
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.showLoading({
      title: '加载中',
    })
    getApp().request.get('/client/setMeal/info?id='+options.id).then(res=>{
      let info=res.data.data.info;
      info.date=this.formatDate(info.createTime);
      this.setData({
        info:info,
        host:host
      },()=>{
        wx.hideLoading();
      })
    })
  },

  /**格式化时间 */
  formatDate(row) {
    let date = new Date(row);
    let month =
          date.getMonth() + 1 < 10
                ? "0" + (date.getMonth() + 1)
                : date.getMonth() + 1;
    let day =
          date.getDate() < 10
                ? "0" + date.getDate()
                : date.getDate();
    return (
          date.getFullYear() +
          "-" +
          month +
          "-" +
          day 
    );
  }, 
})