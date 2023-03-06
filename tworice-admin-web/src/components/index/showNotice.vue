<template>
      <div>
            <el-col :span="24" class="home-top">
                  <el-col :span="24" class="back">
                        <el-page-header @back="$router.go(-1)" content="公告详情" class="back"></el-page-header>
                  </el-col>
            </el-col>
            <el-col :span="24" class="info-box">
                  <el-col :span="5" class="min-height"></el-col>
                  <el-col :span="14">
                        <el-col :span="24" class="menu-notice-header">
                              <el-col :span="24" class="menu-notice-title">
                                    {{info.title}}
                              </el-col>
                              <el-col :span="24" class="menu-notice-info">
                                    发布时间：{{formatDate(info.createTime)}} &nbsp;&nbsp;&nbsp;&nbsp;
                                    来源：{{info.adminName==undefined?(info.nickName==undefined?info.author:info.nickName):info.adminName}}
                              </el-col>
                        </el-col>
                        <el-col :span="24" v-html="info.content" class="menu-notice-content"></el-col>
                  </el-col> 
                  <el-col :span="5" class="min-height"></el-col>
            </el-col>

            <!-- <el-col :span="24" class="footer">
                  <el-col :span="6" class="min-height"></el-col>
                  <el-col :span="12" class="footer-p-box">
                        <p>主办单位：旅游信息网  &nbsp;&nbsp;&nbsp;&nbsp;  承办单位：旅游信息网办公室</p>
                        <p>
                              <a href="https://beian.miit.gov.cn/" target="_blank">
                              
                              备案号：ICP备2021006611号-1
                              </a>
                              &nbsp;&nbsp;
                              <img src="/img/tb.png"/>公网安备 14010002001529号</p>
                        <p>技术支持：0351-4222611  &nbsp;&nbsp;  网站访问量:16406428</p>
                        <p>网站标识码：1401000055</p>
                  </el-col>
                  <el-col :span="6" class="min-height"></el-col>
            </el-col> -->
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
            /**格式化日期 */ formatDate(time) {
                  let date = new Date(time);
                  let month =
                        date.getMonth() + 1 < 10
                              ? "0" + (date.getMonth() + 1)
                              : date.getMonth() + 1;
                  let day =
                        date.getDate() < 10
                              ? "0" + date.getDate()
                              : date.getDate();
                  return (
                        date.getFullYear() +
                        "-" +
                        month +
                        "-" +
                        day
                  );
            },
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
</style>