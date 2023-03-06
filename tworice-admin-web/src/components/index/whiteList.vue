<template>
      <div class="app-body">
            <!-- 条件查询 -->
            <el-col :span="24" class="info-search-box">
                  <div class="search">
                        <div class='search-item'>编号 : <el-input size='mini' v-model='search.id' placeholder='通过编号查询' clearable></el-input>
                        </div>
                        <div class="search-item">
                              <el-button size="mini" type="primary" @click="toPage">查询</el-button>
                        </div>
                  </div>
            </el-col>
            <el-col :span="24" class="button-box">
                  <el-button size="mini" type="primary" icon="el-icon-plus" @click="add">新增</el-button>
                  <el-button size="mini" type="danger" icon="el-icon-delete" @click="delList">批量删除</el-button>
                  <el-button size="mini" type="warning" icon="el-icon-upload" @click="inducts">批量导入</el-button>
            </el-col>
            <el-table @selection-change="handleSelectionChange" size="mini" v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
                  <el-table-column type="selection" width="55"></el-table-column>
                  <el-table-column prop='id' label='编号' width="55"></el-table-column>
                  <el-table-column prop='createTime' label='创建时间' :formatter='(row)=>formatDate(row.createTime)'></el-table-column>
                  <el-table-column prop='updateTime' label='更新时间' :formatter='(row)=>formatDate(row.updateTime)'></el-table-column>
                  <el-table-column prop='beginIp' label='开始IP'></el-table-column>
                  <el-table-column prop='endIp' label='结束IP'></el-table-column>
                  <el-table-column label="操作"> <template slot-scope="scope">
                              <el-button size="mini" type="warning" icon="el-icon-edit" circle @click.native="edit(scope.row)"></el-button>
                              <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button>
                        </template> </el-table-column>
            </el-table>
            <el-col :span="24">
                  <div class="page-box">
                        <el-pagination @size-change="handleSizeChange" :small="true" :hide-on-single-page="true" @current-change="changePage" background layout="total, sizes, prev, pager, next" :total="total"
                              :page-size="pageSize"></el-pagination>
                  </div>
            </el-col> <!-- 弹出层 -->
            <el-dialog :title="formTitle" :visible.sync="formVisible" top="5vh" width="30%" :before-close="handleClose">
                  <el-form :model="form" :rules="rules" ref="form">
                        <el-form-item label='开始IP' :label-width='formLabelWidth' prop='beginIp'>
                              <el-input placeholder='请输入开始IP' v-model='form.beginIp' @change='isChange = true' size='small'></el-input>
                        </el-form-item>
                        <el-form-item label='结束IP' :label-width='formLabelWidth' prop='endIp'>
                              <el-input placeholder='请输入结束IP' v-model='form.endIp' @change='isChange = true' size='small'></el-input>
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button size="mini" @click="formVisible=false">取 消</el-button>
                        <el-button size="mini" type="primary" @click="submit">确 定</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="40%" :before-close="handleClose">
                  <el-form size="mini">
                        <el-form-item label="选择表格" :label-width="formLabelWidth"> <input type="file" class="file-left-input" @change="inductsChange()" ref="inducts" multiple accept=".xls,.xlsx" /> </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button size="mini" @click="inductsVisible=false">取 消</el-button>
                        <el-button size="mini" type="primary" @click="templateDownload">下载模板</el-button>
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
                        createTime: "",
                        updateTime: "",
                        beginIp: "",
                        endIp: "",
                        state: "",
                  },
                  rules: {
                        id: [
                              {
                                    required: true,
                                    message: "请输入编号",
                                    trigger: "blur",
                              },
                        ],
                        createTime: [
                              {
                                    required: true,
                                    message: "请输入创建时间",
                                    trigger: "blur",
                              },
                        ],
                        updateTime: [
                              {
                                    required: true,
                                    message: "请输入更新时间",
                                    trigger: "blur",
                              },
                        ],
                        beginIp: [
                              {
                                    required: true,
                                    message: "请输入开始IP",
                                    trigger: "blur",
                              },
                        ],
                        endIp: [
                              {
                                    required: true,
                                    message: "请输入结束IP",
                                    trigger: "blur",
                              },
                        ],
                        state: [
                              {
                                    required: true,
                                    message: "请输入状态",
                                    trigger: "blur",
                              },
                        ],
                  },
                  formLabelWidth: "80px",
                  /** 弹出框标签宽度*/ isChange: false,
                  search: { id: "", state: "" },
                  multipleSelection: [],
                  pageUrlPath: "/admin/whiteList",
                  pattern: /\d+.\d+.\d+.\d+/,
            };
      },
      methods: {
            /**初始化字典 */ initDist() {},
            /**格式化日期 */ formatDate(timeStamp) {
                  let date = new Date(timeStamp);
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
            handleSizeChange(size) {
                  this.pageSize = size;
                  this.toPage();
            },
            init() {
                  this.toPage();
                  this.initDist();
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
                                    this.pageUrlPath +
                                    "/list?page=" +
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
            verifyIP(ipAddr){
                  return this.pattern.test(ipAddr);
            },
            submit() {
                  if(!this.verifyIP(this.form.beginIp) || !this.verifyIP(this.form.endIp)){
                        this.$message({
                              type: "error",
                              message: "请检查IP地址格式",
                        });
                        return;
                  }
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
                        url: this.$url + this.pageUrlPath + "/add",
                        data: formData,
                  }).then((res) => {
                        if (res.data.status.code == 200) {
                              this.toPage();
                              this.formVisible = false;
                        }
                  });
            },
            edit(row) {
                  this.form = row;
                  this.formTitle = "编辑";
                  this.formVisible = true;
            },
            /*删除*/ del(row) {
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
                              url: this.$url + this.pageUrlPath + "/del",
                        }).then((res) => {
                              if (res.data.status.code == 200) {
                                    this.toPage();
                              }
                        });
                  });
            },
            /**下载表 */ templateDownload() {
                  window.open(this.$url + this.pageUrlPath + "/template");
            },
            /**批量删除 */ delList() {
                  this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.$root.loading = true;
                        let format = new FormData();
                        this.multipleSelection.forEach((item) => {
                              format.append("ids", item.id);
                        });
                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + this.pageUrlPath + "/del",
                        }).then((res) => {
                              if (res.data.status.code == 200) {
                                    this.toPage();
                              }
                        });
                  });
            },
            /**选择框 val为当前所有选择的内容数组 */ handleSelectionChange(
                  val
            ) {
                  this.multipleSelection = val;
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
                        url: this.$url + this.pageUrlPath + "/inducts",
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
</script><style lang="less" scoped></style>