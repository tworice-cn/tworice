const admin = 'admin';

export default {
    /**
     * 获取Storage的统一写法
     * @param key
     * @returns {any|null}
     */
    getStorage: function (key) {
        const storage = localStorage.getItem(key);
        return storage ? JSON.parse(storage) : null;
    },
    /**
     * 获取账户信息
     * @returns {any}
     */
    getUser: function () {
        return this.getStorage(admin);
    },

    setUser: function (user) {
        localStorage.setItem(admin, JSON.stringify(user));
    },

    /**
     * 获取昵称
     * @returns {string}
     */
    getNickName: function () {
        return this.getUser().nickName;
    },

    /**
     * 获取用户ID
     * @returns {string}
     */
    getUserId: function () {
        return this.getUser().id;
    },

    /**
     * 获取登录名
     * @returns {string}
     */
    getLoginName: function () {
        return this.getUser().loginName;
    },

    /**
     * 获取邀请码
     * @returns {string|*}
     */
    getInviteCode: function () {
        return this.getUser().inviteCode;
    },

    /**
     * 设置邀请码
     */
    setInviteCode: function (inviteCode) {
        let user = this.getUser();
        user.inviteCode = inviteCode;
        this.setUser(user);
    },

    /**
     * 从缓存中获取登录表单
     * @returns {*|null}
     */
    getLoginForm: function () {
        return this.getStorage('loginForm');
    },

    /**
     * 设置Storage的统一写法
     * @param key
     * @param value
     */
    setStorage: function (key, value) {
        // 检查值是否为字符串类型
        if (typeof value !== 'string') {
            // 对非字符串值进行转换
            try {
                value = JSON.stringify(value);
            } catch (error) {
                console.error('JSON 序列化失败:', error);
                // 如果转换失败，使用安全回退方案
                value = String(value);
            }
        }
        localStorage.setItem(key, value);
    },

    /**
     * 设置token
     * @param token
     */
    setToken: function (token) {
        this.setStorage('token', token);
    },
}