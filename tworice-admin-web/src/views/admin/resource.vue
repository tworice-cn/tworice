<template>
    <div class="resource app-body">
        
        <el-col :span="24" class="resource-list">
            <el-col :span="24" class="button-box">
                <el-button type="primary" icon="el-icon-plus" size="mini" @click="addModule">新增</el-button>
            </el-col>
            <el-col :span="24">
                <el-table size="mini" :data="tableData" style="width: 100%;margin-bottom: 20px;" row-key="id" border
                          :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
                          :header-cell-style="$setting.table_header">
                    <el-table-column prop="name" label="资源名称"></el-table-column>
                    <el-table-column prop="url" label="地址"></el-table-column>
                    <el-table-column prop="path" label="路由"></el-table-column>
                    <el-table-column prop="pid" label="上级ID"></el-table-column>
                    <el-table-column prop="sort" label="排序" sortable></el-table-column>
                    <el-table-column prop="icon" label="图标">
                        <template slot-scope="scope">
                            <i :class="scope.row.icon" style="font-size: 22px;"></i>
                        </template>
                    </el-table-column>
                    <el-table-column prop="type" label="类型" width="100">
                        <template slot-scope="scope">
                            <el-tag type="success" v-if="scope.row.type==1">模块</el-tag>
                            <el-tag type="primary" v-if="scope.row.type==2">页面</el-tag>
                            <el-tag type="warning" v-if="scope.row.type==3">功能</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column prop="state" label="状态" width="100">
                        <template slot-scope="scope">
                            <el-tag type="success" v-if="scope.row.state">正常</el-tag>
                            <el-tag type="info" v-else>禁用</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column prop="menu" label="展示菜单" width="100">
                        <template slot-scope="scope" v-if="scope.row.type===2">
                            <el-tag type="success" v-if="scope.row.menu">展示</el-tag>
                            <el-tag type="info" v-else>不展示</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button v-if="scope.row.type!=3" size="mini" type="primary" icon="el-icon-plus" circle
                                       @click.native="addResource(scope.row)"></el-button>
                            <el-button size="mini" type="warning" icon="el-icon-edit" circle
                                       @click.native="editResource($event,scope.row)"></el-button>
                            <el-button size="mini" type="danger" icon="el-icon-delete" circle
                                       @click.native="delResource($event,scope.row)"></el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-col>
        
        <!-- 添加弹窗 -->
        <el-dialog :title="formTitle" :visible.sync="dialogFormVisible" width="30%" :before-close='$utils.handleClose'>
            <el-form :model="form" size="mini" :rules="rules" ref="form">
                <el-form-item label="资源名称" :label-width="formLabelWidth" prop="name">
                    <el-input v-model="form.name" @change="isChange = true" placeholder="展示名称"></el-input>
                </el-form-item>
                <el-form-item label="地址" :label-width="formLabelWidth" prop="url">
                    <el-input v-model="form.url" @change="isChange = true" placeholder="请求地址"></el-input>
                </el-form-item>
                <el-form-item label="路由" :label-width="formLabelWidth" prop="path">
                    <el-input v-model="form.path" @change="isChange = true" placeholder="路由路径"></el-input>
                </el-form-item>
                <el-form-item label="排序" :label-width="formLabelWidth" prop="sort">
                    <el-input-number v-model="form.sort" :step="1" step-strictly @change="isChange = true"></el-input-number>
                </el-form-item>
                <el-form-item label="资源图标" :label-width="formLabelWidth" prop="icon">
                    <el-select @change="isChange = true" size="mini" v-model="form.icon" filterable placeholder="请选择"
                               :loading="iconFontLoading" @focus="iconFocus">
                        <el-option
                            v-for="item in iconFont"
                            :key="item"
                            :label="item"
                            :value="item">
                            <span style="float: left;font-size: 12px">{{ item == '' ? '暂不设置图标' : item }}</span>
                            <span style="float: right; color: #8492a6; font-size: 22px"><i :class="item"></i></span>
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="资源类型" :label-width="formLabelWidth" prop="type">
                    <el-select size="mini" :disabled="form.pid!==0 || form.id" v-model="form.type" style="width: 100%;">
                        <el-option label="模块" :value="1" v-if="form.type<3"></el-option>
                        <el-option label="页面" :value="2" v-if="form.type<3"></el-option>
                        <el-option label="功能" :value="3" v-if="form.pid!==0"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="状态" :label-width="formLabelWidth">
                    <el-switch v-model="form.state" active-color="#13ce66" inactive-color="#409eff" active-text="正常" inactive-text="禁用"></el-switch>
                </el-form-item>
                <el-form-item label="是否菜单" :label-width="formLabelWidth" v-if="form.type===2">
                    <el-switch v-model="form.menu" active-color="#13ce66" inactive-color="#409eff" active-text="展示" inactive-text="不展示"></el-switch>
                </el-form-item>
                <el-input v-model="form.pid" type="hidden"></el-input>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible=false">取 消</el-button>
                <el-button type="primary" @click="submit">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import fontFontArray from '../../assets/json/iconFont.json';

