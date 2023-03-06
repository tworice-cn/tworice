<template>
      <div class="app-body">

            <el-table v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
                  <!-- <el-table-column prop='id' label='编号'></el-table-column> -->
                  <el-table-column prop='date' label='报名日期' :formatter='formatDate'></el-table-column>
                  <el-table-column prop='adminId' label='用户编号'></el-table-column>
                  <el-table-column prop='nickName' label='用户姓名'></el-table-column>
                  <!-- <el-table-column prop='contest' label='活动ID'></el-table-column> -->
                  <el-table-column prop='status' label='状态'>
                        <template slot-scope="scope">
                              <el-tag>{{scope.row.status==1?'报名成功':'报名失败'}}</el-tag>
                        </template>
                  </el-table-column>
                  <el-table-column label="操作"> <template slot-scope="scope">
                              <!-- <el-button size="mini" type="warning" icon="el-icon-edit" circle @click.native="edit(scope.row)"></el-button> -->
                              <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button>
                        </template> </el-table-column>
            </el-table>
            <el-col :span="24">
                  <div class="page-box">
                        <el-pagination :hide-on-single-page="true" @current-change="changePage" background layout="prev, pager, next" :total="total" :page-size="pageSize"></el-pagination>
                  </div>
            </el-col> <!-- 弹出层 -->
            <el-dialog :title="formTitle" :visible.sync="formVisible" width="30%" :before-close="handleClose">
                  <el-form :model="form" :rules="rules" ref="form">
                        <el-form-item label='用户ID' :label-width='formLabelWidth' prop='adminId'>
                              <el-input placeholder='请输入用户ID' v-model='form.adminId' @change='isChange = true'></el-input>
                        </el-form-item>
                        <el-form-item label='活动ID' :label-width='formLabelWidth' prop='contest'>
                              <el-input placeholder='请输入活动ID' v-model='form.contest' @change='isChange = true'></el-input>
                        </el-form-item>
                        <el-form-item label='状态' :label-width='formLabelWidth' prop='status'>
                              <el-input placeholder='请输入状态' v-model='form.status' @change='isChange = true'></el-input>
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="formVisible=false">取 消</el-button>
                        <el-button type="primary" @click="submit">确 定</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="30%" :before-close="handleClose">
                  <el-form size="mini">
                        <el-form-item label="选择表格" :label-width="formLabelWidth"> <input type="file" class="file-left-input" @change="inductsChange()" ref="inducts" multiple accept=".xls,.xlsx" /> </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="inductsVisible=false">取 消</el-button>
                  </div>
            </el-dialog>
      </div>
