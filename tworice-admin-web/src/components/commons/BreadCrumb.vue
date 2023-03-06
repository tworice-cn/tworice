<!-- 面包屑组件 -->
<template>
    <div>
        <el-breadcrumb separator="/">
            <el-breadcrumb-item v-for="item in levelList" :key="item.path">
                {{item.name}}
            </el-breadcrumb-item>
        </el-breadcrumb>
    </div>
</template>

<script>
    export default {
        name: 'Navbar',
        data() {
            return {
                levelList: []
            }
        },
        // 监听
        watch: {
            $route() {
                this.getBreadcrumb()  //监听路由变化
            }
        },
        created(){
            this.getBreadcrumb()
        },
        methods:{
            getBreadcrumb() {
                let matched = this.$route.matched.filter(item => item.name)  //获取路由信息，并过滤保留路由名称信息存入数组
                this.levelList = matched
                this.jump(matched[matched.length-1].path);
            },
            jump(e){
                this.$emit('handleSelect',e);
            }
        }
    }
</script>