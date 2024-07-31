// pages/myJoin/myJoin.js
const host=getApp().host;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    arr:[]
  },
  tapItem(e){
    wx.showActionSheet({
      itemList: ['取消预约'],
      success:res=>{
        if(res.tapIndex==0){
          this.deleted(e.currentTarget.dataset,e.currentTarget.dataset.time)
        }
      },
    })
  },
  /**
   * 取消预约
   */
  deleted(e,appointmentTime){
    let time=appointmentTime-(new Date().getTime());
    if(time<0){
      wx.showToast({
        title: '不可取消'
      })
    }else if(time<43200000){ // 12小时
      wx.showModal({
        title: '提示',
        content: '距离预约时间较短，需扣除20%费用',
        complete: (res) => {
          if (res.confirm) {
            this.submitUpdate(e,0.8);
          }
        }
      })
    }else if(time<(43200000*2)){// 24小时
      wx.showModal({
        title: '提示',
        content: '距离预约时间较短，需扣除10%费用',
        complete: (res) => {
          if (res.confirm) {
            this.submitUpdate(e,0.9);
          }
        }
      })
    }else{
      this.submitUpdate(e,1);
    }
  },
  /**
   * 提交取消预约
   * @param {*} proportion 退的比例
   */
  submitUpdate(e,proportion){
    console.log(e);
    wx.showLoading({
      title: '取消预约'
    })
    getApp().request.get('/client/setMeal/info?id='+e.mealid).then(res=>{
      let price=res.data.data.info.price;
      this.submit(e,Math.ceil(price*proportion));
    })
  },
  submit(e,price){
    getApp().request.post('/client/appointment/add',{id:e.id,state:'取消预约'}).then(res=>{
      this.onShow();
        wx.showToast({
          title: '退费'+(price)+'元',
        })
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    getApp().request.get('/client/appointment/list?creator='+wx.getStorageSync('admin').id).then(res=>{
      let list=res.data.data.list;
      list.forEach(item => {
        if(item){
          item.time=this.formatDate(item.appointmentTime);
        }
      });
      this.setData({
        arr:list
      },()=>{
        wx.hideLoading();
      })
    })
  },
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