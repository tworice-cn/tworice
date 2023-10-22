import request from '../request.js'

export function list(params){
    return request({
        url: '/admin/admin/list',
        method: 'get',
        params: params
    })
}