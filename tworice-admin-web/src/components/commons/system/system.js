export default {
    editPwd: function (vue) {
        vue.$prompt('请输入新密码', '修改密码', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            inputPattern: /^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/,
            inputErrorMessage: '密码应6~10位的数字+字母、字母+特殊字符、特殊字符+数字'
        }).then(({value}) => {
            let passwordExd = /^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/
            if (!passwordExd.test(value)) {
                vue.$msg({
                    type: 'warning',
                    message: '密码应6~10位的数字+字母、字母+特殊字符、特殊字符+数字'
                })
                return;
            }
            let formData = new FormData();
            formData.append("id", JSON.parse(window.localStorage.getItem('admin')).id);
            formData.append("passWord", value);
            vue.$axios({
                url: vue.$url + 'admin/admin/update',
                method: 'PUT',
                data: formData
            }).then(
                res => {
                    if (res.data.status.code == 200) {
                        window.localStorage.clear();
                        vue.$confirm('密码已更新，请立即重新登录!', '提示', {
                            confirmButtonText: '确定',
                            showCancelButton: false,
                            type: 'warning'
                        }).then(() => {
                            vue.$router.push('/login');
                        }).catch(() => {
                            vue.$msg({
                                type: 'error',
                                message: '密码更新失败'
                            })
                        });
                    }
                }
            )
        })
    },

    /* 安全退出系统 */
    exitSystem: function (vue) {
        let formData = new FormData();
        let admin = JSON.parse(window.localStorage.getItem('admin')) || {};
        if (admin != null) {
            formData.append('key', admin.id);
            vue.$axios({
                url: vue.$url + '/admin/system/offline',
                method: 'DELETE',
                data: formData
            });
        }
        window.localStorage.clear();
        window.sessionStorage.clear();
        vue.$router.push('/login')
        vue.$msg({
            type: 'success',
            message: '安全退出'
        });
    }
}