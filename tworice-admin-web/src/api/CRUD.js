import Vue from 'vue';

export default class CRUD {

    /**
     * 查询数据
     * @param pageUrlPath 服务前缀，如：/admin/dist
     * @param page 页码，默认为1
     * @param pageSize 页容量，默认为10
     * @param search 查询条件，如{id:1}
     * @returns {AxiosPromise}
     */
    static list(pageUrlPath, page = 0, pageSize = 10, search = {}) {
        return Vue.prototype.$axios({
            url: pageUrlPath + '/list',
            method: 'get',
            params: Vue.prototype.$utils.mergeJSON({page: page, pageSize: pageSize}, search)
        })
    }

    /**
     * 增加数据或更新数据，取决于参数中的id是否为空
     * @param pageUrlPath 服务前缀，如：/admin/dist
     * @param params 请求参数，如：{name:‘测试’}
     * @returns {AxiosPromise}
     */
    static submit(pageUrlPath, params) {
        return Vue.prototype.$axios({
            url: pageUrlPath + '/add',
            method: 'post',
            params: params
        })
    }

    /**
     * 删除数据
     * @param pageUrlPath 服务前缀，如：/admin/dist
     * @param params 请求参数，如：{ids:1}
     * @returns {AxiosPromise}
     */
    static del(pageUrlPath, params) {
        return Vue.prototype.$axios({
            url: pageUrlPath + '/del',
            method: 'DELETE',
            params: params
        })
    }


}