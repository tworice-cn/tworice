import axios from 'axios'
import {Message} from "element-ui";

let token = '';
let adminID = '';

export function setupAxios(vue,router) {
    axios.defaults.headers.common['token'] = token;
    axios.defaults.headers.common['adminID'] = adminID;
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';

    // 添加一个请求拦截器
    axios.interceptors.request.use(function (config) {
        let user = window.sessionStorage.getItem('token');
        let admin = window.sessionStorage.getItem('admin');

        if (user != null && user !== '') {
            admin = JSON.parse(admin);
            adminID = admin.id;
            token = user;
        }
        config.headers.common['token'] = token;
        config.headers.common['adminID'] = adminID;

        return config;
    }, function (error) {
        return Promise.reject(error);
    });

    // 添加一个响应拦截器
    let messageInstance = null;
    axios.interceptors.response.use(
        function (response) {

            vue.loading = false;
            if (response.data.status) {
                vue.loading = false;
                if (messageInstance) {
                    messageInstance.close() //关闭
                }
                let code = parseInt(response.data.status.code);
                if (code === 400) {
                    // 登录失败
                    Message({
                        type: 'info',
                        message: response.data.status.message
                    })

                } else if (code === 401) {
                    //未登录
                    window.sessionStorage.removeItem('token');

                    Message({
                        type: 'info',
                        message: response.data.status.message
                    })
                    router.push('/login');
                } else if (code > 401) {
                    Message({
                        type: "error",
                        message: response.data.status.message,
                    });
                } else if (code <= 201) {
                    response.data.status.code = 200;
                }
            }
            return response;
        },
        function (error) {
            console.log(error);
            // router.push('/login');
            Message({
                type: 'info',
                message: '服务器连接异常'
            })
            vue.loading = false;
        }
    );

    return axios;
}