<template>
    <div class="app-body">
        <el-col :span="24" class="info-search-box">
            <div class="search">
                <div class='search-item'>反馈类型名称 :
                    <el-input size='mini' v-model='search.typeName' placeholder='通过反馈类型名称查询'
                              clearable></el-input>
                </div>
                <div class='search-item'>反馈类型状态 :
                    
                    <el-input size='mini' v-model='search.typeState' placeholder='通过反馈类型状态查询'
                              clearable></el-input>
                </div>
                <div class="search-item">
                    <el-button size="mini" type="primary" @click="submitSearch">查询</el-button>
                </div>
            </div>
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
            <el-table-column prop='id' width="55" label='编号'></el-table-column>
            <el-table-column prop='updateTime' label='更新时间'
                             :formatter='(row)=>$utils.formatDate(row.updateTime)'></el-table-column>
            <el-table-column prop='typeName' label='反馈类型名称'></el-table-column>
            <el-table-column prop='typeState' label='反馈类型状态'>
                <template slot-scope="scope">
                    <el-tag :type="scope.row.typeState==1?'success':'info'">{{scope.row.typeState==1?'展示':'不展示'}}</el-tag>
                </template>
            </el-table-column>
            <el-table-column prop='typeLevel' label='反馈类型级别'></el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" type="warning" icon="el-icon-edit" circle
                               @click.native="edit(scope.row)"></el-button>
                    <el-button size="mini" type="danger" icon="el-icon-delete" circle
                               @click.native="del(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-col :span="24">
            <div class="page-box">
                <el-pagination @size-change="handleSizeChange" :small="true" :hide-on-single-page="true"
                               @current-change="changePage" background layout="total, sizes, prev, pager, next"
                               :total="total" :page-size="pageSize" :current-page="page"></el-pagination>
            </div>
        </el-col>
        <el-dialog :title="formTitle" :visible.sync="formVisible" top="5vh" width="30%"
                   :before-close="$utils.handleClose">
            <el-form :model="form" :rules="rules" ref="form">
                <el-form-item label='名称' :label-width='formLabelWidth'>
                    <el-input placeholder='请输入反馈类型名称' v-model='form.typeName' @change='isChange = true'
                              size='small'></el-input>
                </el-form-item>
                <el-form-item label='状态' :label-width='formLabelWidth'>
                    <el-switch v-model="form.typeState" active-color="#13ce66" inactive-color="#ff4949" :active-value="1" :inactive-value="-1"></el-switch>
                </el-form-item>
                <el-form-item label='级别' :label-width='formLabelWidth'>
                    <el-select v-model="form.typeLevel" placeholder="请选择处理级别" size="mini">
                        <el-option v-for="item in roleList" :key="item.id" :label="item.roleName" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label='描述' :label-width='formLabelWidth'>
                    <el-input placeholder='请输入反馈类型描述' v-model='form.typeDesc' @change='isChange = true' type="textarea"
                              size='small'></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button size="mini" @click="formVisible=false">取 消</el-button>
                <el-button size="mini" type="primary" @click="submit">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="40%" :before-close="$utils.handleClose">
            <el-form size="mini">
                <el-form-item label="选择表格" :label-width="formLabelWidth"><input type="file" class="file-left-input"
                                                                                    @change="inductsChange()"
                                                                                    ref="inducts" multiple
                                                                                    accept=".xls,.xlsx"/></el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button size="mini" @click="inductsVisible=false">取 消</el-button>
                <el-button size="mini" type="primary" @click="templateDownload">下载模板</el-button>
            </div>
        </el-dialog>
        <el-dialog title="查看" :visible.sync="showVisible" width="40%" :before-close="$utils.handleClose">
            <Descriptions :value="showInfo"></Descriptions>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="showVisible=false">关 闭</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import Descriptions from "@/components/commons/Descriptions.vue";
