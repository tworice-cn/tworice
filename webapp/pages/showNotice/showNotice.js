// pages/showNotice/showNotice.js
const host=getApp().host;
Page({

      /**
       * 页面的初始数据
       */
      data: {
            notice:{}
      },

      /**
       * 生命周期函数--监听页面加载
       */
      onLoad: function (options) {
            wx.showLoading({
              title: '加载公告',
            })
            getApp().request.get('/admin/notice/info?id='+options.id).then(res=>{
              let notice=res.data.data.info;
              notice.updateTime=this.formatTime(notice.updateTime);
              this.setData({
                    notice:notice
              })
            })
      },
      formatTime(e){
            var time =  new Date(parseInt(e));
            var y = time.getFullYear();
            var m = time.getMonth()+1;
            var d = time.getDate();
            let t= y+'年'+m+'月'+d+'日'+' '+time.getHours()+'时';
            return t;
      },
})