export default {
    data() {
        return {
            loading: true, // 表格加载状态
            page: 1, // 当前页码，从1开始
            pageSize: 10, // 每页数据容量
            total: 0, // 当前页数据条数
            tableData: [], // 当前页数据
            formTitle: "", // 编辑弹窗标题
            formVisible: false, // 编辑弹窗展示状态
            showVisible: false, // 查看弹窗展示状态
            inductsVisible: false, // 批量导入弹窗状态
            isChange: false, // 当前表单是否有更新
            formLabelWidth: "80px", // 弹出框标签宽度
            multipleSelection: [], // 当前多选框选中元素
            showInfo: [], // 详情数组
        };
    },
    methods:{
        /**
         * 打开新增窗口
         */
        add() {
            this.form = this.$options.data().form;
            this.formVisible = true;
            this.formTitle = "新增";
        },

        /**
         * 打开编辑窗口
         * @param row
         */
        edit(row) {
            this.form = row;
            this.formTitle = "编辑";
            this.formVisible = true;
            this.showAdmin = false;
        },

        /**
         * 监听页码发生变化
         */
        changePage(e) {
            this.page = e;
            this.toPage();
        },

        /**
         * 调整页面数据容量
         * @param size 容量
         */
        handleSizeChange(size) {
            this.pageSize = size;
            this.toPage();
        },

        /**
         * 初始化页面
         */
        init() {
            this.toPage();
        },

        /**
         * 下载批量导入模板
         */
        templateDownload() {
            window.open(this.$url + this.pageUrlPath + "/template");
        },

        /**
         * 点击批量导入
         */
        inducts() {
            this.inductsVisible = true;
        },
        /**
         * 多选框触发
         * @param val 当前所有选择的内容数组
         */
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        /**
         * 批量删除
         */
        delList() {
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
                    if (res.data.status.code === 200) {
                        this.toPage();
                    }
                })
            })
        },
        /**
         * 批量上传
         */
        inductsChange() {
            let files = this.$refs.inducts.files;/*获取选择的文件*/
            if (files.length !== 1) {
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
        },
        /**
         * 提交查询
         */
        submitSearch() {
            this.page = 1;
            this.toPage();
        },
        /**
         * 数据删除
         * @param row 行数据
         */
        del(row) {
            this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                this.$CRUD.del(this.pageUrlPath,{ids: row.id}).then(res => {
                    this.toPage();
                });
            });
        },
        /**
         * 根据条件和页码获取表格数据
         */
        toPage() {
            this.loading = true;
            this.$CRUD.list(this.pageUrlPath, this.page, this.pageSize, this.search).then(response => {
                this.tableData = response.data.data.list;
                this.total = response.data.data.total;
                this.loading = false;
            });
        },
        /**
         * 提交表单
         */
        submit() {
            this.$root.loading = true;
            this.$CRUD.submit(this.pageUrlPath,this.form).then(res => {
                if (res.data.status.code < 400) {
                    this.toPage();
                    this.formVisible = false;
                }

            });
        },
        /**
         * 初始化字典
         * 为了重写，这里空方法
         */
        initDist(){}
    },
    mounted() {
        this.init();
        this.initDist();
    }
};
