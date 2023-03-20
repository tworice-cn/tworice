<template>
      <div v-bind="$attrs">
            <template v-for="item in menuList">
                  <el-submenu v-if="item.type==1" :index="item.id + '' " :key="item.id">
                        <template slot="title">
                              <i :class="item.icon"></i>
                              <span v-if="!asideStatus">{{item.name}}</span>
                        </template>
                        <Menu :menuList="item.list"></Menu>
                  </el-submenu>
                  <el-menu-item v-if="item.type==2" :key="item.id" :index="item.url">
                        <i :class="item.icon"></i>
                        <span v-if="!asideStatus">{{item.name}}</span>
                  </el-menu-item>
            </template>
      </div>
</template>

<script>

export default {
      name: "Menu",
      props: {
            menuList:{
                  type:Array,
                  default(){
                        return []
                  }
            },
            asideStatus:{
                  type:Boolean,
                  default(){
                        return false
                  }
            }
      },
      data() {
            return {

            };
      },
      methods: {},
};
</script>

<style scoped>
</style>