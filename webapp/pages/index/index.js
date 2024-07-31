// pages/search/search.js
const host=getApp().host;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    role:{},
    arr:[],
    name:'',
    noticeBG:'',
    notices:[]
  },

  handBut(e){
    // if(e.detail.value==""){
    //   return;
    // }
    this.setData({
      name:e.detail.value
    },()=>{
      this.toPage();
    })
  },

  formatDate(row) {
    let date = new Date(row.date);
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

  /**查看 */
  toPage(){
    wx.showLoading({
      title: '加载中',
    })
    let params='';
    params+='&name='+this.data.name;
    getApp().request.get('/client/setMeal/list?page=1&pageSize=100'+params).then(res=>{
      if(res.data.status.code>400){
        this.toLogin();
      }
      let list=res.data.data.list;
      list.forEach(item => {
        item.date=this.formatDate(item);
      });
      this.setData({
        arr:list
      },()=>{
        wx.hideLoading();
      })
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
  onShow: function () {
    this.initNotice();
    let token=wx.getStorageSync('token')||null;
    if(token==null){
      this.toLogin();
    }else{
      this.setData({
        role:wx.getStorageSync('role')
      },()=>{
        this.toPage();
      })
    }
  },
  initNotice(){
    getApp().request.get('admin/notice/top').then(res=>{
      res.data.data.list.forEach(item=>{
        item.updateTime=this.formatTime(item.updateTime);
      })
      this.setData({
        notices:res.data.data.list
      })
    })
  },
  formatTime(e){
    var time =  new Date(parseInt(e));
      var y = time.getFullYear();
      var m = time.getMonth()+1;
      var d = time.getDate();
      let t= y+'年'+m+'月'+d+'日';
    return t;
  },
  onLoad(options){
    this.initBg();
  },
  initBg(){
        // 请求公告背景图片
        wx.request({
          url:'https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN',
          success: res=>{
              this.setData({
                noticeBG:'https://cn.bing.com'+res.data.images[0].url
              })
          }
        })
  }
})