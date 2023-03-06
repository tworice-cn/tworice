<template>
      <div>
            {{goods}}
      </div>
</template>

<script>
export default {
      name: "",
      props: [],
      data() {
            return {
                  goods:''
            };
      },
      methods: {},
      mounted() {
            this.goods=this.$route.params.id;
      },
};
</script>

<style scoped>
</style>