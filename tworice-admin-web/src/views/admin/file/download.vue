<template>
    <div class="app-body">
    
    </div>
</template>

<script>

export default {
    props: [],
    data() {
        return {
        
        };
    },
    methods: {
        init() {
            this.$axios.get(this.$url + "/file/systemFile/info?id=" + this.$route.params.id).then(res=>{
                if(res.data.data.info.pwd){
                    this.inputPwd(res.data.data.info.pwd)
                }else{
                    this.download(this.$route.params.id);
                }
            })
        },
        inputPwd(pwd){
            var password = prompt("请输入访问密码：");
            if (pwd === password) {
                this.download(this.$route.params.id);
            } else {
                this.inputPwd(pwd);
            }
        },
        download(id){
            window.open(this.$url + "/file/systemFile/downloadLocal/" + id);
        }
    },
    mounted() {
        this.init();
    }
    
};
</script>

<style lang="less">
</style>