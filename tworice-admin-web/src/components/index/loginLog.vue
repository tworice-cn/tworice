<template>
      <div class="log app-body">
            <!-- 条件查询 -->
            
            <!-- 数据表格 -->
            <el-table size="mini" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
                  <el-table-column type="index" label="序号"></el-table-column>
                  <el-table-column prop="createTime" label="时间" :formatter="(row)=>formatDate(row.createTime)"></el-table-column>
                  <el-table-column prop="loginName" label="登录账号"></el-table-column>
                  <el-table-column prop="ipAddr" label="登录IP"></el-table-column>
                  <el-table-column prop="status" label="登录结果" width="100">
                        <template slot-scope="scope">
                              <el-tag :type="scope.row.status==1?'':'danger'" size="mini">{{scope.row.status==1?'登录成功':'登录失败'}}</el-tag>
                        </template>
                  </el-table-column>
                  <el-table-column label="操作">
                        <template slot-scope="scope">
                              <el-button size="mini" type="info" icon="el-icon-view" circle @click.native="show(scope.row)"></el-button>
                              <!-- <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button> -->
                        </template>
                  </el-table-column>
            </el-table>
            <!-- 分页 -->
            <div class="page-box">
                  <el-pagination :hide-on-single-page="true" @current-change="changePage" background layout="prev, pager, next" :total="total" :page-size="15"></el-pagination>
            </div>
            <el-dialog title="查看" :visible.sync="showVisible" width="40%" :before-close="handleClose">
                  <el-descriptions :column="1" border>
                        <el-descriptions-item>
                              <template slot="label">
                                    时间
                              </template>
                              {{formatDate(form.createTime)}}
                        </el-descriptions-item>
                        <el-descriptions-item>
                              <template slot="label">
                                    登录账号
                              </template>
                              {{form.loginName}}
                        </el-descriptions-item>
                        <el-descriptions-item>
                              <template slot="label">
                                    登录IP
                              </template>
                              {{form.ipAddr}}
                        </el-descriptions-item>
                        <el-descriptions-item>
                              <template slot="label">
                                    登录结果
                              </template>
                              {{form.status==1?'登录成功':'登录失败'}}
                        </el-descriptions-item>
                        <el-descriptions-item>
                              <template slot="label">
                                    设备信息
                              </template>
                              {{form.active}}
                        </el-descriptions-item>
                  
                  </el-descriptions>
            </el-dialog>
      </div>
</template>

<script>
export default {
      props: [],
      data() {
            return {
                  tableData:[],
                  showVisible:false,
                  form:{createTime:'',loginName:'',ipAddr:'',status:'',active:''},
                  total:0,
                  pageSize:15,// 每页的数量
                  page:0,// 页码，从零开始
            }
      },
      methods:{
            show(row){
                  this.form=row;
                  this.showVisible=true;
            },
            /**格式化日期 */
            formatDate(time){
                  let date=new Date(time);
                  let month=(date.getMonth()+1)<10?'0'+(date.getMonth()+1):(date.getMonth()+1);
                  let day=date.getDate()<10?'0'+date.getDate():date.getDate();
                  let hours=date.getHours()<10?'0'+date.getHours():date.getHours();
                  let minutes=date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes();
                  return date.getFullYear()+'-'+month+'-'+day+' '+hours+':'+minutes;
            },
            del(row){
                  this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                  }).then(() => {
                        this.$root.loading=true;
                        let format=new FormData();
                        format.append("id",row.id);

                        this.$axios({
                              method:'DELETE',
                              data:format,
                              url:this.$url+"admin/log/delAdmin",
                        }).then(
                              response=>{
                                    this.tableData=response.data.data.logList;
                              }
                        )
                  })
            },
            /**页码变化 */
            changePage(e){
                  this.page=e-1;
                  this.toPage();
            },
            /**请求该页码的数据 */
            toPage(){
                  this.$axios.get(this.$url+'/admin/log/loginList?pageSize='+this.pageSize+'&page='+this.page).then(
                        response=>{
                              this.tableData=response.data.data.logList;
                              this.total=response.data.data.total;
                        }
                  )
            },
            init(){
                  this.toPage();
            },
            handleClose(done) {
                  this.$confirm("确认关闭？")
                        .then(() => {
                              done();
                        })
                        .catch(() => {});
            },
      },
      mounted(){
            this.init();
      }
};
</script>

<style lang="less">
.el-descriptions-item__label{
      min-width: 100px;
}
</style>