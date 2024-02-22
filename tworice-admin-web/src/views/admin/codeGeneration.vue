<template>
    <div class="app-body">
        <el-button type="primary" size="mini" @click="add">代码生成</el-button>
        
        <el-table size="mini" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
            <el-table-column type="index" label="序号"></el-table-column>
            <el-table-column prop="tableName" label="表名称"></el-table-column>
            <el-table-column prop="tableComment" label="表注释"></el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-tooltip content="编辑">
                        <el-button size="mini" type="warning" icon="el-icon-edit" circle @click="edit(scope.row)"></el-button>
                    </el-tooltip>
                    <el-tooltip content="删除">
                        <el-button size="mini" type="danger" icon="el-icon-delete" circle @click="del(scope.$index)"></el-button>
                    </el-tooltip>
                </template>
            </el-table-column>
        </el-table>
        
        <!-- 弹出层 -->
        <el-dialog :title="form.formTitle" :visible.sync="form.formVisible" width="70%"
                   :before-close="$utils.handleClose">
            <el-form :model="form.formData" size="mini" :rules="form.rules" ref="form.formData">
                <el-form-item label="表名称" :label-width="form.formLabelWidth" prop="tableName">
                    <el-input placeholder="请输入内容" v-model="form.formData.tableName"
                              @change="tapTableName"></el-input>
                </el-form-item>
                <el-form-item label="表注释" :label-width="form.formLabelWidth" prop="tableComment">
                    <el-input placeholder="请输入内容" v-model="form.formData.tableComment"></el-input>
                </el-form-item>
                <el-form-item label="表字段" :label-width="form.formLabelWidth">
                    <el-table :data="form.formData.paramTable" style="width: 100%" size="mini">
                        <el-table-column prop="field" label="" width="50">
                            <template slot-scope="scope">
                                <el-button :disabled="scope.row.field=='id' || scope.row.field=='create_time'"
                                           icon="el-icon-minus" circle @click="reduceField(scope)"></el-button>
                            </template>
                        </el-table-column>
                        <el-table-column prop="field" label="字段名">
                            <template slot-scope="scope">
                                <el-input :disabled="scope.row.field=='id'" placeholder="请输入内容" size="mini"
                                          v-model="scope.row.field"></el-input>
                            </template>
                        </el-table-column>
                        <el-table-column prop="name" label="字段称呼">
                            <template slot-scope="scope">
                                <el-input placeholder="请输入内容" size="mini" v-model="scope.row.name"></el-input>
                            </template>
                        </el-table-column>
                        <el-table-column prop="type" label="字段类型">
                            <template slot-scope="scope">
                                <el-select v-model="scope.row.type" placeholder="请选择" size="mini">
                                    <el-option v-for="item in typeList" :key="item" :label="item"
                                               :value="item"></el-option>
                                </el-select>
                            </template>
                        </el-table-column>
                        <el-table-column prop="query" label="查询" width="80">
                            <template slot-scope="scope">
                                <el-checkbox v-model="scope.row.query"></el-checkbox>
                            </template>
                        </el-table-column>
                        <el-table-column prop="queryType" label="查询类型" width="110">
                            <template slot-scope="scope">
                                <el-select v-model="scope.row.queryType" @change="queryTypeChange" placeholder="请选择"
                                           :disabled="!scope.row.query">
                                    <el-option v-for="item in queryType" :key="item" :label="item"
                                               :value="item"></el-option>
                                </el-select>
                            </template>
                        </el-table-column>
                        <el-table-column prop="dict" label="字典" width="110">
                            <template slot-scope="scope">
                                <el-select size="mini" v-if="scope.row.queryType=='字典'||scope.row.queryType=='数据表'"
                                           v-model="scope.row.dict" placeholder="请选择" :disabled="!scope.row.query">
                                    <el-option v-for="item in dict" :key="item.id" :label="item.name"
                                               :value="item.id"></el-option>
                                </el-select>
                            </template>
                        </el-table-column>
                        <el-table-column prop="update" label="可编辑" width="80">
                            <template slot-scope="scope">
                                <el-checkbox v-model="scope.row.update"></el-checkbox>
                            </template>
                        </el-table-column>
                        <el-table-column prop="table" label="表格展示" width="80">
                            <template slot-scope="scope">
                                <el-checkbox v-model="scope.row.table"></el-checkbox>
                            </template>
                        </el-table-column>
                        <el-table-column prop="select" label="筛选条件" width="80">
                            <template slot-scope="scope">
                                <el-checkbox v-model="scope.row.select"></el-checkbox>
                            </template>
                        </el-table-column>
                    </el-table>
                    <el-button class="tworice-column" size="mini" type="primary" round icon="el-icon-plus"
                               @click="addField"></el-button>
                </el-form-item>
                <el-form-item label="Vue页面" :label-width="form.formLabelWidth" prop="tableName">
                    <el-input placeholder="请输入Vue文件名称" v-model="form.formData.pageName"></el-input>
                </el-form-item>
                <el-form-item label="请求地址" :label-width="form.formLabelWidth" prop="tableName">
                    <el-input placeholder="如:/client/test" v-model="form.formData.url"></el-input>
                </el-form-item>
                <el-form-item label="创建服务" :label-width="form.formLabelWidth">
                    <el-switch v-model="form.formData.createServer" active-color="#13ce66"
                               inactive-color="#ff4949"></el-switch>
                </el-form-item>
                <el-form-item label="创建Vue" :label-width="form.formLabelWidth">
                    <el-switch v-model="form.formData.createVue" active-color="#13ce66"
                               inactive-color="#ff4949"></el-switch>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="cancel" size="small">取 消</el-button>
                <el-button type="info" @click="save" size="small">暂 存</el-button>
                <el-button type="primary" @click="submit" size="small"
                           :disabled="!(form.formData.createVue || form.formData.createServer)">
                    生 成
                </el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import utils from '@/util/Utils.js'