import {list} from "@/api/role/role.js"
export default {
    components: { Descriptions},
    props: [],
    data() {
        return {
            roleList:[],
            loading: true,
            page: 1,
            pageSize: 10,
            total: 0,
            tableData: [],
            showInfo: [],
            formTitle: '',
            formVisible: false,
            inductsVisible: false,
            showVisible: false,
            form: {
                id: '',
                createTime: '',
                updateTime: '',
                creator: '',
                typeName: '',
                typeState: -1,
                typeDesc: '',
                typeLevel: '',
            },
            rules: {
                id: [{required: true, message: '请输入编号', trigger: 'blur'}],
                createTime: [{required: true, message: '请输入创建时间', trigger: 'blur'}],
                updateTime: [{required: true, message: '请输入更新时间', trigger: 'blur'}],
                creator: [{required: true, message: '请输入创建人', trigger: 'blur'}],
                typeName: [{required: true, message: '请输入反馈类型名称', trigger: 'blur'}],
                typeState: [{required: true, message: '请输入反馈类型状态', trigger: 'blur'}],
                typeDesc: [{required: true, message: '请输入反馈类型描述', trigger: 'blur'}],
                typeLevel: [{required: true, message: '请输入反馈类型级别', trigger: 'blur'}],
            },
            formLabelWidth: '80px',
            /** 弹出框标签宽度*/                  isChange: false,
            search: {typeName: '', typeState: '',},
            multipleSelection: [],
            pageUrlPath: '/client/systemFeedbackType'
        }
    }, methods: {
        initDist() {
            this.initRole();
        },
        initRole(){
            list().then(res=>{
                this.roleList = res.data.data.roleList;
            })
        },
        handleSizeChange(size) {
            this.pageSize = size;
            this.toPage();
        },
        init() {
            this.toPage();
            this.initDist();
        }, toPage() {
            this.loading = true;
            let param = '';
            Object.entries(this.search).forEach(([key, value]) => {
                if (value) {
                    param += `&${key}=${value}`;
                }
            });
            this.$axios.get(this.$url + this.pageUrlPath + '/list?page=' + this.page + '&pageSize=' + this.pageSize + param).then(response => {
                this.tableData = response.data.data.list;
                this.total = response.data.data.total;
                this.loading = false;
            })
        }, changePage(e) {
            this.page = e;
            this.toPage();
        }, add() {
            this.form = this.$options.data().form;
            this.formTitle = '新增';
            this.formVisible = true;
        }, submit() {
            this.$root.loading = true;
            let formData = new FormData();
            Object.keys(this.form).map(key => {
                if (this.form[key] != undefined && this.form[key] != '') {
                    formData.append(key, this.form[key]);
                }
            });
            this.$axios({method: 'POST', url: this.$url + this.pageUrlPath + "/add", data: formData}).then(res => {
                if (res.data.status.code < 400) {
                    this.toPage();
                    this.formVisible = false;
                }
            });
        },
        show(row) {
            /*这里初始化信息*/
            this.showInfo = [];
            this.showInfo.push({name: '编号', value: row.id});
            this.showInfo.push({name: '创建人标识', value: row.creator});
            this.showInfo.push({name: '创建时间', value: this.$utils.formatDateTime(row.createTime)});
            this.showInfo.push({name: '更新时间', value: this.$utils.formatDateTime(row.updateTime)});
            this.showVisible = true;
        }, edit(row) {
            this.form = row;
            this.formTitle = '编辑';
            this.formVisible = true;
        }, del(row) {
            this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let format = new FormData();
                format.append("ids", row.id);
                this.$axios({method: 'DELETE', data: format, url: this.$url + this.pageUrlPath + "/del",}).then(res => {
                    if (res.data.status.code == 200) {
                        this.toPage();
                    }
                });
            });
        }, templateDownload() {
            window.open(this.$url + this.pageUrlPath + '/template');
        }, delList() {
            this.$confirm('此操作将永久删除信息, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let format = new FormData();
                this.multipleSelection.forEach(item => {
                    format.append("ids", item.id);
                });
                this.$axios({method: 'DELETE', data: format, url: this.$url + this.pageUrlPath + "/del",}).then(res => {
                    if (res.data.status.code == 200) {
                        this.toPage();
                    }
                })
            })
        }, handleSelectionChange(val) {
            this.multipleSelection = val;
        }, inducts() {
            this.inductsVisible = true;
        }, inductsChange() {
            let files = this.$refs.inducts.files;/*获取选择的文件*/
            let len = files.length;/*文件个数*/
            if (len != 1) {
                this.$msg({message: '需要且只能上传一个文件', type: 'warning'});
                return;
            }
            let formData = new FormData();
            formData.append("file", files[0]);
            this.$axios({
                method: 'post',
                url: this.$url + this.pageUrlPath + '/inducts',
                data: formData,
                headers: {'Content-Type': 'multipart/form-data'}
            }).then(res => {                        /*上传成功后是否需要将选择的文件滞空*/
                this.$refs.inducts.value = null;
                if (res.data.status.code == 200) {
                    this.inductsVisible = false;
                    this.toPage();
                }
            }).catch(() => {
                this.$refs.inducts.value = null;
                this.$msg({message: '上传失败，请检查文件合法性！', type: 'error'})
            })
        }, submitSearch() {
            this.page = 0;
            this.toPage();
        }
    }, mounted() {
        this.init();
    }
};</script>
<style lang="less" scoped></style>