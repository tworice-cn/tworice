import BreadCrumb from "@/components/commons/BreadCrumb.vue";
import Menu from "@/components/commons/menu.vue";
import PortalMenu from "@/components/commons/portalMenu.vue";
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
                e += '/'+JSON.parse(window.localStorage.getItem('admin')).id;
                this.$router.push(e);
                window.location.reload();
            }else{
                this.handleSelect(e);
                e += '/'+JSON.parse(window.localStorage.getItem('admin')).id;

                this.$router.push(e);
            }
        },
        /**初始化侧栏资源 */
        initResources(){
            this.resources=JSON.parse(window.localStorage.getItem('resources')||[]);
            this.handleSelect(this.$route.path);
        },
        // 初始化系统
        systemInit(){
            this.$root.loading=true;
            this.initInterface();
            /**是否需要登录才能访问 */
            if(this.$setting.needLogin){
                // 需要的话判断当前用户的登录状态
                this.$axios.get(this.$url+'admin/index/').then(
                    ()=>{
                        // 初始化登录状态
                        this.loginStatus=true;
                        // 初始化菜单
                        this.initResources();
                        // 停止加载
                        this.$root.loading=false;
                    }
                )
            }else{
                // 初始化资源
                this.initResources();
                // 当前用户没有角色设置角色为游客
                if(window.localStorage.getItem('roles')==null||window.localStorage.getItem('roles')==undefined){
                    this.roles=[{id:0,roleName:'游客'}];
                    // 设置登录状态为未登录
                    this.loginStatus=false;
                    this.asideStatus=true;
                }else{
                    this.loginStatus=true;
                    this.roles=JSON.parse(window.localStorage.getItem('roles'));
                }
                this.$root.loading=false;
            }
            /**如果当前页是根路径 那么跳转默认的Tab */
            if(this.$route.path=='/admin'){
                if(this.$setting.defaultTab!=null && this.$setting.defaultTab!=undefined && this.$setting.defaultTab!=''){
                    this.handleSelect(this.$setting.defaultTab);
                    this.$router.push(this.$setting.defaultTab);
                }
            }

            if(window.localStorage.getItem('admin')!=null&&window.localStorage.getItem('admin')!=undefined){
                this.admin=JSON.parse(window.localStorage.getItem('admin'));
            }
        },
        // 初始化界面展示
        initInterface(){
            // 初始化角色
            let roles=window.localStorage.getItem('roles');
            if(roles==null||roles==undefined){
                this.roles=[];
                this.isAdmin=false
            }else{
                this.roles=JSON.parse(window.localStorage.getItem('roles'));
            }
            // 如果登录为用户则收起侧栏
            if(this.roles.length==0||this.roles[0].id==4){
                this.asideStatus=true;
            }else{
                this.isAdmin=true
            }
        },
        // 切换全屏展示
        switechFullScreen(){
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
            if(!this.isAdmin ||  e==null || e==undefined || e=='' || e=='/admin'){
                return;
            }

            this.editableTabsValue=e;
            let is=true;
            // 判断该标签是否已经存在
            this.editableTabs.forEach(item=>{
                if(item.name==e){
                    is=false;
                    return
                }
            })
            // 不存在则添加一个标签
            if(is){
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
                    if(item.children){
                        item.children.forEach(child=>{
                            if(child.url==e){
                                this.editableTabs.push({
                                    title: child.name,
                                    name:e
                                });
                                return;
                            }
                        })
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
                        let nextTab = tabs[admin + 1] || tabs[admin - 1];
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
        // if(this.$route.path!='/admin'){
        //       this.$router.push('/admin');
        // }

        this.systemInit();
    }
};