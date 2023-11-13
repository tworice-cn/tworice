<template>
  <div>
    <el-container class="index-main">
      <el-header class="index-header portal-header" height="60px">
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
    </el-container>
  </div>
</template>

<script>
export {default} from "@/views/front/index/index";
</script>