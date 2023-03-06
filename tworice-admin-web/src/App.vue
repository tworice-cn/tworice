<template>
      <div id="app">
            <Loading v-if="this.$root.loading"></Loading>
            <router-view></router-view>
      </div>
</template>

<script>


export default {
      name: 'App',
      components: {
      },
      methods:{
            
      }
}
</script>

<style>
*{
      margin: 0;
      padding: 0;
}
</style>
