<script>
export default {
  props: ['name'],
  methods: {
    goBack() {
      this.$router.go(-1);
    }
  }
}
</script>

<template>
  <el-page-header @back="goBack" :content="name" class="back-box"></el-page-header>
</template>

<style scoped lang="less">
.el-page-header {
  padding: 10px 10px;
}
</style>