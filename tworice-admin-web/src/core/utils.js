export default{
      formatDate:function(timeStamp){
            let date = new Date(timeStamp);
            let month =
                  date.getMonth() + 1 < 10
                        ? "0" + (date.getMonth() + 1)
                        : date.getMonth() + 1;
            let day =
                  date.getDate() < 10
                        ? "0" + date.getDate()
                        : date.getDate();
            let hours =
                  date.getHours() < 10
                        ? "0" + date.getHours()
                        : date.getHours();
            let minutes =
                  date.getMinutes() < 10
                        ? "0" + date.getMinutes()
                        : date.getMinutes();
            return (
                  date.getFullYear() +
                  "-" +
                  month +
                  "-" +
                  day +
                  " " +
                  hours +
                  ":" +
                  minutes
            );
      },
      /**下划线转驼峰命名 首字母小写 */
      lineToHump:function(name){
            let firstChange = name.replace(/_(\w)/g, function (all, letter) {
                  return letter.toUpperCase();
            });
            return firstChange;
      },
      /**获取当前登录的用户ID */
      getLoginUserID(){
            return JSON.parse(window.localStorage.getItem('admin')).id;
      },
      handleClose(done) {
            this.$confirm("确认关闭？").then(() => {
                  done();
            });
      },
}