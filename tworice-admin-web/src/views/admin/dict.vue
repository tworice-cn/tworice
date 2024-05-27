<template>
    <div class="app-body">
        <!-- 条件查询 -->
        <el-col :span="24" class="info-search-box">
            <el-form class="search" @submit.native.prevent="submitSearch">
                <div class='search-item'>编号 :
                    <el-input size='mini' v-model='search.id' placeholder='通过编号查询' clearable></el-input>
                </div>
                <div class='search-item'>字典名称 :
                    <el-input size='mini' v-model='search.name' placeholder='通过字典名称查询' clearable></el-input>
                </div>
                <div class='search-item'>字典标识 :
                    <el-input size='mini' v-model='search.logo' placeholder='通过字典标识查询' clearable></el-input>
                </div>
                <div class="search-item">
                    <el-button size="mini" type="primary" @click="submitSearch" native-type="submit">查询</el-button>
                </div>
            </el-form>
        </el-col>
        <el-col :span="24" class="button-box">
            <el-button size="mini" type="primary" icon="el-icon-plus" @click="add">新增</el-button>
            <el-button size="mini" type="danger" icon="el-icon-delete" @click="delList">批量删除</el-button>
            <el-button size="mini" type="warning" icon="el-icon-upload" @click="inducts">批量导入</el-button>
        </el-col>
        <el-table @selection-change="handleSelectionChange" size="mini" v-loading="loading"
                  :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border
                  style="width: 100%">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column prop='id' label='编号' width="100"></el-table-column>
            <el-table-column prop='createTime' label='日期'
                             :formatter='(row)=>$utils.formatDate(row.createTime)'></el-table-column>
            <el-table-column prop='name' label='字典名称'></el-table-column>
            <el-table-column prop='logo' label='字典标识'></el-table-column>
            <el-table-column prop='description' label='字典描述'></el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" type="info" icon="el-icon-notebook-2" circle
                               @click.native="dictValue(scope.row)"></el-button>
                    <el-button size="mini" type="warning" icon="el-icon-edit" circle
                               @click.native="edit(scope.row)"></el-button>
                    <el-button size="mini" type="danger" icon="el-icon-delete" circle
                               @click.native="del(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-col :span="24">
            <div class="page-box">
                <el-pagination :hide-on-single-page="true" @current-change="changePage" background
                               layout="prev, pager, next" :total="total" :page-size="pageSize"></el-pagination>
            </div>
        </el-col>
        <!-- 弹出层 -->
        <!-- 字典编辑页 -->
        <el-dialog :title="formTitle" :visible.sync="formVisible" width="30%" :before-close="$utils.handleClose">
            <el-form :model="form" :rules="rules" ref="form">
                <el-form-item label='字典名称' :label-width='formLabelWidth' prop='name'>
                    <el-input placeholder='请输入字典名称' v-model='form.name' @change='isChange = true'
                              size="small"></el-input>
                </el-form-item>
                <el-form-item label='字典描述' :label-width='formLabelWidth' prop='description'>
                    <el-input placeholder='请输入字典描述' v-model='form.description' @change='isChange = true'
                              size="small"></el-input>
                </el-form-item>
                <el-form-item label='字典标识' :label-width='formLabelWidth' prop='logo'>
                    <el-input placeholder='请输入字典标识' v-model='form.logo' @change='isChange = true'
                              size="small"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="formVisible=false">取 消</el-button>
                <el-button type="primary" @click="submit">确 定</el-button>
            </div>
        </el-dialog>
        <!-- 批量导入 -->
        <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="40%" :before-close="$utils.handleClose">
            <el-form size="mini">
                <el-form-item label="选择表格" :label-width="formLabelWidth">
                    <input type="file" class="file-left-input" @change="inductsChange()" ref="inducts" multiple
                           accept=".xls,.xlsx"/>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="inductsVisible=false">取 消</el-button>
            </div>
        </el-dialog>
        <!-- 字典内容 -->
        <el-dialog title="字典数据" v-if="dictVisible" :visible.sync="dictVisible" width="60%"
                   :before-close="$utils.handleClose">
            <DictValue :dict="form.id" :dictName="form.name"></DictValue>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dictVisible=false">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import DictValue from '../../components/commons/DictValue.vue'
import paginationMixin from "@/mixins/paginationMixin";

export default {
    mixins: [paginationMixin],
    components: {
        DictValue
    },
    props: [],
    data() {
        return {
            dictVisible: false,
            form: {
                id: "",
                createTime: "",
                name: "",
                description: "",
                logo: "",
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
                        message: "请输入日期",
                        trigger: "blur",
                    },
                ],
                name: [
                    {
                        required: true,
                        message: "请输入字典名称",
                        trigger: "blur",
                    },
                ],
                description: [
                    {
                        required: true,
                        message: "请输入字典描述",
                        trigger: "blur",
                    },
                ],
                logo: [
                    {
                        required: true,
                        message: "请输入字典标识",
                        trigger: "blur",
                    },
                ],
            },
            search: {id: "", name: "", logo: ""},
            pageUrlPath: "/admin/dict",
        };
    },
    methods: {
        dictValue(row) {
            this.dictVisible = true;
            this.form = row;
        },
    },
};
</script>
<style lang="less" scoped></style>