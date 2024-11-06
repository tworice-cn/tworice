// request.js
const Crypt=require('./crypt.js');
// 通用请求方法
const request = (url, method, data) => {
  return new Promise((resolve, reject) => {
    wx.request({
      url: getApp().host + url,
      method: method,
      data: data,
      header: {
        'content-type': 'application/x-www-form-urlencoded',
        'token': wx.getStorageSync('token'),
        'adminID': wx.getStorageSync('admin').id
        // 可以添加其他的请求头信息
      },
      success: (res) => {
        if(res.data.status){
          let code=parseInt(res.data.status.code);
                if(code>=400){
                  wx.showToast({
                    title: res.data.status.message,
                    icon:'none'
                  })
                  if(code === 401) {wx.navigateTo({
                    url: '/pages/login/login',
                  })}
                } else if(code === 201){ // 显示通知
                      wx.showToast({
                        title: res.data.status.message,
                      })
                      res.data.status.code=200;
                } else if(code === 202){ // 数据进行了加密
                      if(res.data.data.crypt){
                        res.data.data=JSON.parse(Crypt.decrypt(res.data.data));
                      }
                      res.data.status.code=200;
                }
        }
        wx.hideLoading();
        resolve(res);
      },
      fail: (err) => {
        // 网络错误或请求失败
        wx.showToast({
          title: '网络错误，请检查网络连接',
          icon: 'none'
        });
        reject(err);
      }
    });
  });
};

// 导出通用请求方法
module.exports = {
  get: (url, data) => request(url, 'GET', data),
  post: (url, data) => request(url, 'POST', data),
  deleted: (url, data) => request(url, 'DELETE', data),
  put: (url, data) => request(url, 'PUT', data),
  // 可以添加其他请求方法
};
