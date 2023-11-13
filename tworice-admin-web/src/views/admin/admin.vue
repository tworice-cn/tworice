<template>
      <div class="app-body">
            <el-col :span="24" class="info-search-box">
                  <div class="search">
                        <div class='search-item'>人员ID :
                              <el-input size='mini' v-model='search.id' placeholder='请输入人员ID' clearable></el-input>
                        </div>
                        <div class='search-item'>
                              人员账号 :
                              <el-input size='mini' v-model='search.loginName' placeholder='请输入人员账号' clearable></el-input>
                        </div>
                        <div class="search-item">
                              <el-button size="mini" type="primary" @click="toPage">查询</el-button>
                        </div>
                  </div>
            </el-col>
            <el-col :span="24" class="button-box">
                  <el-button type="primary" icon="el-icon-plus" size="mini" @click="add">新增</el-button>
                  <el-button type="danger" icon="el-icon-delete" size="mini" @click="delList">批量删除</el-button>
                  <el-button type="warning" icon="el-icon-upload" size="mini" @click="inducts">批量导入</el-button>
            </el-col>
            <el-table @selection-change="handleSelectionChange" size="mini" v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
                  <el-table-column type="selection" width="55"></el-table-column>
                  <el-table-column type="index" label="序号"></el-table-column>
                  <el-table-column prop="id" label="编号"></el-table-column>
                  <el-table-column prop="nickName" label="姓名"></el-table-column>
                  <el-table-column prop="loginName" label="登录账号"></el-table-column>
                  <el-table-column prop="status" label="状态" width="80">
                        <template slot-scope="scope">
                              {{scope.row.status==-1?'禁用':'正常'}}
                        </template>
                  </el-table-column>
                  <el-table-column label="操作">
                        <template slot-scope="scope">
                              <el-tooltip content="用户信息">
                                    <el-button size="mini" type="info" icon="el-icon-view" circle @click.native="show(scope.row)"></el-button>
                              </el-tooltip>
                              <el-tooltip content="编辑">
                                    <el-button size="mini" type="warning" icon="el-icon-edit" circle @click.native="edit(scope.row)"></el-button>
                              </el-tooltip>
                              <el-tooltip content="重置密码">
                                    <el-button size="mini" type="primary" icon="el-icon-refresh" circle @click.native="rePassWord(scope.row)"></el-button>
                              </el-tooltip>
                              <el-tooltip content="删除">
                                    <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button>
                              </el-tooltip>
                        </template>
                  </el-table-column>
            </el-table>
            <div class="page-box">
                  <el-pagination :hide-on-single-page="true" @current-change="changePage" background layout="prev, pager, next" :total="total" :page-size="pageSize"></el-pagination>
            </div>

            <!-- 弹出层 -->
            <el-dialog :title="formTitle" :visible.sync="formVisible" width="40%" :before-close="$utils.handleClose">
                  <el-form :model="form" size="mini" :rules="rules" ref="form">
                        <el-form-item label="用户名称" :label-width="formLabelWidth" prop="nickName">
                              <el-input placeholder="请输入内容" v-model="form.nickName" @change="isChange = true" :disabled="showAdmin"></el-input>
                        </el-form-item>
                        <el-form-item label="登录账号" :label-width="formLabelWidth" prop="loginName">
                              <el-input placeholder="请输入内容" v-model="form.loginName" @change="isChange = true" :disabled="showAdmin"></el-input>
                        </el-form-item>
                        <el-form-item label="账号状态" :label-width="formLabelWidth">
                              <el-switch v-model="form.status" active-color="#13ce66" inactive-color="#ff4949" :active-value="1" :inactive-value="-1" :disabled="showAdmin"></el-switch>
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="formVisible=false">取 消</el-button>
                        <el-button type="primary" @click="submit" v-if="!showAdmin">确 定</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="查看" :visible.sync="showVisible" width="40%" :before-close="$utils.handleClose">
                  <el-button type="primary" size="small" @click="delInfo">初始化信息</el-button>
                  <Descriptions :value="descriptionsArr"></Descriptions>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click.native="showVisible=false">关 闭</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="40%" :before-close="$utils.handleClose">
                  <el-form size="mini">
                        <el-form-item label="选择表格" :label-width="formLabelWidth">
                              <input type="file" class="file-left-input" @change="inductsChange()" ref="inducts" multiple accept=".xls,.xlsx" />
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="inductsVisible=false">取 消</el-button>
                        <el-button type="primary" @click="templateDownload">下载模板</el-button>
                  </div>
            </el-dialog>
      </div>
</template>

