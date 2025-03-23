import feedback from "@/components/feedback";
import BackBox from "@/components/commons/BackBox.vue";
import Descriptions from "../../../components/commons/Descriptions.vue";
import StorageUtils from "@/util/StorageUtils";

export default {
    name: "",
    props: [],
    components: {feedback, BackBox, Descriptions},
    data() {
        return {
            activeName: 'userInfo',
            userData: {},
            logList: [],
            formVisible: false,
            adminInfo: {},
            isChange: false,
            userMenu: [
                {
                    "name": '个人信息',
                    "key": 'userInfo',
                    "me": false
                },
                {
                    "name": '操作日志',
                    "key": 'userLog',
                    "me": true
                },
                {
                    "name": '系统公告',
                    "key": 'systemNotice',
                    "me": true
                },
                {
                    "name": '反馈建议',
                    "key": 'feedback',
                    "me": true
                },
            ],
            userInfo: [], // 展示到用户中的
            notice: {
                list: [],
                page: 1,
                pageSize: 10,
                total: 0,
            },
            isMe: false,
            inviteCode: ''
        };
    },
    computed: {
        /**
         * 判断是否为用户
         * @returns {boolean}
         */
        isUser() {
            if (this.adminInfo.roles.length > 0) {
                return this.adminInfo.roles[0].id == 4;
            }
            return false;
        },
    },
    methods: {
        /**
         * 编辑登录名
         */
        editLoginName() {
            this.$prompt('请输入新登录账号', '修改登录账号', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                inputPattern: /^[A-Za-z0-9]{2,8}$/,
                inputErrorMessage: '登录账号应是2~8位的字母、数字组成'
            }).then(({value}) => {
                this.$axios({
                    url: this.$url + "/admin/admin/updateLoginName",
                    method: "PUT",
                    params: {
                        id: this.$route.params.id,
                        loginName: value
                    }
                }).then(res => {
                    if (res.data.status.code < 300) {
                        this.initAdminInfo();
                        this.$msg({
                            type: 'success',
                            message: res.data.status.message
                        })
                    }
                })
            });
        },
        checkMenu(key) {
            this.activeName = key;
        },
        showNotice(item) {
            // 跳转到showNotice路由并携带id参数
            this.$router.push({path: '/admin/showNotice', query: {id: item.id}});
        },
        submit() {
            this.$root.loading = true;
            // 判断昵称是否被修改
            if (this.adminInfo.nickName !== StorageUtils.getNickName()) {
                this.updateNickName();
            }
            if (!this.isChange) {
                this.$root.loading = false;
                this.formVisible = false;
                return;
            }
            let formData = new FormData();
            this.adminInfo.userId = this.userData.id;
            Object.keys(this.adminInfo).map((key) => {
                if (this.adminInfo[key]) {
                    formData.append(key, this.adminInfo[key]);
                }
            });
            this.$axios({
                method: "POST",
                url: this.$url + "/admin/adminInfo/add",
                data: formData,
            }).then(() => {
                this.initAdminInfo();
                this.formVisible = false;
                this.$msg({
                    type: 'success',
                    message: '更新成功'
                })
            });
        },
        updateNickName() {
            if (this.adminInfo.nickName && this.adminInfo.nickName != '') {
                let format = new FormData();
                format.append("id", this.userData.id);
                format.append("nickName", this.adminInfo.nickName);
                this.$axios({
                    method: 'post',
                    url: this.$url + "/admin/admin/add",
                    data: format
                }).then(
                    () => {
                        this.$notify.success({
                            title: '提醒',
                            message: '更新昵称成功，重新登录生效'
                        });
                    }
                )
            }
        },
        init() {
            let id = this.$route.params.id;
            let userID = StorageUtils.getUserId();
            if (userID === id) {
                this.isMe = true;
            }
            this.userData = {
                id: id
            }
            this.initLogList();
            this.initAdminInfo();
            this.initNotice();
        },
        initNotice() {

            this.$axios.get(this.$url + "admin/notice/list?page=" + this.notice.page + "&pageSize=" + this.notice.pageSize).then(
                response => {
                    this.notice.list = response.data.data.list;
                    this.notice.total = response.data.data.total;
                }
            )
        },
        initAdminInfo() {
            this.$axios.get(
                this.$url + "/admin/adminInfo/info/" + this.userData.id
            )
                .then((response) => {
                    let info = response.data.data.info;
                    if (info) {
                        this.adminInfo = info;
                        this.adminInfo.roleName = info.roles[0].roleName;
                    }
                    this.initUserInfo();
                });
        },
        initUserInfo() {
            this.userInfo = [];
            this.userInfo.push({icon: 'el-icon-user', name: '昵称', value: this.adminInfo.nickName})
            this.userInfo.push({icon: 'el-icon-coordinate', name: '角色', value: this.adminInfo.roleName})
            this.userInfo.push({
                icon: 'el-icon-male',
                name: '性别',
                value: this.adminInfo.adminSex === 1 ? '男' : this.adminInfo.adminSex === 2 ? '女' : '未知'
            })
            this.userInfo.push({icon: 'el-icon-mobile-phone', name: '联系方式', value: this.adminInfo.adminPhone})
            this.userInfo.push({icon: 'el-icon-message', name: '邮箱', value: this.adminInfo.adminEmail})
            this.userInfo.push({icon: 'el-icon-location-outline', name: '居住地', value: this.adminInfo.homePlace})
            this.userInfo.push({
                icon: 'el-icon-office-building',
                name: '联系地址',
                value: this.adminInfo.contactAddress
            })
            this.userInfo.push({icon: 'el-icon-tickets', name: '备注', value: this.adminInfo.adminNote})
            if (this.isMe) {
                let inviteCode = StorageUtils.getInviteCode();
                this.userInfo.push({icon: 'el-icon-s-tools', name: '邀请码', value: inviteCode})
                this.inviteCode = inviteCode;
            }
        },
        initLogList() {
            let roles = JSON.parse(window.localStorage.getItem('roles'));
            let state = false;
            roles.forEach(element => {
                if (element.id < 3) {
                    state = true;
                }
            });
            if (state) {
                // 当前为管理员
                this.$axios.get(this.$url + '/admin/log/adminList?pageSize=10&page=0&userId=' + this.userData.id).then(
                    response => {
                        response.data.data.list.forEach(item => {
                            let logItem = {
                                nickName: item.admin,
                                time: item.createTime,
                                info: item.active
                            }
                            this.logList.push(logItem);
                        })
                        this.$axios.get(this.$url + '/admin/log/loginList?pageSize=10&page=0&loginName=' + this.userData.loginName).then(
                            loginLogresponse => {
                                loginLogresponse.data.data.list.forEach(item => {
                                    let logItem = {
                                        nickName: '账号' + this.userData.loginName,
                                        time: item.createTime,
                                        info: "登录" + (item.status == 1 ? '成功' : '失败')
                                    }
                                    this.logList.push(logItem);
                                })
                                this.logList.sort(function (a, b) {
                                    return parseInt(b.time) - parseInt(a.time)
                                })
                                this.logList = this.logList.slice(0, 10);
                            }
                        )
                    }
                )


            } else {
                // 当前为用户
                this.$axios.get(this.$url + '/admin/log/loginList?pageSize=10&page=0&loginName=' + this.userData.loginName).then(
                    response => {
                        let logList = response.data.data.list;
                        logList.forEach(item => {
                            let logItem = {
                                nickName: '账号' + this.userData.loginName,
                                time: item.createTime,
                                info: "登录" + (item.status == 1 ? '成功' : '失败')
                            }
                            this.logList.push(logItem);
                        })
                    }
                )
            }
        },
        /**
         * 获取邀请码
         */
        getInviteCode() {
            this.$root.loading = true;
            this.$axios({
                url: this.$url + "/admin/admin/invite",
                method: "PUT"
            }).then(res => {
                this.inviteCode = res.data.data.inviteCode;
                StorageUtils.setInviteCode(res.data.data.inviteCode);
            })
        },

        getInviteLink() {
            return window.location.origin + "/#/login?inviteCode=" + this.inviteCode;
        },
    },
    mounted() {
        this.init();
    }
};