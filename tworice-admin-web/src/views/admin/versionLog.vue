<template>
    <div class="app-body">
        <!-- 条件查询 -->
        <el-col :span="24" class="info-search-box">
            <div class="search">
                <div class='search-item'> 版本号 :
                    <el-input size="mini" v-model='search.version' placeholder='请输入版本号' clearable></el-input>
                </div>
                <div class='search-item'> 作者 :
                    <el-input size="mini" v-model='search.author' placeholder='请输入作者' clearable></el-input>
                </div>
                <div class="search-item">
                    <el-button type="primary" @click="toPage" size="mini">查询</el-button>
                </div>
            </div>
        </el-col>
        <el-col :span="24" class="button-box">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="add">新增</el-button>
        </el-col>
        <el-table size="mini" v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true"
                  :data="tableData" border style="width: 100%">
            <el-table-column type="index" label="序号"></el-table-column>
            <el-table-column prop='createTime' label='日期'
                             :formatter="(row)=>$utils.formatDate(row.createTime)"></el-table-column>
            <el-table-column prop='version' label='版本号'></el-table-column>
            <el-table-column prop='info' label='版本描述'>
                <template slot-scope="scope">
                    <div class="version-info">{{ scope.row.info }}</div>
                </template>
            </el-table-column>
            <el-table-column prop='author' label='作者'></el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" type="warning" icon="el-icon-edit" circle
                               @click.native="edit(scope.row)"></el-button>
                    <!-- <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button> -->
                </template>
            </el-table-column>
        </el-table>
        <el-col :span="24">
            <div class="page-box">
                <el-pagination :hide-on-single-page="true" @current-change="changePage" background
                               layout="prev, pager, next" :total="total" :page-size="pageSize"></el-pagination>
            </div>
        </el-col> <!-- 弹出层 -->
        <el-dialog :title="formTitle" :visible.sync="formVisible" width="30%" :before-close="$utils.handleClose">
            <el-form :model="form" ref="form">
                <el-form-item label='版本号' :label-width='formLabelWidth'>
                    <el-input placeholder='请输入版本号' v-model='form.version' @change='isChange = true'></el-input>
                </el-form-item>
                <el-form-item label='作者' :label-width='formLabelWidth'>
                    <el-input placeholder='请输入作者' v-model='form.author' @change='isChange = true'></el-input>
                </el-form-item>
                <el-form-item label='版本描述' :label-width='formLabelWidth'>
                    <el-input type="textarea" :rows="2" placeholder='请输入版本描述' v-model='form.info'
                              @change='isChange = true'></el-input>
                </el-form-item>
            
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="formVisible=false">取 消</el-button>
                <el-button type="primary" @click="submit">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="选择数据表格" :visible.sync="inductsVisible" width="30%" :before-close="$utils.handleClose">
            <el-form size="mini">
                <el-form-item label="选择表格" :label-width="formLabelWidth"><input type="file" class="file-left-input"
                                                                                    @change="inductsChange()"
                                                                                    ref="inducts" multiple
                                                                                    accept=".xls,.xlsx"/></el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="inductsVisible=false">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import paginationMixin from "@/mixins/paginationMixin";
export default {
    mixins: [paginationMixin],
    props: [],
    data() {
        return {
            form: {id: "", createTime: "", version: "", info: "", author: ""},
            search: {id: "", version: "", author: ""},
            pageUrlPath: '/client/versionLog'
        };
    },
    methods: {
    }

};
</script>
<style lang="less">
.version-info {
    // height: 50px;
    line-height: 25px;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
}
</style>