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
}