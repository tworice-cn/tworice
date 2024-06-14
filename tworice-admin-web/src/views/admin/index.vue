<template>
      <div>
            <el-container class="index-main">
                  <!-- 左侧导航 -->
                  <el-aside v-if="isAdmin" class="index-aside" :class="asideStatus?'fold':'unfold'" :width="asideStatus?'64px':'200px'">
                        <el-menu :collapse-transition="false" @select="handleSelect" :unique-opened="true" :collapse="asideStatus" :default-active="$route.path" class="el-menu-vertical-demo" :router="true" ref="menu">
                              <el-menu-item class="logo-box">
                                    <i>
                                          <img src="/favicon.ico" alt="">
                                    </i>
                                    <span slot="title" class="system-title">{{$setting.systemName}}</span>
                              </el-menu-item>
                              <Menu :menuList="resources" :asideStatus="asideStatus"></Menu>
                        </el-menu>
                  </el-aside>
                  <el-container>
                        <el-header v-if="isAdmin" class="index-header" height="91px">
                              <div class="index-header-box">
                                    <div class="header-left">
                                          <i @click="asideStatus=!asideStatus" :class="asideStatus?'el-icon-s-unfold':'el-icon-s-fold'"></i>
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
                                          <el-tooltip class="item" effect="dark" :content="isFullScreen?'退出全屏':'全屏'" placement="bottom">
                                            <i class="iconfont" :class="isFullScreen?'icon-suoxiao':'icon-quanping'" @click="switchFullScreen"></i>
                                          </el-tooltip>
                                          <div class="zhan"></div>
                                          <el-tag effect="dark" type="success" size="mini" class="role-box">{{roles.length==0?'0':roles[0].roleName}}</el-tag>
                                          <div class="zhan role-box"></div>
                                          <span>
                                                <el-tag class="username-box">
                                                      <el-dropdown placement="bottom" trigger="click" class="username-drop-down">
                                                            <i class="el-icon-arrow-down"></i>
                                                            <el-dropdown-menu slot="dropdown">
                                                                  <el-dropdown-item v-if="loginStatus" icon="el-icon-user" @click.native="showUser('/admin/userCenter')">个人中心</el-dropdown-item>
                                                                  <el-dropdown-item v-if="loginStatus" icon="el-icon-edit" @click.native="editPwd">修改密码</el-dropdown-item>
                                                                  <el-dropdown-item icon="el-icon-switch-button" :divided="loginStatus" @click.native="exitSystem">{{ loginStatus ? '安全退出' : '登 录' }}</el-dropdown-item>
                                                            </el-dropdown-menu>
                                                      </el-dropdown>
                                                      {{ loginStatus ? admin.nickName : '未登录' }}
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
                                                      <el-dropdown-item v-if="loginStatus" icon="el-icon-user" @click.native="showUser('/admin/userCenter')">个人中心</el-dropdown-item>
                                                      <el-dropdown-item v-if="loginStatus" icon="el-icon-edit" @click.native="editPwd">修改密码</el-dropdown-item>
                                                      <el-dropdown-item icon="el-icon-switch-button" :divided="loginStatus" @click.native="exitSystem">{{ loginStatus ? '安全退出' : '登 录' }}</el-dropdown-item>
                                                </el-dropdown-menu>
                                          </el-dropdown>
                                      {{ loginStatus ? admin.nickName : '未登录' }}
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
export {default} from "@/views/front/index/index";
</script>