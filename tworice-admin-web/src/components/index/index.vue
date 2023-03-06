<template>
      <div>
            <el-container class="index-main">
                  <!-- 左侧导航 -->
                  <el-aside v-if="isAdmin" class="index-aside" :class="asideStatus?'fold':'unfold'" :width="asideStatus?'64px':'200px'">
                        <el-menu :collapse-transition="false" @select="handleSelect" :unique-opened="true" :collapse="asideStatus" :default-active="$route.path" class="el-menu-vertical-demo" :router="true" ref="menu">
                              <el-menu-item class="logo-box">
                                    <i>
                                          <img src="/favicon.ico" alt="" width="25px">
                                    </i>
                                    <span slot="title" class="system-title">{{$setting.systemName}}</span>
                              </el-menu-item>

                              <el-menu-item index="/admin/home">
                                    <i class="el-icon-s-home"></i>
                                    <span slot="title">我的首页</span>
                              </el-menu-item>
                              <Menu :menuList="resources"></Menu>
                        </el-menu>
                  </el-aside>
                  <el-container>
                        <el-header v-if="isAdmin" class="index-header" height="91px">
                              <div class="index-header-box">
                                    <div class="header-left">
                                          <i @click="switchAside" :class="asideStatus?'el-icon-s-unfold':'el-icon-s-fold'"></i>
                                          <div class="zhan"></div>
                                          <!-- 面包屑 -->
                                          <BreadCrumb class="breadCrumb" v-on:handleSelect="handleSelect"/>
                                    </div>
                                    <div class="header-right">
                                          <!-- 刷新图标 -->
                                          <el-tooltip class="item" effect="dark" content="刷新" placement="bottom" popper-class="icon-tip">
                                                <i class="el-icon-refresh" @click="refresh"></i>
                                          </el-tooltip>
                                          <div class="zhan"></div>
                                          <!-- 刷新图标 -->
                                          <el-tooltip class="item" effect="dark" :content="isfullScreen?'退出全屏':'全屏'" placement="bottom">
                                                <i class="iconfont" :class="isfullScreen?'icon-suoxiao':'icon-quanping'" @click="switechFullScreen"></i>
                                          </el-tooltip>
                                          <div class="zhan"></div>
                                          <el-tag effect="dark" type="success" size="mini" class="role-box">{{roles.length==0?'0':roles[0].roleName}}</el-tag>
                                          <div class="zhan role-box"></div>
                                          <span>
                                                <el-tag class="username-box">
                                                      <el-dropdown placement="bottom" trigger="click" class="username-drop-down">
                                                            <i class="el-icon-arrow-down"></i>
                                                            <el-dropdown-menu slot="dropdown">
                                                                  <el-dropdown-item v-if="status" icon="el-icon-user" @click.native="showUser('/admin/userCenter')">个人中心</el-dropdown-item>
                                                                  <el-dropdown-item v-if="status" icon="el-icon-edit" @click.native="editPwd">修改密码</el-dropdown-item>
                                                                  <el-dropdown-item icon="el-icon-switch-button" :divided="status" @click.native="exitSystem">{{status?'安全退出':'登 录'}}</el-dropdown-item>
                                                            </el-dropdown-menu>
                                                      </el-dropdown>
                                                      {{status?admin.nickName:'未登录'}}
                                                </el-tag>
                                          </span>
                                    </div>
                              </div>
                              <!-- 标签 -->
                              <div class="tabs-box">
                                    <el-tabs v-model="editableTabsValue" type="card" closable @tab-remove="removeTab" @tab-click="clickTab">
                                          <el-tab-pane v-for="(item) in editableTabs" :key="item.name" :label="item.title" :name="item.name">
                                                {{item.content}}
                                          </el-tab-pane>
                                    </el-tabs>
                              </div>
                        </el-header>
                        <!--用户-->
                        <el-header v-else class="index-header portal-header" height="60px">
                              <el-menu mode="horizontal" @select="handleSelect"  :default-active="$route.path" :router="true">
                                    <PortalMenu :menu="resources" class="portal-menu"></PortalMenu>
                              </el-menu>
                              <div class="portal-avatar">
                                    <el-tag class="username-box">
                                          <el-dropdown placement="bottom" trigger="click" class="username-drop-down">
                                                <i class="el-icon-arrow-down"></i>
                                                <el-dropdown-menu slot="dropdown">
                                                      <el-dropdown-item v-if="status" icon="el-icon-user" @click.native="showUser('/admin/userCenter')">个人中心</el-dropdown-item>
                                                      <el-dropdown-item v-if="status" icon="el-icon-edit" @click.native="editPwd">修改密码</el-dropdown-item>
                                                      <el-dropdown-item icon="el-icon-switch-button" :divided="status" @click.native="exitSystem">{{status?'安全退出':'登 录'}}</el-dropdown-item>
                                                </el-dropdown-menu>
                                          </el-dropdown>
                                          {{status?admin.nickName:'未登录'}}
                                    </el-tag>
                              </div>
                        </el-header>
                        <el-main :class="isAdmin?'index-body':''">
                              <transition name="el-fade-in" v-if="routerShow">
                                    <router-view v-show="routerShow" v-on:handleSelect="handleSelect"></router-view>
                              </transition>
                              <el-col :span="24" v-else>欢迎使用二饭管理系统</el-col>
                        </el-main>
                  </el-container>
            </el-container>
      </div>
