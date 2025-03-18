<template>
    <div class="app-body">
        <el-col :span="24" class="home-top">
            <el-col :span="24" class="back">
                <el-page-header @back="$router.go(-1)" content="公告详情" class="back"></el-page-header>
            </el-col>
        </el-col>
        <el-col :span="24" class="info-box">
            <el-col :md="5" :xs="1" class="min-height"></el-col>
            <el-col :md="14" :xs="22">
                <el-col :span="24" class="menu-notice-header">
                    <el-col :span="24" class="menu-notice-title">
                        {{info.title}}
                    </el-col>
                    <el-col :span="24" class="menu-notice-info">
                        发布时间：{{$utils.formatDate(info.createTime)}} &nbsp;&nbsp;&nbsp;&nbsp;
                        来源：{{info.adminName==undefined?(info.nickName==undefined?info.author:info.nickName):info.adminName}}
                    </el-col>
                </el-col>
                <el-col :span="24" v-html="info.content" class="menu-notice-content"></el-col>
            </el-col>
            <el-col :md="5" :xs="1" class="min-height"></el-col>
        </el-col>
    </div>
</template>

<script>
export default {
    props: [],
    data() {
        return {
            info:{},
            title:''
        }
    },
    methods:{
    
    },
    mounted() {
        this.$axios.get(this.$url +"admin/notice/info?id="+this.$route.query.id)
            .then(response => {
                this.info = response.data.data.info;
            })
    },
};
</script>

<style lang="less" scoped>
.info-box{
    padding: 50px;
}
.menu-notice-header{
    text-align: center;
    border-bottom: 1px dashed #D6D6D6;
    
    
    .menu-notice-title{
        font-weight: 700;
        font-size: 28px;
        line-height: 100px;
    }
    .menu-notice-info{
        font-size: 14px;
        line-height: 50px;
    }
    
}
.menu-notice-content{
    padding-top: 50px;
    line-height: 40px;
    font-size: 16px;
    letter-spacing: 1.5px;
    text-indent: 2rem;
}
@media screen and (max-width: 1200px) {
    .info-box{
        padding: 0;
    }
}
</style>