</template><script>
export default {
      props: [],
      data() {
            return {
                  loading: true,
                  page: 0,
                  pageSize: 10,
                  total: 0,
                  tableData: [],
                  formTitle: "",
                  formVisible: false,
                  inductsVisible: false,
                  form: {
                        id: "",
                        date: "",
                        adminId: "",
                        contest: "",
                        status: "",
                  },
                  rules: {
                        id: [
                              {
                                    required: true,
                                    message: "请输入编号",
                                    trigger: "blur",
                              },
                        ],
                        date: [
                              {
                                    required: true,
                                    message: "请输入日期",
                                    trigger: "blur",
                              },
                        ],
                        adminId: [
                              {
                                    required: true,
                                    message: "请输入用户ID",
                                    trigger: "blur",
                              },
                        ],
                        contest: [
                              {
                                    required: true,
                                    message: "请输入活动ID",
                                    trigger: "blur",
                              },
                        ],
                        status: [
                              {
                                    required: true,
                                    message: "请输入状态",
                                    trigger: "blur",
                              },
                        ],
                  },
                  formLabelWidth: "80px",
                  /** 弹出框标签宽度*/ isChange: false,
                  search: { id: "", adminId: "", contest: "", status: "" },

            };
      },
      methods: {
            /**格式化日期 */ formatDate(row) {
                  
                  let date = new Date(row.date);
                  let month =
                        date.getMonth() + 1 < 10
                              ? "0" + (date.getMonth() + 1)
                              : date.getMonth() + 1;
                  let day =
                        date.getDate() < 10
                              ? "0" + date.getDate()
                              : date.getDate();
                  let hours =
                        date.getHours() < 10
                              ? "0" + date.getHours()
                              : date.getHours();
                  let minutes =
                        date.getMinutes() < 10
                              ? "0" + date.getMinutes()
                              : date.getMinutes();
                  return (
                        date.getFullYear() +
                        "-" +
                        month +
                        "-" +
                        day +
                        " " +
                        hours +
                        ":" +
                        minutes
                  );
            },
            init() {
                  this.toPage();
            },
            toPage() {
                  this.loading = true;
                  this.search.contest=this.$route.params.contest;
                  let param = "";
                  Object.keys(this.search).map((key) => {
                        if (
                              this.search[key] != undefined &&
                              this.search[key] != ""
                        ) {
                              param += "&" + key + "=" + this.search[key];
                        }
                  });
                  this.$axios
                        .get(
                              this.$url +
                                    "/client/enlists/list?page=" +
                                    this.page +
                                    "&pageSize=" +
                                    this.pageSize +
                                    param
                        )
                        .then((response) => {
                              this.tableData = response.data.data.list;
                              this.total = response.data.data.total;
                              this.loading = false;
                        });
            },
            /**监听页码发生变化 */ changePage(e) {
                  this.page = e - 1;
                  this.toPage();
            },
            add() {
                  this.form = this.$options.data().form;
                  this.formTitle = "新增";
                  this.formVisible = true;
            },
            handleClose(done) {
                  this.$confirm("确认关闭？").then(() => {
                        done();
                  });
            },
            submit() {
                  this.$root.loading = true;
                  let formData = new FormData();
                  Object.keys(this.form).map((key) => {
                        if (
                              this.form[key] != undefined &&
                              this.form[key] != ""
                        ) {
                              formData.append(key, this.form[key]);
                        }
                  });
                  this.$axios({
                        method: "POST",
                        url: this.$url + "/client/enlists/add",
                        data: formData,
                  }).then(() => {
                        this.toPage();
                        this.formVisible = false;
                        this.$root.loading = false;
                        this.$message({ type: "success", message: "操作成功" });
                  });
            },
            edit(row) {
                  this.form = row;
                  this.formTitle = "编辑";
                  this.formVisible = true;
            },
            del(row) {
                  this.$confirm("此操作将永久删除该信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.$root.loading = true;
                        let format = new FormData();
                        format.append("ids", row.id);
                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + "/client/enlists/del",
                        }).then(() => {
                              this.toPage();
                              this.$root.loading = false;
                              this.$message({
                                    type: "success",
                                    message: "删除成功",
                              });
                        });
                  });
            },
            /**点击批量导入 */ inducts() {
                  this.inductsVisible = true;
            },
            /**选择批量 */ inductsChange() {
                  let files = this.$refs.inducts.files;
                  /*获取选择的文件*/ let len = files.length;
                  /*文件个数*/ if (len != 1) {
                        this.$message({
                              message: "需要且只能上传一个文件",
                              type: "warning",
                        });
                        return;
                  }
                  let formData = new FormData();
                  formData.append("file", files[0]);
                  this.$axios({
                        method: "post",
                        url: this.$url + "/client/enlists/inducts",
                        data: formData,
                        headers: { "Content-Type": "multipart/form-data" },
                  })
                        .then((res) => {
                              /*上传成功后是否需要将选择的文件滞空*/ this.$refs.inducts.value =
                                    null;
                              if (res.data.status.code == 200) {
                                    this.$message({
                                          message: res.data.status.message,
                                          type: "success",
                                    });
                                    this.inductsVisible = false;
                                    this.toPage();
                              } else {
                                    this.$message({
                                          message: res.data.status.message,
                                          type: "error",
                                    });
                              }
                        })
                        .catch(() => {
                              this.$refs.inducts.value = null;
                              this.$message({
                                    message: "上传失败，请检查文件合法性！",
                                    type: "error",
                              });
                        });
            },
      },
      mounted() {
            this.init();
      },
};
</script><style lang="less"></style>