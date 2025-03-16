import {submitForm} from "@/api/feedback/feedback";
import ReAuth from "@/components/commons/loginForm/reAuth.vue";
import routerUtils from "@/util/RouterUtils";
import StorageUtils from "@/util/StorageUtils";
export default {
    name: "LoginForm",
    props: {
        regText: { // 注册按钮文字
            type: String,
            default: '注册'
        },
        loginText: { // 登录按钮文字
            type: String,
            default: '登录'
        },
        showReg: { // 是否允许注册
            type: Boolean,
            default: true
        },
        showLabel: { // 是否显示label提示
            type: Boolean,
            default: true
        },
    },
    components:{
        ReAuth
    },
    data() {
        return {
            showState:'login',
            formLabelWidth: '60px',
            login: {
                loginName: '',
                password: '',
                captcha: '',
                key: '',
                remember: false
            },
            reg: {
                time: 30,
                send_captcha: '发送验证码',
                dialogVisible: false,
                submitButton: true,
                interval: '',// 倒计时
                form: {
                    loginName: '',
                    passWord: '',
                    nickName: '',
                    captcha: '',
                    key: '',
                    inviteCode: ''
                },
                rules: {
                    loginName: [
                        {required: true, message: '请输入登录邮箱', trigger: 'blur'},
                        {min: 6, message: '长度应大于或等于6 个字符', trigger: 'blur'}
                    ],
                    passWord: [
                        {required: true, message: '请输入登录密码', trigger: 'blur'},
                        {
                            pattern: /^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/,
                            message: '密码应6~10位的数字+字母、字母+特殊字符、特殊字符+数字',
                            trigger: 'blur'
                        }
                    ],
                    nickName: [
                        {required: true, message: '请输入昵称', trigger: 'blur'}
                    ],
                },
            },

        }
    },
    methods: {
        submitForm,
        /**提交注册 */
        submitReg() {
            this.$refs['reg'].validate(validate => {
                if (validate) {
                    // 提交注册
                    let formData = new FormData();
                    Object.keys(this.reg.form).forEach(item => {
                        formData.append(item, this.reg.form[item]);
                    })
                    this.$axios({
                        url: this.$url + '/admin/login/reg',
                        data: formData,
                        method: 'post'
                    }).then(res => {
                        this.$msg({
                            type: 'info',
                            message: res.data.status.message
                        })
                        this.reg.dialogVisible = false;
                    })
                }
            })

        },
        /**倒计时发送验证码 */
        updateTime() {
            if (this.reg.time == 1) {
                window.clearInterval(this.reg.interval);
                this.reg.send_captcha = '发送验证码';
            } else {
                this.reg.time = this.reg.time - 1;
                this.reg.send_captcha = this.reg.time + '秒后重新发送'
            }
        },
        /**发送注册验证码 */
        regCaptcha() {
            if (this.reg.send_captcha != '发送验证码') {
                return;
            }
            if (this.reg.form.loginName == '') {
                this.$msg({
                    type: 'error',
                    message: '邮箱不能为空'
                })
            } else {
                this.$root.loading = true;
                this.$axios.get(this.$url + '/admin/login/regCaptcha?email=' + this.reg.form.loginName).then(res => {
                    this.$msg({
                        type: 'info',
                        message: res.data.status.message
                    })
                    if (res.data.status.code == 200) {
                        this.reg.form.key = res.data.data.key;
                        // 初始化倒计时
                        this.reg.time = 30;
                        this.reg.interval = setInterval(() => {
                            this.updateTime();
                        }, 1000);
                    }

                })
            }
        },
        /**注册 */
        toReg() {
            this.reg.dialogVisible = true;
        },
        loginSubmit() {
            //判空
            if (this.login.loginName == '' || this.login.password == '' || this.login.captcha == '') {
                return
            }
            this.$root.loading = true;
            let format = new FormData();
            format.append("loginName", this.login.loginName);
            format.append("password", this.login.password);
            format.append("verCode", this.login.captcha);
            format.append("key", this.login.key);
            this.$axios({
                method: 'post',
                url: this.$url + '/admin/login/',
                data: format
            }).then(
                response => {
                    if(response.data.data.reAuth){
                        // 二次验证
                        this.login.key=response.data.data.key;
                        this.showState='reAuth';
                    }else if (response.data.status.code === 200) {
                        if (this.login.remember) {
                            localStorage.setItem("loginForm", JSON.stringify(this.login));
                        }
                        this.checkLoginResult(response);
                    }else{
                        this.initCaptcha();
                        this.login.password = '';
                        this.login.captcha = '';
                    }
                }
            ).catch(() => {
                this.initCaptcha();
            })
        },
        checkLoginResult(response){
            // 登录成功
            window.localStorage.setItem("token", response.data.data.token);
            window.localStorage.setItem("admin", JSON.stringify(response.data.data.admin))
            window.localStorage.setItem("resources", JSON.stringify(this.filterNestedDuplicates(response.data.data.resources)))
            window.localStorage.setItem("roles", JSON.stringify(response.data.data.roles))

            // 动态添加VueRouter路由
            routerUtils.addRoutes(response.data.data.resources).then(() => {
                this.successLogin(response.data.data.roles);
            }).catch((error) => {
                console.error("Failed to add routes:", error);
                // 可以在这里处理添加路由失败的情况
            });
        },
        /**
         * 递归过滤数组中的重复对象
         * @param array
         * @returns {*}
         */
        filterNestedDuplicates(array) {
            const uniqueIds = new Set();
            const filteredArray = [];

            for (const item of array) {
                if (!uniqueIds.has(item.id)) {
                    uniqueIds.add(item.id);
                    if (item.children && Array.isArray(item.children)) {
                        // 递归处理子对象数组
                        item.children = this.filterNestedDuplicates(item.children);
                    }
                    filteredArray.push(item);
                }
            }

            return filteredArray;
        },
        // 登录成功跳转
        successLogin(roles) {
            if (roles == null || roles.length == 0) {
                this.$msg({
                    type: 'error',
                    message: '权限不足'
                })
                return;
            }
            let path='/admin';
            if (roles[0].id == 4) {
                path='/home';
            }
            this.$router.push(path);
            window.localStorage.setItem("index", path);
        },
        // 表单验证是否为空
        isEmpty(con) {
            if (con == 'u') {
                if (this.login.loginName == '') {
                    this.$refs.userCheck.innerHTML = '用户名不能为空'
                } else {
                    this.$refs.userCheck.innerHTML = ''
                }
            } else if (con == 'p') {
                if (this.login.password == '') {
                    this.$refs.pwCheck.innerHTML = '密码不能为空'
                } else {
                    this.$refs.pwCheck.innerHTML = ''
                }
            } else if (con == 'c') {
                if (this.login.captcha == '') {
                    this.$refs.captchaCheck.innerHTML = '验证码不能为空'
                } else {
                    this.$refs.captchaCheck.innerHTML = ''
                }
            }
        },
        // 初始化验证码
        initCaptcha() {
            let param = "";
            if (this.reg.form.key != '') {
                param += '?code=' + this.reg.form.key
            }
            this.$axios.get(this.$url + '/admin/login/captcha' + param).then(
                res => {
                    if (res.data.status.code == 204) {
                        this.$msg({
                            type: 'warning',
                            message: res.data.status.message
                        })
                    } else {
                        this.login.key = res.data.data.key;
                        this.$refs.captcha.src = res.data.data.captcha;
                    }
                }
            ).catch(() => {
                // this.initCaptcha()
            })
        },

        /* 忘记密码 */
        forgetPwd() {
            this.$alert('重新进行账号注册可重新设置密码，账号信息会进行保留。', '忘记密码', {
                confirmButtonText: '确定',
                callback: () => {
                    this.toReg();
                }
            });
        }
    },
    mounted() {
        if (this.$route.query.inviteCode) {
            this.reg.form.inviteCode = this.$route.query.inviteCode;
        }
        let loginForm = StorageUtils.getLoginForm();
        if (loginForm) {
            this.login.loginName = loginForm.loginName;
            this.login.password = loginForm.password;
        }
        this.initCaptcha();
    }
};