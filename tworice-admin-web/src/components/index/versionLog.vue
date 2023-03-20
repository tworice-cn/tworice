<template>
      <div class="app-body">请输入作者
            <!-- 条件查询 -->
            <el-col :span="24" class="info-search-box">
                  <div class="search">
                        <div class='search-item'> 版本号 : 
                              <el-input size="mini" v-model='search.version' placeholder='请输入版本号' clearable></el-input>
                        </div>
                        <div class='search-item'> 作者 : 
                              <el-input size="mini" v-model='search.author' placeholder='请输入作者' clearable></el-input>
                        </div>
                        <div class="search-item">
                              <el-button type="primary" @click="toPage" size="mini">查询</el-button>
                        </div>
                  </div>
            </el-col>
            <el-col :span="24" class="button-box">
                  <el-button type="primary" icon="el-icon-plus" size="mini" @click="add">新增</el-button>
            </el-col>
            <el-table size="mini" v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
                  <el-table-column type="index" label="序号"></el-table-column>
                  <el-table-column prop='createTime' label='日期' :formatter="(row)=>$utils.formatDate(row.createTime)"></el-table-column>
                  <el-table-column prop='version' label='版本号'></el-table-column>
                  <el-table-column prop='info' label='版本描述'>
                        <template slot-scope="scope">
                              <div class="version-info">{{scope.row.info}}</div>
                        </template>
                  </el-table-column>
                  <el-table-column prop='author' label='作者'></el-table-column>
                  <el-table-column label="操作"> <template slot-scope="scope">
                              <el-button size="mini" type="warning" icon="el-icon-edit" circle @click.native="edit(scope.row)"></el-button>
                              <!-- <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button> -->
                        </template> </el-table-column>
            </el-table>
            <el-col :span="24">
                  <div class="page-box">
                        <el-pagination :hide-on-single-page="true" @current-change="changePage" background layout="prev, pager, next" :total="total" :page-size="pageSize"></el-pagination>
                  </div>
            </el-col> <!-- 弹出层 -->
            <el-dialog :title="formTitle" :visible.sync="formVisible" width="30%" :before-close="$utils.handleClose">
                  <el-form :model="form" :rules="rules" ref="form">
                        <el-form-item label='版本号' :label-width='formLabelWidth' prop='version'>
                              <el-input placeholder='请输入版本号' v-model='form.version' @change='isChange = true'></el-input>
                        </el-form-item>
                        <el-form-item label='作者' :label-width='formLabelWidth' prop='author'>
                              <el-input placeholder='请输入作者' v-model='form.author' @change='isChange = true'></el-input>
                        </el-form-item>
                        <el-form-item label='版本描述' :label-width='formLabelWidth' prop='info'>
                              <el-input type="textarea" :rows="2" placeholder='请输入版本描述' v-model='form.info' @change='isChange = true'></el-input>
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
                  page: 0,
                  pageSize: 10,
                  total: 0,
                  tableData: [],
                  formTitle: "",
                  formVisible: false,
                  inductsVisible: false,
                  form: { id: "", createTime: "", version: "", info: "", author: "" },
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
                                    message: "请输入日期",
                                    trigger: "blur",
                              },
                        ],
                        version: [
                              {
                                    required: true,
                                    message: "请输入版本号",
                                    trigger: "blur",
                              },
                        ],
                        info: [
                              {
                                    required: true,
                                    message: "请输入版本描述",
                                    trigger: "blur",
                              },
                        ],
                        author: [
                              {
                                    required: true,
                                    message: "请输入作者",
                                    trigger: "blur",
                              },
                        ],
                  },
                  formLabelWidth: "80px",
                  /** 弹出框标签宽度*/ isChange: false,
                  search: { id: "", version: "", author: "" },
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
                                    "/client/versionLog/list?page=" +
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
                        url: this.$url + "/client/versionLog/add",
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
                              url: this.$url + "/client/versionLog/del",
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
                        url: this.$url + "/client/versionLog/inducts",
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
</script>
<style lang="less">
.version-info{
      // height: 50px;
      line-height: 25px;
      text-overflow: ellipsis;
      display:-webkit-box;
      -webkit-box-orient:vertical;
      -webkit-line-clamp:2; 
}
</style>