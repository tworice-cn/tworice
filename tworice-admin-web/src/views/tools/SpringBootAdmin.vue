<template>
      <div class="doc">
            <iframe :src="$url+'/applications'"></iframe>
      </div>
</template>

<script>
export default {
      props: [],
      data() {
            return {
                
            }
      },
};
</script>

<style lang="less">
.doc{
      height: 100%;
      width: 100%;
      iframe{
            padding: 0;
            margin: 0;
            border: none;
            width: 100%;
            height: 100%;
      }
}
      
</style>