<script>
import Descriptions from '@/components/commons/Descriptions.vue'
import {list} from '@/api/admin/admin'
export default {
      components:{
            Descriptions
      },
      props: [],
      data() {
            return {
                  showAdmin: false, // 当查看是设置为true
                  loading: true,
                  page: 1,
                  pageSize: 10,
                  total: 0,
                  tableData: [],
                  formTitle: "",
                  formVisible: false,
                  showVisible: false,
                  inductsVisible: false,
                  form: {
                        id: "",
                        nickName: "",
                        loginName: "",
                        passWord: "",
                        status: 1,
                  },
                  rules: {
                        nickName: [
                              {
                                    required: true,
                                    message: "请输入人员名称",
                                    trigger: "blur",
                              },
                        ],
                        loginName: [
                              {
                                    required: true,
                                    message: "请输入登录账号",
                                    trigger: "blur",
                              },
                        ],
                        passWord: [
                              {
                                    required: true,
                                    message: "请填写登录密码",
                                    trigger: "blur",
                              },
                        ],
                  },
                  formLabelWidth: "80px", // 弹出框标签宽度
                  isChange: false,
                  multipleSelection: [],
                  search: { id: "", loginName: "" },
                  pageUrlPath: "/admin/admin",
                  adminInfo: {
                        id:'',adminNote:'',contactAddress:'',homePlace:'',adminEmail:'',adminPhone:''
                  },
                  descriptionsArr:[]
            };
      },
      methods: {
            init() {
                  this.toPage();
            },
            toPage() {
                  list(this.$mergeJSON({page:this.page,pageSize:this.pageSize},this.search))
                        .then((response) => {
                              this.tableData = response.data.data.list;
                              this.total = response.data.data.total;
                              this.loading = false;
                        });
            },
            /**监听页码发生变化 */
            changePage(e) {
                  this.page = e;
                  this.toPage();
            },
            add() {
                  this.formVisible = true;
                  this.formTitle = "新增";
                  this.form = this.$options.data().form;
            },
            submit() {
                  this.loading = true;
                  let format = new FormData();
                  Object.keys(this.form).map((key) => {
                        if(this.form[key]){
                              format.append(key, this.form[key]);
                        }
                  });

                  this.$axios({
                        method: "post",
                        url: this.$url + this.pageUrlPath + "/add",
                        data: format,
                  }).then(() => {
                        this.toPage();
                        this.formVisible = false;
                        this.loading = false;
                  });
            },
            edit(row) {
                  this.form = row;
                  this.formTitle = "编辑";
                  this.formVisible = true;
                  this.showAdmin = false;
            },
            show(row) {
                  this.form=row;
                  this.$axios({
                        method: "get",
                        url: this.$url + "/admin/adminInfo/blurInfo/" + row.id,
                  }).then((res) => {
                        if(res.data.data.info){
                              this.adminInfo = res.data.data.info;
                        }else{
                              this.adminInfo=this.$options.data().adminInfo;
                        }
                        
                        let arrValue=[]
                        arrValue.push({icon:'el-icon-user',name:'用户名',value:this.form.nickName});
                        arrValue.push({icon:'el-icon-male',name:'性别',value:this.adminInfo.adminSex==1?'男':this.adminInfo.adminSex==0?'女':'未知'});
                        arrValue.push({icon:'el-icon-mobile-phone',name:'手机号',value:this.adminInfo.adminPhone});
                        arrValue.push({icon:'el-icon-message',name:'邮箱',value:this.adminInfo.adminEmail});
                        arrValue.push({icon:'el-icon-location-outline',name:'居住地',value:this.adminInfo.homePlace});
                        arrValue.push({icon:'el-icon-office-building',name:'联系地址',value:this.adminInfo.contactAddress});
                        arrValue.push({icon:'el-icon-tickets',name:'备注',value:this.adminInfo.adminNote});
                        this.descriptionsArr = arrValue;
                  });

                  this.showVisible = true;
            },
            delInfo(){
                  this.$confirm("此操作将永久清除个人信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        // 删除用户个人信息
                        let format = new FormData();
                        format.append("ids", this.adminInfo.id);
                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + "/admin/adminInfo/del",
                        }).then(() => {
                              this.adminInfo=this.$options.data().adminInfo;
                        });
                  });
            },
            del(row) {
                  this.$confirm("此操作将永久删除该信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.loading = true;
                        let format = new FormData();
                        format.append("ids", row.id);

                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + this.pageUrlPath + "/del",
                        }).then(() => {
                              this.toPage();
                              this.loading = false;
                        });
                  });
            },
            /**点击批量导入 */
            inducts() {
                  this.inductsVisible = true;
            },
            /**选择批量 */
            inductsChange() {
                  let files = this.$refs.inducts.files; // 获取选择的文件
                  let len = files.length; // 文件个数
                  if (len != 1) {
                        this.$msg({
                              message: "需要且只能上传一个文件",
                              type: "warning",
                        });
                        return;
                  }
                  let formData = new FormData();
                  formData.append("file", files[0]);
                  this.$axios({
                        method: "post",
                        url: this.$url + this.pageUrlPath + "/inducts",
                        data: formData,
                        headers: {
                              "Content-Type": "multipart/form-data",
                        },
                  }).then((res) => {
                              // 上传成功后是否需要将选择的文件滞空
                              this.$refs.inducts.value = null;
                              if (res.data.status.code == 200) {
                                    this.inductsVisible = false;
                                    this.toPage();
                              }
                        })
                        .catch(() => {
                              this.$refs.inducts.value = null;
                              this.$msg({
                                    message: "上传失败，请检查文件合法性！",
                                    type: "error",
                              });
                        });
            },
            /**下载表 */
            templateDownload() {
                  window.open(this.$url + this.pageUrlPath + "/template");
            },
            /**批量删除 */
            delList() {
                  this.$confirm("此操作将永久删除该信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.loading = true;
                        let format = new FormData();
                        this.multipleSelection.forEach((item) => {
                              format.append("ids", item.id);
                        });

                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + this.pageUrlPath + "/del",
                        }).then(() => {
                              this.toPage();
                              this.loading = false;
                        });
                  });
            },
            /**选择框 val为当前所有选择的内容数组 */
            handleSelectionChange(val) {
                  this.multipleSelection = val;
            },
            rePassWord(row){
              this.$confirm("重置账号密码, 是否继续?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
              }).then(() => {
                let format = new FormData();
                format.append("id",row.id);
                this.$axios({
                  method: "PUT",
                  data: format,
                  url: this.$url + this.pageUrlPath + "/rePassWord",
                }).then(res => {
                  this.loading = false;
                  if(res.data.status.code==200){
                    this.toPage();
                  }
                });
              })

            }
      },
      mounted() {
            this.init();
      },
};
</script>

<style lang="less">
</style>