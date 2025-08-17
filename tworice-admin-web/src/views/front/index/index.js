import BreadCrumb from "@/components/commons/BreadCrumb.vue";
import Menu from "@/components/commons/menu/Menu.vue";
import PortalMenu from "@/components/commons/menu/PortalMenu.vue";
import system from "@/components/commons/system/system.js";
import log from "@/views/admin/log.vue";

export default {
    props: [],
    components:{
        BreadCrumb,
        Menu,
        PortalMenu
    },
    data() {
        return {
            isAdmin:false, // 管理界面状态
            asideStatus:false,// 侧栏状态
            isFullScreen:false,// 全屏状态
            loginStatus:false,//登录状态
            otherResources:{'/admin/userCenter':'用户中心','/admin/home':'首页'},
            resources:[],
            admin:{nickName:''},// 管理员信息
            editableTabs: [],// 全部标签
            editableTabsValue:'',// 当前选中标签
            routerShow:true,// 是否渲染子路由
            roles:[], // 当前用户角色
            system  // 系统相关操作
        }
    },
    methods:{
        /* 跳转用户中心 */
        showUser(e){
            if(e==this.$route.path.substring(0,17)){
                this.handleSelect(e);
                e += '/'+this.$utils.getLoginUserID();
                this.$router.push(e);
                window.location.reload();
            }else{
                this.handleSelect(e);
                e += '/'+this.$utils.getLoginUserID();

                this.$router.push(e);
            }
        },
        /**初始化侧栏资源 */
        initResources(){
            this.resources=window.localStorage.getItem('resources')?JSON.parse(window.localStorage.getItem('resources')):[];
            this.handleSelect(this.$route.path);
        },
        // 初始化系统
        systemInit(){
            this.$root.loading=true;
            // 初始化界面
            this.initInterface();
            /**是否需要登录才能访问 */
            if(this.$setting.needLogin){
                // 需要的话判断当前用户的登录状态
                this.$axios.get(this.$url+'admin/index/').then(
                    ()=>{
                        // 初始化菜单
                        this.initResources();
                        this.$root.loading=false;
                    }
                )
            }else {
                // 初始化资源
                this.initResources();
            }
            /**
             * 如果当前页是根路径 那么跳转默认的Tab
             * */
            if(this.$route.path==='/admin' && this.$setting.defaultTab){
                this.handleSelect(this.$setting.defaultTab);
                this.$router.push(this.$setting.defaultTab);
            }
            this.$root.loading = false;
        },
        /**
         * 界面初始化
         */
        initInterface(){
            // 初始化角色
            let roles=window.localStorage.getItem('roles');
            if(!roles){ // 当前为游客
                this.roles = [{id: 0, roleName: '游客'}];
                this.isAdmin=false; // 是否管理员状态
                this.loginStatus = false; // 登录状态
                this.asideStatus = true; // 侧边栏收回状态
            }else{ // 当前非游客
                this.roles=JSON.parse(roles);
                if(this.roles[0].id !== 4){
                    this.isAdmin = true;} // 是否管理员状态
                this.loginStatus = true; // 登录状态
                if (window.localStorage.getItem('admin')) {
                    this.admin = JSON.parse(window.localStorage.getItem('admin'));
                }
            }
        },
        // 切换全屏展示
        switchFullScreen(){
            if(this.isFullScreen){
                this.$screenfull.exitScreenFull();

            }else{
                this.$screenfull.requestScreenFull();
            }
            this.isFullScreen=!this.isFullScreen
        },
        /**修改密码 */
        editPwd(){
            system.editPwd(this);
        },
        // 安全退出系统
        exitSystem(){
            system.exitSystem(this);
        },
        /**切换菜单 */
        handleSelect(e){
            if (!this.isAdmin || !e || e === '/admin') {
                return;
            }

            this.editableTabsValue = e;

            // 判断该标签是否已经存在
            const tabExists = this.editableTabs.some(item => item.name === e);

            // 如果标签不存在则添加
            if (!tabExists) {
                this.addTab(e);
            }
        },
        /**添加标签 */
        addTab(e){
            // 判断是否为首页（首页不在资源列表中，所以需要专门判断）
            if(e in this.otherResources){
                this.editableTabs.push({
                    title: this.otherResources[e],
                    name:e
                });
            }else{
                // 在资源列表中寻找该资源
                this.resources.forEach(item=>{
                    if (item.children && item.children.length !== 0) {
                        item.children.forEach(child => {
                            if (child.url === e) {
                                this.editableTabs.push({
                                    title: child.name,
                                    name: e
                                });
                            }
                        });
                    } else if (item.url === e) {
                        this.editableTabs.push({
                            title: item.name,
                            name: e
                        });
                    }
                })
            }
        },
        /**删除当前标签 */
        removeTab(targetName) {
            let tabs = this.editableTabs;
            let activeName = this.editableTabsValue;
            if (activeName === targetName) {
                tabs.forEach((tab, index) => {
                    if (tab.name === targetName) {
                        let nextTab = tabs[index + 1] || tabs[index - 1];
                        if (nextTab) {
                            activeName = nextTab.name;
                            this.clickTab(nextTab)
                        }
                    }
                });

            }
            this.editableTabsValue = activeName;
            this.editableTabs = tabs.filter(tab => tab.name !== targetName);
            if(this.editableTabs.length==0){
                this.$router.push('/admin')
            }
        },
        /**选中标签 */
        clickTab(e){
            if(this.$route.path!=e.name){
                this.$router.push(e.name);
            }
        },
        /**刷新子路由 */
        refresh(){
            this.routerShow=false;
            this.$nextTick(()=>{
                this.routerShow=true
            })
        }
    },
    mounted(){
        this.systemInit();
    }
};