export default {
    props: [],
    data() {
        return {
            form: {
                formTitle: "代码生成",
                formVisible: false,
                formLabelWidth: "80px", // 弹出框标签宽度
                rules: {
                    tableName: [
                        {
                            required: true,
                            message: "请输入内容",
                            trigger: "blur",
                        }
                    ],
                    tableComment: [
                        {
                            required: true,
                            message: "请输入表注释",
                            trigger: "blur",
                        }
                    ]
                },
                isChange: false,
                formData: {
                    tableName: "" /**表名称 */,
                    tableComment: "", /**表注释 */
                    paramTable: [
                        {
                            field: "id",
                            name: "编号",
                            type: "int",
                            query: true,
                            queryType: '=',
                            dict: '',
                            update: false,
                            table: true,
                            select: true
                        },
                        {
                            field: "create_time",
                            name: "创建时间",
                            type: "bigint",
                            query: false,
                            queryType: '',
                            dict: '',
                            update: false,
                            table: true,
                            select: false
                        },
                        {
                            field: "update_time",
                            name: "更新时间",
                            type: "bigint",
                            query: false,
                            queryType: '',
                            dict: '',
                            update: false,
                            table: true,
                            select: false
                        },
                        {
                            field: "creator",
                            name: "创建人",
                            type: "varchar(64)",
                            query: true,
                            queryType: '=',
                            dict: '',
                            update: false,
                            table: true,
                            select: true
                        },
                    ],
                    pageName: "" /**页面名称 */,
                    url: "/client/",
                    createServer: true,
                    createVue: true
                },
            },
            /**数据类型 */
            typeList: [
                "int",
                "bigint",
                "decimal",
                "varchar(64)",
                "varchar(256)",
                "text",
                "longtext"
            ],
            /**查询类型 */
            queryType: [
                "=",
                "LIKE",
                "字典",
                "数据表"
            ],
            /**字典数据 */
            dict: [],
            /**数据表 */
            tables: [],
            tableData:[],
            
        };
    },
    methods: {
        edit(row){
            this.form.formData = row;
            this.form.formVisible = true;
            
            this.initDict();
            this.initTables();
        },
        del(index){
            this.$confirm("删除后无法恢复", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
            }).then(() => {
                let codeGeneration = JSON.parse(localStorage.getItem('codeGeneration')||'[]');
                codeGeneration.splice(index, 1);
                localStorage.setItem('codeGeneration',JSON.stringify(codeGeneration));
                this.tableData = codeGeneration;
            });
        },
        save() {
            let codeGeneration = JSON.parse(localStorage.getItem('codeGeneration')||'[]');
            codeGeneration.push(this.form.formData);
            localStorage.setItem('codeGeneration',JSON.stringify(codeGeneration));
            this.$message({
                type:'success',
                message: '保存成功'
            });
            this.tableData = codeGeneration;
        },
        tapTableName(e) {
            let hump = this.$utils.lineToHump(e);
            this.form.formData.url = '/client/' + hump;
            this.form.formData.pageName = hump;
        },
        queryTypeChange(val) {
            if (val == '字典') {
                this.initDict();
            } else if (val == '数据表') {
                this.initTables();
            }
        },
        initTables() {
            this.$axios.get(
                this.$url + "admin/codeGeneration/tables"
            ).then((response) => {
                this.dict = response.data.data.list;
            });
        },
        initDict() {
            this.$axios.get(
                this.$url + "/admin/dict/list?page=0&pageSize=100"
            ).then((response) => {
                this.dict = response.data.data.list;
            });
        },
        add() {
            this.form.formVisible = true;
            this.form.formData = this.$options.data().form.formData;
            
            this.initDict();
            this.initTables();
        },
        cancel() {
            this.$confirm('确认关闭?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.form.formVisible = false;
            })
        },
        // buildTableItem(){
        
        // },
        submit() {
            this.$root.loading = true;
            let formData = new FormData();
            // 构建table_item
            let table_item = "";
            // 构建form_item
            let form_item = "";
            // 构建form,rules
            let form = "";
            // 构建rules
            let rules = "";
            // 构建search
            let search = "";
            // 构建searchItem
            let search_item = "";
            // 构建data中的各dict
            let dict = ""
            // 构建各dict初始化方法
            let initDict = ""
            // 构建调用各dict方法的
            let initDicts = ""
            // 构建show方法体
            let showInfo = "";
            
            // 表字段设置
            this.form.formData.paramTable.forEach((item) => {
                let fieldHump = utils.lineToHump(item.field);
                // 构建展示表格
                if (item.table) {
                    let time = '';
                    if (item.field == 'create_time') {
                        time = ":formatter='(row)=>$utils.formatDate(row.createTime)'";
                    } else if (item.field == 'update_time') {
                        time = ":formatter='(row)=>$utils.formatDate(row.updateTime)'";
                    }
                    table_item += "<el-table-column prop='" + fieldHump + "' label='" + item.name + "' " + time + "></el-table-column>";
                }
                // 构建表单
                if (item.update) {
                    form_item = this.buildVueForm(item,fieldHump,form_item);
                }
                
                // 构建data中的form对象
                form += fieldHump + ":'',";
                // 构建data中的rules对象
                rules += fieldHump + ":[{ required: true, message: '请输入" + item.name + "', trigger: 'blur' }],";
                
                // 构建data中的search对象
                if (item.query && item.select) {
                    search += fieldHump + ":'',";
                    search_item = this.buildVueSearch(item, fieldHump, search_item);
                }
                // 构建show方法体
                showInfo = this.buildVueShow(item, fieldHump, showInfo);
                
                // 判断是否选择了字典
                if (item.queryType == '字典') {
                    dict += fieldHump + "Dict:[],"
                    initDict += this.buildInitDict(item, fieldHump)
                    initDicts += 'this.' + fieldHump + "Init();"
                } else if (item.queryType == '数据表') {
                    dict += fieldHump + "Dict:[],";
                    initDict += this.buildTableDict(item, fieldHump);
                    initDicts += 'this.' + fieldHump + "Init();";
                }
                
            });
            
            formData.append("tableItem", table_item);
            formData.append("formItem", form_item);
            formData.append("form", form);
            formData.append("url", this.form.formData.url);
            formData.append("templateName", "page");
            formData.append("pageName", this.form.formData.pageName);
            formData.append("rules", rules);
            formData.append("search", search);
            formData.append("searchItem", search_item);
            formData.append("dict", dict);
            formData.append("initDict", initDict);
            formData.append("initDicts", initDicts);
            formData.append("showInfo", showInfo);
            // formData.append("createServer", this.form.formData.createServer);
            
            if (this.form.formData.createVue) {
                this.$axios({
                    url: this.$url + "admin/codeGeneration/writeVue",
                    method: "POST",
                    data: formData,
                }).then((res) => {
                    if (res.data.status.code == 200) {
                        if (this.form.formData.createServer) {
                            this.createServer();
                        }
                    }
                });
            } else if (this.form.formData.createServer) {
                this.createServer();
            } else {
                this.$root.loading = false;
            }
        },
        /**构建字典 */
        buildInitDict(item, fieldHump) {
            let axios = fieldHump + "Init(){ this.$axios.get(this.$url +'/admin/dictValue/list?page=0&pageSize=100&dict="
                + item.dict + "').then((response) => {this."
                + fieldHump + "Dict=response.data.data.list;});},"
            
            return axios;
        },
        /*构建数据表字典*/
        buildTableDict(item, fieldHump) {
            let tableHump = utils.lineToHump(item.dict);
            let axios = fieldHump + "Init(){ this.$axios.get(this.$url +'/client/" + tableHump
                + "/list?page=0&pageSize=100').then((response) => {this."
                + fieldHump + "Dict=response.data.data.list;});},"
            return axios;
        },
        
        /**创建服务端 */
        createServer() {
            let formData = new FormData();
            let parameters = JSON.stringify(
                this.form.formData.paramTable
            );
            formData.append("parameters", parameters);
            formData.append("tableName", this.form.formData.tableName);
            formData.append("tableComment", this.form.formData.tableComment);
            formData.append("url", this.form.formData.url);
            this.$axios({
                url: this.$url + "admin/codeGeneration/writeServe",
                method: "POST",
                data: formData,
            });
        },
        init() {
            this.tableData = JSON.parse(localStorage.getItem('codeGeneration'));
        },
        /*添加表格条目*/
        addField() {
            let field = {
                field: "",
                name: "",
                type: "",
                query: false,
                queryType: '',
                dict: '',
                update: true,
                table: true,
                select: true
            };
            this.form.formData.paramTable.push(field);
        },
        /* 删除表格条目 */
        reduceField(scope) {
            this.form.formData.paramTable.splice(scope.$index)
        },
        /**
         * 构建Vue页面的搜索框
         * @param item
         * @param fieldHump
         * @param search_item
         */
        buildVueSearch(item,fieldHump,search_item){
            if (item.queryType === '数据表') {
                search_item += "<div class='search-item'>" + item.name + " : " +
                    "<el-select size='mini' v-model='search." + fieldHump + "' placeholder='通过" + item.name + "查询' clearable>" +
                    "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.name' :value='item.id'></el-option>"
                    + "</el-select></div>"
            } else if (item.queryType === '字典') {
                search_item += "<div class='search-item'>" + item.name + " : " +
                    "<el-select size='mini' v-model='search." + fieldHump + "' placeholder='通过" + item.name + "查询' clearable>" +
                    "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.content' :value='item.content'></el-option>"
                    + "</el-select></div>"
            } else {
                search_item += "<div class='search-item'>" + item.name + " : " +
                    "<el-input size='mini' v-model='search." + fieldHump + "' placeholder='通过" + item.name + "查询' clearable></el-input></div>";
            }
            return search_item;
        },
        /**
         * 构建Vue页面的表单
         * @param item
         * @param fieldHump
         * @param form_item
         */
        buildVueForm(item,fieldHump,form_item) {
            if (item.queryType === '数据表') {
                form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>" +
                    "<el-select size='mini' v-model='form." + fieldHump + "' placeholder='请选择' clearable>" +
                    "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.name' :value='item.id'></el-option>"
                    + "</el-select></el-form-item>"
            } else if (item.queryType === '字典') {
                form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>" +
                    "<el-select size='mini' v-model='form." + fieldHump + "' placeholder='请选择' clearable>" +
                    "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.content' :value='item.content'></el-option>"
                    + "</el-select></el-form-item>"
            } else {
                form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>" +
                    "<el-input placeholder='请输入" + item.name + "' v-model='form." + fieldHump + "' @change='isChange = true' size='small'></el-input></el-form-item>";
            }
            return form_item;
        },
        
        /**
         * 构建show方法内容
         * @param item
         * @param fieldHump
         * @param showInfo
         */
        buildVueShow(item, fieldHump, showInfo) {
            if(item.type==='bigint'){ // 时间戳
                showInfo += "this.showInfo.push({name: '" + item.name + "', value: this.$utils.formatDateTime( row." + fieldHump + ")});";
            }else{
                showInfo += "this.showInfo.push({name: '" + item.name + "', value: row." + fieldHump + "});";
            }
            return showInfo;
        },
        
    },
    mounted() {
        this.init();
    },
};
</script>

<style lang="less" scoped>
.tworice-column {
    margin-top: 10px;
}
</style>
