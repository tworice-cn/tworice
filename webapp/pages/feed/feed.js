// pages/myJoin/myJoin.js
const host = getApp().host;
Page({
  data: {
    typeList: [],
    form: {
      id: '',
      createTime: '',
      updateTime: '',
      creator: '',
      fbType: '',
      fbDescribe: '',
      fbContact: '',
      typeName: '',
      fbState: '处理中'
    }
  },
  changeType(e) {
    console.log(e);
    this.setData({
      'form.fbType': e.currentTarget.dataset.id,
      'form.typeName': e.currentTarget.dataset.typename
    });
  },
  submit() {
    
    wx.request({
      url: host + '/client/systemFeedback/add',
      method: 'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded',
        'adminID':wx.getStorageSync('admin').id
      },
      data: this.data.form,
      success: res => {
        if (res.data.status.code == 200) {
          wx.navigateBack()
          wx.showToast({
            title: '反馈成功',
            icon: 'success'
          })
        }
      },
    });
  },
  handleContactInput(e) {
    this.setData({
      'form.fbContact': e.detail.value
    });
  },
  handleDescribeInput(e) {
    this.setData({
      'form.fbDescribe': e.detail.value
    });
  },
  resetType() {
    this.setData({
      'form.fbType': ''
    });
  },
  onLoad() {
    wx.request({
      url: host + '/client/systemFeedback/type',
      success: res => {
        this.setData({
          typeList: res.data.data.list
        });
      }
    })
  }
})