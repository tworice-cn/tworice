<template>
      <div>
            <el-button type="primary" @click.native="jump('/admin/home')">跳转主页</el-button>
      </div>
</template>

<script>
export default {
      data() {
            return {
                
            }
      },
      methods:{
            jump(e){
                  this.$emit('handleSelect',e);
                  this.$router.push(e);
            }
      }
};
</script>

<style lang="less">
      
</style>