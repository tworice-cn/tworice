import axios from 'axios'
import Crypt from "@/components/commons/crypt/crypt";
import { Notification, Message } from 'element-ui';
import storage from '@/util/StorageUtils'

export function createAxiosService(router, baseURL) {
    // 1. 创建 Axios 实例
    const service = axios.create({
        baseURL,
        timeout: 30000,
        withCredentials: false,
    })

    // 2. 设置默认请求头
    service.defaults.headers.common['token'] = ''
    service.defaults.headers.common['adminID'] = ''
    service.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'

    // 3. 请求拦截器
    service.interceptors.request.use(config => {
        const token = localStorage.getItem('token') || ''
        const admin = JSON.parse(localStorage.getItem('admin') || '{}');
        config.headers.common.token = token
        config.headers.common.adminID = admin.id || ''
        return config
    }, error => Promise.reject(error))

    // 4. 响应拦截器
    let isNotificationActive = false
    service.interceptors.response.use(
        response => {
            // 检查响应头是否有新 Token
            const newToken = response.headers['new-token'];
            if (newToken) {
                // 更新本地存储的 token
                storage.setToken(newToken)
                // 同时更新 Axios 默认请求头的 token
                service.defaults.headers.common.token = newToken;
            }

            if (response.data.status) {
                const code = parseInt(response.data.status.code)

                // 处理异常状态码
                if (code >= 400 && !isNotificationActive) {
                    isNotificationActive = true
                    Notification({
                        title: '提示',
                        type: code === 400 ? 'info' : (code === 401 ? 'warning' : 'error'),
                        message: response.data.status.message,
                        duration: 3000,
                        onClose: () => { isNotificationActive = false }
                    })

                    // 401 跳转登录页
                    if (code === 401) router.push('/login')
                    return Promise.reject(response)
                }

                // 处理成功状态码
                else if (code === 201) {
                    Message.success(response.data.status.message)
                    response.data.status.code = 200 // 状态码标准化
                }
                // 处理加密数据
                else if (code === 202 && response.data.data.crypt) {
                    response.data.data = JSON.parse(Crypt.decrypt(response.data.data))
                    response.data.status.code = 200
                }
            }
            return response
        },
        error => {
            Notification({
                title: '提示',
                type: 'warning',
                message: '服务器连接异常'
            })
            return Promise.reject(error)
        }
    )

    return service
}