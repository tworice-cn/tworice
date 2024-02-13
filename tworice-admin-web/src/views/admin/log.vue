<template>
    <div class="log app-body">
        <!-- 条件查询 -->
        <el-col :span="24" class="info-search-box">
            <div class="search">
                <div class='search-item'>操作人ID :
                    <el-input size='mini' v-model='search.userId' placeholder='请输入操作人ID' clearable></el-input>
                </div>
                <div class="search-item">
                    <el-button size="mini" type="primary" @click="submitSearch">查询</el-button>
                </div>
            </div>
        </el-col>
        <el-col :span="24" class="button-box">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="delList">批量删除</el-button>
            <el-button type="warning" icon="el-icon-download" size="mini" @click="exportLog">导出日志</el-button>
        </el-col>
        <el-table @selection-change="handleSelectionChange" size="mini" :header-cell-style="$setting.table_header"
                  :stripe="true" :fit="true" :data="tableData" border style="width: 100%">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column type="index" label="序号"></el-table-column>
            <el-table-column prop="createTime" label="时间"
                             :formatter="(row)=>$utils.formatDate(row.createTime)"></el-table-column>
            <el-table-column prop="userId" label="操作人"></el-table-column>
            <el-table-column prop="ipAddr" label="IP地址"></el-table-column>
            <el-table-column prop="active" label="操作日志" :cell-style="activeStyle"></el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button v-if="scope.row.tableName!=null && scope.row.tableName.length!=0" size="mini"
                               type="warning" icon="el-icon-refresh-left" circle
                               @click.native="recover(scope.row)"></el-button>
                    <el-button size="mini" type="danger" icon="el-icon-delete" circle
                               @click.native="del(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="page-box">
            <el-pagination @size-change="handleSizeChange" :small="true" :hide-on-single-page="true"
                           @current-change="changePage" background layout="total, sizes, prev, pager, next"
                           :total="total" :page-size="pageSize" :current-page="page"></el-pagination>
        </div>
    </div>
</template>

<script>
export default {
    props: [],
    data() {
        return {
            tableData: [],
            total: 0,
            pageSize: 20,// 每页的数量
            page: 1,// 页码，从零开始
            isChange: false,
            multipleSelection: [],
            search: {
                userId: ''
            }
        }
    },
    methods: {
        exportLog() {
            this.$axios.request({
                url: this.$url + '/admin/log/exportOperation?type=1',
                method: 'get',
                responseType: 'blob'
            }).then(res => {
                const data = res.data
                let url = window.URL.createObjectURL(data)   // 将二进制文件转化为可访问的url
                var a = document.createElement('a')
                document.body.appendChild(a)
                a.href = url
                a.download = '操作日志.xls'
                a.click()   // 模拟点击下载
                window.URL.revokeObjectURL(url)
            })
        },
        /**数据恢复 */
        recover(row) {
            this.$confirm('是否确定进行数据恢复?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let formData = new FormData();
                formData.append("id", row.id);
                this.$axios({
                    method: 'PUT',
                    data: formData,
                    url: this.$url + "admin/log/recover",
                }).then(res => {
                    if (res.data.status.code == 200) {
                        this.toPage();
                        
                    }
                })
            })
        },
        submitSearch() {
            this.page = 0;
            this.toPage();
        },
        handleSizeChange(size) {
            this.pageSize = size;
            this.toPage();
        },
        /**批量删除 */
        delList() {
            this.$confirm('此操作将永久删除信息, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let formData = new FormData();
                this.multipleSelection.forEach(item => {
                    formData.append("id", item.id);
                })
                formData.append("page", this.page);
                formData.append("pageSize", this.pageSize);
                
                this.$axios({
                    method: 'DELETE',
                    data: formData,
                    url: this.$url + "admin/log/delAdmin",
                }).then(
                    () => {
                        this.toPage();
                    }
                )
            })
        },
        del(row) {
            this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let formData = new FormData();
                formData.append("id", row.id);
                formData.append("page", this.page);
                formData.append("pageSize", this.pageSize);
                
                this.$axios({
                    method: 'DELETE',
                    data: formData,
                    url: this.$url + "admin/log/delAdmin",
                }).then(
                    () => {
                        this.toPage();
                    }
                )
            })
        },
        /**监听页码发生变化 */
        changePage(e) {
            this.page = e;
            this.toPage();
        },
        /**请求当前页码的数据 */
        toPage() {
            this.loading = true;
            let param = "";
            Object.entries(this.search).forEach(([key, value]) => {
                if (value) {
                    param += `&${key}=${value}`;
                }
            });
            
            this.$axios.get(this.$url + '/admin/log/adminList?pageSize=' + this.pageSize + '&page=' + this.page + param).then(
                response => {
                    this.tableData = response.data.data.list;
                    this.total = response.data.data.total;
                    this.loading = false;
                }
            )
        },
        init() {
            this.toPage();
        },
        /**选择框 val为当前所有选择的内容数组 */
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        activeStyle() {
            return "-webkit-box-orient: vertical;height: 44px;line-height: 22px;overflow: hidden;display: -webkit-box;text-overflow: ellipsis;-webkit-line-clamp: 2;";
        }
    },
    mounted() {
        this.init();
    }
};
</script>

<style lang="less">
.page-box {
    padding: 20px 0;
    text-align: right;
}
</style>