<template>
      <div class="app-body">


            <el-table size="mini" v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
                  <el-table-column prop='key' label='用户ID'></el-table-column>
                  <el-table-column prop='token' label='用户Token'></el-table-column>
                  <el-table-column label="操作"> <template slot-scope="scope">
                              <el-button size="mini" type="danger"  @click.native="del(scope.row)">立即下线</el-button>
                        </template> </el-table-column>
            </el-table>
            <el-col :span="24">
                  <div class="page-box">
                        <el-pagination :hide-on-single-page="true" @current-change="changePage" background layout="prev, pager, next" :total="total" :page-size="pageSize"></el-pagination>
                  </div>
            </el-col> <!-- 弹出层 -->
            <el-dialog :title="formTitle" :visible.sync="formVisible" width="30%" :before-close="$utils.handleClose">
                  <el-form :model="form" :rules="rules" ref="form">
                        <el-form-item label='用户Key' :label-width='formLabelWidth' prop='key'>
                              <el-input placeholder='请输入用户Key' v-model='form.key' @change='isChange = true'></el-input>
                        </el-form-item>
                        <el-form-item label='用户Token' :label-width='formLabelWidth' prop='token'>
                              <el-input placeholder='请输入用户Token' v-model='form.token' @change='isChange = true'></el-input>
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="formVisible=false">取 消</el-button>
                        <el-button type="primary" @click="submit">确 定</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="30%" :before-close="$utils.handleClose">
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
                  page: 1,
                  pageSize: 10,
                  total: 0,
                  tableData: [],
                  formTitle: "",
                  formVisible: false,
                  inductsVisible: false,
                  form: { id: "", date: "", key: "", token: "" },
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
                        key: [
                              {
                                    required: true,
                                    message: "请输入用户Key",
                                    trigger: "blur",
                              },
                        ],
                        token: [
                              {
                                    required: true,
                                    message: "请输入用户Token",
                                    trigger: "blur",
                              },
                        ],
                  },
                  formLabelWidth: "80px",
                  /** 弹出框标签宽度*/ isChange: false,
                  search: { id: "", key: "", token: "" },
            };
      },
      methods: {
            init() {
                  this.toPage();
            },
            toPage() {
                  this.loading = true;
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
                                    "/admin/system/online?page=" +
                                    this.page +
                                    "&pageSize=" +
                                    this.pageSize +
                                    param
                        )
                        .then((res) => {
                              let list=[]
                              let map=res.data.data.list;
                              Object.keys(map).forEach(item=>{
                                    list.push(
                                          {
                                                key:item,
                                                token:map[item]
                                          }
                                    )
                              })
                              this.tableData = list;
                              this.loading = false;
                              this.$root.loading=false;
                        });
            },
            /**监听页码发生变化 */ changePage(e) {
                  this.page = e;
                  this.toPage();
            },
            add() {
                  this.form = this.$options.data().form;
                  this.formTitle = "新增";
                  this.formVisible = true;
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
                        url: this.$url + "/admin/admin/add",
                        data: formData,
                  }).then(() => {
                        this.toPage();
                        this.formVisible = false;
                  });
            },
            edit(row) {
                  this.form = row;
                  this.formTitle = "编辑";
                  this.formVisible = true;
            },
            del(row) {
                  this.$confirm("此操作将使该用户立即下线, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.$root.loading = true;
                        let format = new FormData();
                        format.append("key", row.key);
                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + "/admin/system/offline",
                        }).then(() => {
                              this.toPage();
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
                        url: this.$url + "/admin/admin/inducts",
                        data: formData,
                        headers: { "Content-Type": "multipart/form-data" },
                  })
                        .then((res) => {
                              /*上传成功后是否需要将选择的文件滞空*/ this.$refs.inducts.value =
                                    null;
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
      },
      mounted() {
            this.init();
      },
};
</script><style lang="less"></style>