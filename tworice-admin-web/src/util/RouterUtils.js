// import router,{constantRoutes} from "@/core/router";
import router from "@/core/router";
import Layout from '@/views/admin/index.vue'

export default {
    addRoute: function (route) {
        // 递归设置下级路由
        let children = [];
        if (route.children) {
            route.children.forEach(item => {
                children.push(this.addRoute(item))
            })
        }

        let component = {};
        let path = route.path;
        // 处理页面模块位置
        if(route.type===1){
            component=Layout;
        }else{
            component = () => import(`@/${route.component}`);
        }
        // 处理路由path
        if(route.pid===0 && route.type === 1){ // 根路由
            path = '/' + route.path;
        }

        return {
            path: path,
            name: route.name,
            component:component,
            meta: {
                title: route.name,
            },
            children: children
        }
    },

    addSubRoute(newChildRoute,routerMap) {
        if(routerMap['/admin']){
            routerMap['/admin'].children.push(newChildRoute);
        }else{
            routerMap['/admin'] = {
                path: '/admin',
                name: '首页',
                component: Layout,
                children: [newChildRoute]
            }
        }
        router.addRoute(routerMap['/admin']);
    },

    addRoutes: function (routes) {
        return new Promise((resolve, reject) => {
            try {
                let routerMap = {};
                routes.forEach(item => {
                    let route = this.addRoute(item);
                    if (item.type === 2 && item.pid === 0) {
                        this.addSubRoute(route,routerMap);
                    }else{
                        router.addRoute(route);
                        routerMap[route.path] = route;
                    }
                });
                resolve(); // 所有路由添加完成后调用 resolve()
            } catch (error) {
                reject(error); // 如果发生错误调用 reject()
            }
        });
    },

    /**
     * 刷新页面后重新添加路由
     * @returns {Promise<unknown>}
     */
    refreshRouter: function (router,to) {
        return new Promise((resolve, reject) => {
            try {
                if(sessionStorage.getItem("RefreshRouter") && !JSON.parse(sessionStorage.getItem("RefreshRouter")) && window.localStorage.getItem("resources")){
                    sessionStorage.setItem("RefreshRouter", true);
                    this.addRoutes(JSON.parse(window.localStorage.getItem("resources"))).then(() => {
                        router.push(to);
                        resolve(); // 所有路由添加完成后调用 resolve()
                    })
                }else {
                    resolve();
                }
            } catch (error) {
                reject(error); // 如果发生错误调用 reject()
            }
        });

    },

}

