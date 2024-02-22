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
                  <el-table-column prop='createTime' label='创建时间' :formatter='(row)=>$utils.formatDate(row.createTime)'></el-table-column>
                  <el-table-column prop='updateTime' label='更新时间' :formatter='(row)=>$utils.formatDate(row.updateTime)'></el-table-column>
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
            <el-dialog :title="formTitle" :visible.sync="formVisible" top="5vh" width="30%" :before-close="$utils.handleClose">
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
                        <el-button size="mini" type="primary" @click="submitWhiteList">确 定</el-button>
                  </div>
            </el-dialog>
            <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="40%" :before-close="$utils.handleClose">
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
import paginationMixin from "@/mixins/paginationMixin";

export default {
    mixins: [paginationMixin],
    props: [],
    data() {
        return {
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
            search: {id: "", state: ""},
            pageUrlPath: "/admin/whiteList",
            pattern: /\d+.\d+.\d+.\d+/,
        };
    },
    methods: {
        verifyIP(ipAddr) {
            return this.pattern.test(ipAddr);
        },
        submitWhiteList() {
            if (!this.verifyIP(this.form.beginIp) || !this.verifyIP(this.form.endIp)) {
                this.$msg({
                    type: "error",
                    message: "请检查IP地址格式",
                });
                return;
            }
            this.submit();
        },
    },
};
</script>
<style lang="less" scoped></style>