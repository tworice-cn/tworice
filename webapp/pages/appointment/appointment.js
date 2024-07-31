const host=getApp().host;
Page({
  data: {
    mealName: '',
    price: 0,
    mealId: '',
    date: '',
    startDate: '',
    endDate: '',
    timeRange: ['上午', '下午'],
    timeIndex: 0,
  },
  onLoad: function (options) {
    this.setData({
      mealName: options.name || '',
      price: options.price || 0,
      mealId: options.mealId || ''
    });

    // 设置可选择的日期范围
    const today = new Date()
    const year = today.getFullYear()
    const month = today.getMonth() + 1
    const day = today.getDate()
    const tomorrow = new Date(year, month - 1, day + 1)
    const nextMonth = new Date(year, month, day)
    this.setData({
      startDate: `${year}-${month}-${day}`,
      endDate: `${nextMonth.getFullYear()}-${nextMonth.getMonth() + 1}-${nextMonth.getDate()}`
    })
  },
  bindDateChange: function (e) {
    this.setData({
      date: e.detail.value
    })
  },
  bindTimeChange: function (e) {
    this.setData({
      timeIndex: e.detail.value
    })
  },

  handleReg() {
    if(this.data.date){
      wx.showLoading({
        title: '模拟支付'
      })
      setTimeout(() => {
        this.submit();
      }, 2000);
    }else{
      wx.showToast({
        title: '请选择日期',
        icon:'error'
      })
    }
  },
  submit(){
    let appointmentTime=new Date(this.data.date).getTime();
    if(this.data.timeIndex==0){
      // 上午
      appointmentTime+=32400000
    }else{
      appointmentTime+=43200000
    }
    getApp().request.post('/client/appointment/add',{
      mealId:this.data.mealId,
      appointmentTime:appointmentTime,
      state:'预约成功'
    }).then(res=>{
      wx.navigateBack();
      wx.showToast({
        title: '支付成功'
      })
    })
  }
})