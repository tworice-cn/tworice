import axios from 'axios'
import {Notification} from "element-ui";

let token = '';
let adminID = '';

export function setupAxios(router,vue) {
    axios.defaults.headers.common['token'] = token;
    axios.defaults.headers.common['adminID'] = adminID;
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';

    // 添加一个请求拦截器
    axios.interceptors.request.use(config=> {
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
    }, error=>{
        return Promise.reject(error);
    });

    // 添加一个响应拦截器
    axios.interceptors.response.use(
        response => {
            vue.loading = false;
            if (response.data.status) {
                let code = parseInt(response.data.status.code);
                if (code === 400) {
                    // 登录失败
                    Notification({
                        title: '提示',
                        type: 'info',
                        message: response.data.status.message
                    })

                } else if (code === 401) {
                    //未登录
                    window.sessionStorage.removeItem('token');

                    Notification({
                        title: '提示',
                        type: 'warning',
                        message: response.data.status.message
                    })
                    router.push('/login');
                } else if (code > 401) {
                    Notification({
                        title: '提示',
                        type: "error",
                        message: response.data.status.message,
                    });
                } else if (code <= 201) {
                    response.data.status.code = 200;
                }
            }
            return response;
        },
        error => {
            console.log(error);
            Notification({
                title: '提示',
                type: 'warning',
                message: '服务器连接异常'
            })
            vue.loading = false;
        }
    );

    return axios;
}