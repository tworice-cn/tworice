export default {

    /**
     * 将时间戳格式化为日期时间
     * @param timeStamp 时间戳
     * @returns {string}
     */
    formatDateTime: function (timeStamp) {
        const date = new Date(timeStamp);
        const options = {year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'};
        return date.toLocaleString('zh-CN', options).replace(',', '');
    },

    /**
     * 将时间戳格式化为日期
     * @param timeStamp 时间戳
     * @returns {string}
     */
    formatDate: function (timeStamp) {
        const date = new Date(timeStamp);
        const options = {year: 'numeric', month: '2-digit', day: '2-digit'};
        return date.toLocaleString('zh-CN', options).replace(',', '');
    },

    /**
     * 下划线转驼峰命名 首字母小写
     * @param name 字符串
     * @returns {string}
     */
    lineToHump: function (name) {
        return name.replace(/_(\w)/g, function (all, letter) {
            return letter.toUpperCase();
        });
    },

    /**
     * 获取当前登录的用户ID
     * @returns {string}
     */
    getLoginUserID() {
        return JSON.parse(window.localStorage.getItem('admin')).id;
    },

    /**
     * 关闭弹窗
     * @param done
     */
    handleClose(done) {
        this.$confirm("确认关闭？").then(() => {
            done();
        });
    },

    mergeJSON(obj1,obj2) {
        for (let key in obj2) {
            if (obj2[key] !== null && obj2[key] !== undefined && obj2[key] !== '') {
                if (typeof obj2[key] === 'object' && !Array.isArray(obj2[key])) {
                    if (!obj1[key]) {
                        obj1[key] = {};
                    }
                    mergeJSON(obj1[key], obj2[key]);
                } else {
                    obj1[key] = obj2[key];
                }
            }
        }
        return obj1;
    },
}