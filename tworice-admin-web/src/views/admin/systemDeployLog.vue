<template>
      <div class="app-body">
            <!-- 条件查询 -->
            <el-col :span="24" class="info-search-box">
                  <div class="search">
                        <div class="search-item">操作人 : <el-input size="mini" v-model="search.creator" placeholder="通过操作人查询" clearable></el-input></div>
                        <div class="search-item">调动人 : <el-input size="mini" v-model="search.userId" placeholder="通过调动人查询" clearable></el-input></div>
                        <div class="search-item"><el-button size="mini" type="primary" @click="submitSearch">查询</el-button></div>
                  </div>
            </el-col>
            <el-table
                  @selection-change="handleSelectionChange"
                  size="mini"
                  v-loading="loading"
                  :header-cell-style="$setting.table_header"
                  :stripe="true"
                  :fit="true"
                  :data="tableData"
                  border
                  style="width: 100%"
            >
                  <el-table-column prop="createTime" label="调动时间" :formatter="(row) => $utils.formatDate(row.createTime)"></el-table-column
                  ><el-table-column prop="creator" label="操作人编号"></el-table-column><el-table-column prop="state" label="调动状态"></el-table-column
                  >
                  <el-table-column prop="userId" label="调动人编号"></el-table-column>
                  <el-table-column prop="nickName" label="调动人"></el-table-column>
                  
            </el-table>
            <el-col :span="24">
                  <div class="page-box">
                        <el-pagination
                              @size-change="handleSizeChange"
                              :small="true"
                              :hide-on-single-page="true"
                              @current-change="changePage"
                              background
                              layout="total, sizes, prev, pager, next"
                              :total="total"
                              :page-size="pageSize"
                              :current-page="page"
                        ></el-pagination>
                  </div>
            </el-col>
            <!-- 弹出层 -->
            <el-dialog :title="formTitle" :visible.sync="formVisible" top="5vh" width="30%" :before-close="$utils.handleClose">
                  <el-form :model="form" :rules="rules" ref="form">
                        <el-form-item label="调动状态" :label-width="formLabelWidth" prop="state"
                              ><el-select size="mini" v-model="form.state" placeholder="请选择" clearable
                                    ><el-option v-for="item in stateDist" :key="item.id" :label="item.content" :value="item.content"></el-option></el-select></el-form-item
                        ><el-form-item label="调动人" :label-width="formLabelWidth" prop="userId"
                              ><el-input placeholder="请输入调动人" v-model="form.userId" @change="isChange = true" size="small"></el-input
                        ></el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button size="mini" @click="formVisible = false">取 消</el-button> <el-button size="mini" type="primary" @click="submit">确 定</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="40%" :before-close="$utils.handleClose">
                  <el-form size="mini">
                        <el-form-item label="选择表格" :label-width="formLabelWidth">
                              <input type="file" class="file-left-input" @change="inductsChange()" ref="inducts" multiple accept=".xls,.xlsx" />
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button size="mini" @click="inductsVisible = false">取 消</el-button> <el-button size="mini" type="primary" @click="templateDownload">下载模板</el-button>
                  </div>
            </el-dialog>
      </div></template
>
<script>
import paginationMixin from "@/mixins/paginationMixin";

export default {
    mixins: [paginationMixin],
    props: ['id'],
    data() {
        return {
            form: {id: "", createTime: "", updateTime: "", creator: "", state: "", userId: ""},
            rules: {
                id: [{required: true, message: "请输入编号", trigger: "blur"}],
                createTime: [{required: true, message: "请输入创建时间", trigger: "blur"}],
                updateTime: [{required: true, message: "请输入更新时间", trigger: "blur"}],
                creator: [{required: true, message: "请输入操作人", trigger: "blur"}],
                state: [{required: true, message: "请输入调动状态", trigger: "blur"}],
                userId: [{required: true, message: "请输入调动人", trigger: "blur"}],
            },
            
            search: {id: "", creator: "", state: "", userId: "", deployId: ""},
            stateDist: [],
            pageUrlPath: "/client/systemDeployLog",
        };
    },
    methods: {
        stateInit() {
            this.$axios.get(this.$url + "/admin/distValue/list?page=0&pageSize=100&dist=6").then((response) => {
                this.stateDist = response.data.data.list;
            });
        },
        initDist() {
            this.stateInit();
        },
        toPage() {
            this.loading = true;
            let param = "";
            this.search.deployId = this.id;
            Object.keys(this.search).map((key) => {
                if (this.search[key] != undefined && this.search[key] != "") {
                    param += "&" + key + "=" + this.search[key];
                }
            });
            this.$axios.get(this.$url + this.pageUrlPath + "/list?page=" + this.page + "&pageSize=" + this.pageSize + param).then((response) => {
                this.tableData = response.data.data.list;
                this.total = response.data.data.total;
                this.loading = false;
            });
        }
    },
};
</script>
<style lang="less" scoped></style>
