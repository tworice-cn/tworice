<template>
    <div class="app-body">            <!-- 条件查询 -->
        <el-col :span="24" class="info-search-box">
            <div class="search">
                <div class='search-item'>编号 :
                    <el-input v-model='search.id' clearable placeholder='通过编号查询' size='mini'></el-input>
                </div>
                <div class='search-item'>反馈类型 :
                    <el-select v-model="search.fbType" placeholder="请选择" size="mini">
                        <el-option v-for="item in typeList" :key="item.id" :label="item.typeName"
                                   :value="item.id"></el-option>
                    </el-select>
                </div>
                <div class='search-item'>联系方式 :
                    <el-input v-model='search.fbContact' clearable placeholder='通过联系方式查询'
                              size='mini'></el-input>
                </div>
                <div class="search-item">
                    <el-button size="mini" type="primary" @click="submitSearch">查询</el-button>
                </div>
            </div>
        </el-col>
        <el-col :span="24" class="button-box">
            <el-button icon="el-icon-delete" size="mini" type="danger" @click="delList">批量删除</el-button>
            <el-button icon="el-icon-pie-chart" size="mini" type="success" @click="showChart">统计报告</el-button>
        </el-col>
        <el-table v-loading="loading" :data="tableData" :fit="true"
                  :header-cell-style="$setting.table_header" :stripe="true" border size="mini" style="width: 100%"
                  @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column label='编号' prop='id' width="60"></el-table-column>
            <el-table-column :formatter='(row)=>$utils.formatDate(row.createTime)' label='提交时间'
                             prop='createTime'></el-table-column>
            <el-table-column :formatter='(row)=>$utils.formatDate(row.updateTime)' label='更新时间'
                             prop='updateTime'></el-table-column>
            <el-table-column label='反馈人标识' prop='creator'></el-table-column>
            
            <el-table-column label='反馈类型' prop='fbType'>
                <template slot-scope="scope">
                    <el-tag>{{ scope.row.typeName }}</el-tag>
                </template>
            </el-table-column>
            <el-table-column label='联系方式' prop='fbContact'></el-table-column>
            <el-table-column label='处理状态' prop='fbState'></el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" type="info" icon="el-icon-view" circle
                               @click.native="show(scope.row)"></el-button>
                    <el-button size="mini" type="warning" icon="el-icon-edit" circle @click.native="edit(scope.row)"></el-button>
                    <el-button circle icon="el-icon-delete" size="mini" type="danger"
                               @click.native="del(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-col :span="24">
            <div class="page-box">
                <el-pagination :current-page="page" :hide-on-single-page="true" :page-size="pageSize"
                               :small="true" :total="total" background layout="total, sizes, prev, pager, next"
                               @size-change="handleSizeChange" @current-change="changePage"></el-pagination>
            </div>
        </el-col>
        <el-dialog :before-close="$utils.handleClose" :title="formTitle" :visible.sync="formVisible" top="5vh"
                   width="40%">
            <el-form ref="form" :model="form">
                <el-form-item :label-width='formLabelWidth' label='处理状态'>
                    <el-select v-model="form.fbState" placeholder="请选择" size="mini">
                        <el-option v-for="item in stateList" :key="item.content" :label="item.content"
                                   :value="item.content"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item :label-width='formLabelWidth' label='处理结果'>
                    <Editor ref="editor" v-model="form.fbDeal" @change='isChange = true'></Editor>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button size="mini" @click="formVisible=false">取 消</el-button>
                <el-button size="mini" type="primary" @click="submit">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog :before-close="$utils.handleClose" :visible.sync="inductsVisible" title="选择数据表格" width="40%">
            <el-form size="mini">
                <el-form-item :label-width="formLabelWidth" label="选择表格"><input ref="inducts" accept=".xls,.xlsx"
                                                                                    class="file-left-input" multiple
                                                                                    type="file"
                                                                                    @change="inductsChange()"/>
                </el-form-item>
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
        <el-dialog title="统计报告" :visible.sync="chartsVisible" width="50%" :before-close="$utils.handleClose">
            <FeedbackChart :value="stateList"></FeedbackChart>
        </el-dialog>
    </div>
