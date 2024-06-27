<template>
      <div id="app">
            <Loading v-if="$root.loading"></Loading>
            <router-view></router-view>
      </div>
</template>

<script>


export default {
    name: 'App',
    created(){
        if(window.localStorage.getItem("resources")){
            sessionStorage.setItem("RefreshRouter", false);
        }
    }
}
</script>

<style>
*{
      margin: 0;
      padding: 0;
}
</style>