export default {
    props: [],
    data() {
        return {
            state: 1,// 编辑：0 新增：1-外部的新增 2-模块上的新增 3-页面上的新增
            search_name: '',
            tableData: [],
            formTitle: '',
            dialogFormVisible: false, // 弹出框状态
            form: {
                pid: -1,
                name: '',
                url: '',
                path: '',
                sort: 1,
                icon: '',
                type: 1,
                menu:true,
                state: true
            },
            formLabelWidth: '80px', // 弹出框标签宽度
            // 表单校验规则
            rules: {
                name: [
                    {required: true, message: '请输入资源名称', trigger: 'blur'}
                ],
                url: [
                    {required: true, message: '请输入请求路径', trigger: 'blur'}
                ],
                sort: [
                    {required: true, message: '请输入序号', trigger: 'blur'}
                ]
            },
            // 删除提示消息
            delMsg: '',
            // 行的id
            // rowId: -1,
            isChange: false,// 是否有修改
            iconFont: [],// 可供选择图标
            iconFontLoading: false,// 正在加载图标库
            pageUrlPath:'/admin/system/resources'
        }
    },
    methods: {
        // 表格初始化
        init() {
            this.$axios({
                method: 'get',
                url: this.$url + '/admin/system/resources/list',
            }).then(
                res => {
                    if (res.data.status.code < 400) {
                        this.tableData = res.data.data.resourceList;
                    }
                }
            )
        },
        
        //添加模块
        addModule() {
            this.form = this.$options.data().form;
            this.formTitle = `在「根路径」下新增`;
            this.form.pid = 0;
            this.form.type = 1;
            this.dialogFormVisible = true;
        },
        
        /**
         * 添加资源
         * @param row
         */
        addResource(row) {
            this.form = this.$options.data().form;
            this.form.pid = row.id;
            this.formTitle = `在${this.getTypeNameByType(row.type)}「${row.name}」下新增`;
            
            if (row.type < 3) {
                this.form.type = row.type + 1;
                this.form.url = row.url + '/';
            }
            this.dialogFormVisible = true;
        },
        
        // 编辑资源
        editResource(e, row) {
            this.dialogFormVisible = true;
            this.form = this.$utils.deepCopy(row);
            this.formTitle=`编辑「${row.name}」${this.getTypeNameByType(row.type)}`
        },

        
        // 提交添加或编辑内容
        submit() {
            if (!this.form.name || !this.form.url) {
                this.$msg({
                    type: "warning",
                    message: '带*项不能为空'
                })
                return
            }
            
            this.$root.loading = true;
            let format = new FormData();
            for (let key in this.form) {
                format.append(key, this.form[key]);
            }
            
            this.$axios({
                method: 'put',
                url: this.$url + '/admin/system/resources/edit',
                data: format
            }).then(
                () => {
                    this.init();
                }
            )
            this.dialogFormVisible = false;
            
        },
        
        // 重置表单和表单验证
        resetForm() {
            //重置表单
            this.$refs.form.resetFields();
            //重置表单验证
            this.$refs.form.clearValidate();
        },
        
        // 删除资源
        delResource(e, row) {
            if (row.type === 1) {
                this.delMsg = '该模块及其下的页面与功能'
            } else if (row.type === 2) {
                this.delMsg = '该页面及其下的功能'
            } else if (row.type === 3) {
                this.delMsg = '该功能'
            }
            
            this.$confirm(`此操作将永久删除${this.delMsg}, 是否继续?`, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                let format = new FormData();
                this.buildIds(format, row);
                
                this.$axios({
                    method: 'delete',
                    url: this.$url + '/admin/system/resources/del',
                    data: format
                }).then(() => {
                        this.init();
                    }
                )
            }).catch(() => {
                this.$msg({
                    type: 'info',
                    message: '已取消删除'
                });
            });
            
            this.forceBlur(e);
        },
        
        // 强制按钮失去焦点
        forceBlur(e) {
            let target = e.target;
            if (target.nodeName == "I") {
                target = e.target.parentNode;
            }
            target.blur();
        },
        
        // 加载icon资源
        iconFocus() {
            this.iconFont = fontFontArray.iconFont;
        },
        
        /**
         * 递归构建表单中的id
         * @param formData
         * @param row
         */
        buildIds(formData, row){
            formData.append('ids', row.id);
            if (row.children) {
                row.children.forEach(func => {
                    this.buildIds(formData, func);
                });
            }
        },
        
        getTypeNameByType(type){
            return type === 1 ? '模块' : type === 2 ? '页面' : '功能';
        },
        
    },
    mounted() {
        this.$root.loading = true;
        this.init();
        this.$root.loading = false;
    }
};
</script>