</template>
<script>
import {type, submitForm, chart} from '@/api/feedback/feedback';
import Editor from '@/components/commons/Editor.vue'
import Descriptions from '@/components/commons/Descriptions.vue'
import {distList} from '@/api/dist/dist.js';
import FeedbackChart from "@/views/admin/feedback/FeedbackChart.vue";
export default {
    components: {
        Editor,
        Descriptions,
        FeedbackChart
    },
    props: [], data() {
        return {
            loading: true,
            page: 1,
            pageSize: 10,
            total: 0,
            tableData: [],
            formTitle: '',
            formVisible: false,
            inductsVisible: false,
            showVisible: false,
            chartsVisible: false,
            form: {
                id: '',
                createTime: '',
                updateTime: '',
                creator: '',
                fbType: '',
                fbDescribe: '',
                fbContact: '',
                fbState: '',
                fbDeal: '',
            },
            showInfo: [],
            rules: {
                id: [{required: true, message: '请输入编号', trigger: 'blur'}],
                createTime: [{required: true, message: '请输入创建时间', trigger: 'blur'}],
                updateTime: [{required: true, message: '请输入更新时间', trigger: 'blur'}],
                creator: [{required: true, message: '请输入创建人', trigger: 'blur'}],
                fbType: [{required: true, message: '请输入反馈类型', trigger: 'blur'}],
                fbDescribe: [{required: true, message: '请输入反馈描述', trigger: 'blur'}],
                fbContact: [{required: true, message: '请输入联系方式', trigger: 'blur'}],
                fbImg: [{required: true, message: '请输入反馈图片', trigger: 'blur'}],
            },
            formLabelWidth: '80px',
            /** 弹出框标签宽度*/                  isChange: false,
            search: {id: '', creator: '', fbType: '', fbContact: '', typeLevel: []},
            multipleSelection: [],
            pageUrlPath: '/client/systemFeedback',
            typeList: [],
            stateList:[]
        }
    },
    methods: {
        showChart(){
            chart().then(res => {
                this.stateList=res.data.data.list;
                this.chartsVisible=true;
            });
        },
        show(row) {
            this.showInfo = [];
            this.showInfo.push({name: '编号', value: row.id});
            this.showInfo.push({name: '创建人标识', value: row.creator});
            this.showInfo.push({name: '创建时间', value: this.$utils.formatDate(row.createTime)});
            this.showInfo.push({name: '更新时间', value: this.$utils.formatDate(row.updateTime)});
            this.showInfo.push({name: '反馈类型', value: row.typeName});
            this.showInfo.push({name: '联系方式', value: row.fbContact});
            this.showInfo.push({name: '处理状态', value: row.fbState});
            this.showInfo.push({name: '反馈内容', value: row.fbDescribe});
            this.showInfo.push({name: '当前处理结果', value: row.fbDeal});
            this.showVisible = true;
        },
        handleSizeChange(size) {
            this.pageSize = size;
            this.toPage();
        },
        initType() {
            type().then(res => {
                this.typeList = res.data.data.list;
            })
        },
        init() {
            distList(9).then(res=>{
                this.stateList=res.data.data.list;
            })
            this.toPage();
            this.initType();
        },
        toPage() {
            this.loading = true;
            JSON.parse(window.localStorage.getItem('roles') || []).forEach(item => {
                this.search.typeLevel.push(item.id);
            });
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
        }, /**监听页码发生变化 */            changePage(e) {
            this.page = e;
            this.toPage();
        }, add() {
            this.form = this.$options.data().form;
            this.formTitle = '新增';
            this.formVisible = true;
        },
        submit() {
            this.$root.loading=true;
            submitForm(this.form).then(res => {
                if (res.data.status.code < 400) {
                    this.toPage();
                    this.formVisible = false;
                }
            });
        },
        edit(row) {
            this.form = row;
            this.formTitle = '编辑';
            this.formVisible = true;
        },
        del(row) {
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
        }, /**下载表 */            templateDownload() {
            window.open(this.$url + this.pageUrlPath + '/template');
        }, /**批量删除 */            delList() {
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
        }, /**选择框 val为当前所有选择的内容数组 */            handleSelectionChange(val) {
            this.multipleSelection = val;
        }, /**点击批量导入 */            inducts() {
            this.inductsVisible = true;
        }, /**选择批量 */            inductsChange() {
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