</template>








<script>
import BreadCrumb from '../commons/BreadCrumb.vue'
import Menu from '../commons/menu.vue'
import PortalMenu from '../commons/portalMenu.vue'
// import screenfull from 'screenfull'
export default {
      props: [],
      components:{
            BreadCrumb,
            Menu,
            PortalMenu
      },
      data() {
            return {
                  isAdmin:false, // 是否为管理员
                  otherResources:{'/admin/userCenter':'用户中心','/admin/home':'首页'},
                  resources:[],
                  asideStatus:false,// 侧栏状态
                  admin:{nickName:''},// 管理员信息
                  isfullScreen:false,// 全屏状态
                  editableTabs: [],// 全部标签
                  editableTabsValue:'',// 当前选中标签
                  routerShow:true,// 是否渲染子路由
                  roles:[],
                  status:false,//登录状态
            }
      },
      methods:{
            /* 跳转用户中心 */
            showUser(e){
                  e += '/'+JSON.parse(window.sessionStorage.getItem('admin')).id;
                  this.handleSelect(e);
                  this.$router.push(e);
            },
            // 切换侧边菜单状态
            switchAside(){
                  this.asideStatus=!this.asideStatus;
            },
            /**初始化侧栏资源 */
            initResources(){
                  this.resources=JSON.parse(window.sessionStorage.getItem('resources'));
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
                                    this.status=true;
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
                        if(window.sessionStorage.getItem('roles')==null||window.sessionStorage.getItem('roles')==undefined){
                              this.roles=[{id:0,roleName:'游客'}];
                              // 设置登录状态为未登录
                              this.status=false;
                              this.asideStatus=true;
                        }else{
                              this.status=true;
                              this.roles=JSON.parse(window.sessionStorage.getItem('roles'));
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
                  
                  if(window.sessionStorage.getItem('admin')!=null&&window.sessionStorage.getItem('admin')!=undefined){
                        this.admin=JSON.parse(window.sessionStorage.getItem('admin'));
                  }
            },
            // 初始化界面展示
            initInterface(){
                  // 初始化角色
                  let roles=window.sessionStorage.getItem('roles');
                  if(roles==null||roles==undefined){
                        this.roles=[];
                        this.isAdmin=false
                  }else{
                        this.roles=JSON.parse(window.sessionStorage.getItem('roles'));
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
                  if(this.isfullScreen){
                        this.$screenfull.exitScreenFull();
                        
                  }else{
                        this.$screenfull.requestScreenFull();
                  }
                  this.isfullScreen=!this.isfullScreen
            },
            /**修改密码 */
            editPwd(){
                  this.$prompt('请输入新密码', '修改密码', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        inputPattern: /^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/,
                        inputErrorMessage: '密码应6~10位的数字+字母、字母+特殊字符、特殊字符+数字'
                  }).then(({ value }) => {
                        let passwordExd=/^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$/
                        if(!passwordExd.test(value)){
                              this.$message({
                                    type:'warning',
                                    message:'密码应6~10位的数字+字母、字母+特殊字符、特殊字符+数字'
                              })
                              return;
                        }
                        let formData=new FormData();
                        formData.append("id",this.admin.id);
                        formData.append("passWord",value);
                        this.$axios({
                              url:this.$url+'admin/admin/update',
                              method:'PUT',
                              data:formData
                        }).then(
                              res=>{
                                    if(res.data.status.code==200){
                                          window.sessionStorage.clear();
                                          this.$confirm('密码已更新，请立即重新登录!', '提示', {
                                                confirmButtonText: '确定',
                                                showCancelButton:false,
                                                type: 'warning'
                                          }).then(() => {
                                                this.$router.push('/login');
                                          }).catch(() => {
                                                this.$message({
                                                      type:'error',
                                                      message:'密码更新失败'
                                                })       
                                          });
                                    }
                              }
                        )
                  })
            },
            // 安全退出系统
            exitSystem(){
                  let formData=new FormData();
                  let admin=JSON.parse(window.sessionStorage.getItem('admin'))||null;
                  if(admin!=null){
                        formData.append('key',admin.id);
                        this.$axios({
                              url:this.$url+'/admin/system/offline',
                              method:'DELETE',
                              data:formData
                        });
                  }
                  window.sessionStorage.clear();
                  this.$router.push('/login')
                  this.$message({
                        type: 'success',
                        message: '安全退出'
                  });
                  
            },
            /**切换菜单 */
            handleSelect(e){
                  if(e==null || e==undefined || e=='' || e=='/admin'){
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
                              item.list.forEach(child=>{
                                    if(child.url==e){
                                          this.editableTabs.push({
                                                title: child.name,
                                                name:e
                                          });
                                          return;
                                    }
                              })
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
            // if(this.$route.path!='/admin'){
            //       this.$router.push('/admin');
            // }
            
            this.systemInit();
      }
};
</script>