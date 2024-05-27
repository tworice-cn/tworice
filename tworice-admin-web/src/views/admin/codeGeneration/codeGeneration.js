import utils from '@/util/Utils.js'
import CodeGenUtils from "@/views/admin/codeGeneration/CodeGenUtils";
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
                        {field: "id", name: "编号", type: "int", query: true, queryType: '=', dict: '', update: false, table: true, select: true,inputForm:''},
                        {field: "create_time", name: "创建时间", type: "bigint", query: false, queryType: '', dict: '', update: false, table: true, select: false,inputForm:''},
                        {field: "update_time", name: "更新时间", type: "bigint", query: false, queryType: '', dict: '', update: false, table: false, select: false,inputForm:''},
                        {field: "creator", name: "创建人", type: "varchar(64)", query: true, queryType: '=', dict: '', update: false, table: false, select: true,inputForm:''},
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
                "<",
                "<=",
                ">",
                ">=",
                "不等于",
                "字典",
                "数据表"
            ],
            /**字典数据 */
            dict: [],
            formInput:[
                '普通输入框',
                '数字计数器',
                '开关',
                '日期选择器',
                '日期时间选择器'
            ],
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
                    table_item = CodeGenUtils.buildTableItem(item, fieldHump, table_item);
                }
                // 构建编辑表单
                if (item.update) {
                    form_item = CodeGenUtils.buildVueForm(item, fieldHump, form_item);
                }

                // 构建data中的form对象
                form += fieldHump + ":'',";
                // 构建data中的rules对象
                rules += fieldHump + ":[{ required: true, message: '请输入" + item.name + "', trigger: 'blur' }],";

                // 构建data中的search对象
                if (item.query && item.select) {
                    search += fieldHump + ":'',";
                    search_item = CodeGenUtils.buildVueSearch(item, fieldHump, search_item);
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
                select: true,
                inputForm:'普通输入框', // 编辑输入框表单类型
            };
            this.form.formData.paramTable.push(field);
        },
        /* 删除表格条目 */
        reduceField(scope) {
            this.form.formData.paramTable.splice(scope.$index,1)
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