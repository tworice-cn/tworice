<template>
      <div>
            <el-menu-item class="logo-box">
                  <i>
                        <img src="favicon.ico" alt="" width="25px">
                  </i>
                  <span slot="title" class="system-title">{{$setting.systemName}}</span>
            </el-menu-item>
            <template v-for="item in menu">
                  <el-submenu v-if="item.type==1" :index="item.id + '' " :key="item.id">
                        <template slot="title">
                              <i :class="item.icon"></i>
                              <span>{{item.name}}</span>
                        </template>
                        <el-menu-item v-for="menuItem in item.list" :key="menuItem.id" :index="menuItem.url">
                              {{menuItem.name}}
                        </el-menu-item>
                  </el-submenu>
                  <el-menu-item v-if="item.type==2" :key="item.id" :index="item.url">
                        {{item.name}}
                  </el-menu-item>
            </template>
      </div>
</template>

<script>

export default {
      name: "PortalMenu",
      props: ["menu"],
      data() {
            return {};
      },
      methods: {},
};
</script>

<style lang="less" scoped>
// .el-menu{
//       text-align: center;
// }
</style>