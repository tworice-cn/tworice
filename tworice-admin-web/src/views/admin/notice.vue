<template>
    <div class="notice app-body">
        <el-col :span="24" class="info-search-box">
            <el-form class="search" @submit.native.prevent="submitSearch">
                <div class='search-item'>标题 :
                    <el-input size='mini' v-model='search.title' placeholder='请输入标题' clearable></el-input>
                </div>
                <div class="search-item">
                    <el-button size="mini" type="primary" @click="submitSearch" native-type="submit">查询</el-button>
                </div>
            </el-form>
        </el-col>
        <el-col :span="24" class="notice-list">
            <el-col :span="24" class="button-box">
                <el-button type="primary" icon="el-icon-plus" size="mini" @click.native="add">添加</el-button>
            </el-col>
            <el-table size="mini" border v-loading="loading" :data="tableData" stripe style="width: 100%"
                      :header-cell-style="$setting.table_header">
                <el-table-column type="index" label="序号"></el-table-column>
                <el-table-column prop="createTime" label="创建日期"
                                 :formatter="(row)=>$utils.formatDate(row.createTime)"></el-table-column>
                <el-table-column prop="updateTime" label="更新日期"
                                 :formatter="(row)=>$utils.formatDate(row.updateTime)"></el-table-column>
                <el-table-column prop="title" label="标题"></el-table-column>
                <el-table-column prop="nickName" label="发布者"></el-table-column>
                <el-table-column prop="top" label="置顶" width="100">
                    <template slot-scope="scope">
                        <el-switch @change="topChange(scope.row)" v-model="scope.row.top" active-color="#13ce66"
                                   inactive-color="#ff4949" :active-value='1' :inactive-value='0'></el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-tooltip content="查看">
                            <el-button size="mini" icon="el-icon-view" @click.native="showNotice(scope.row)"
                                       type="primary" circle></el-button>
                        </el-tooltip>
                        <el-tooltip content="编辑">
                            <el-button size="mini" icon="el-icon-edit" @click.native="edit(scope.row)" type="info"
                                       circle></el-button>
                        </el-tooltip>
                        <el-tooltip content="删除">
                            <el-button size="mini" icon="el-icon-delete" @click.native="del(scope.row)"
                                       type="danger" circle></el-button>
                        </el-tooltip>
                        <el-tooltip content="跳转">
                            <el-button size="mini" icon="el-icon-link" @click.native="linkNotice(scope.row)"
                                       type="success" circle></el-button>
                        </el-tooltip>
                    </template>
                </el-table-column>
            </el-table>
            <div class="page-box">
                <el-pagination @current-change="changePage" background layout="total,prev, pager, next" :total="total"
                               :page-size="pageSize"></el-pagination>
            </div>
        </el-col>
        
        <!-- 弹出层 -->
        <el-dialog title="通知" :visible.sync="formVisible" width="60%" :before-close="$utils.handleClose">
            <el-form :model="form">
                <el-form-item label="标题:">
                    <el-input :validate-event="true" :show-word-limit="true" minlength="2" maxlength="16"
                              v-model="form.title" size="small" placeholder="请输入通知标题"></el-input>
                </el-form-item>
                <el-form-item label="置顶:">
                    <el-switch active-text="是" inactive-text="否" v-model="form.top" active-color="#13ce66"
                               inactive-color="#ff4949" :active-value='1' :inactive-value='0'></el-switch>
                </el-form-item>
                <el-form-item label="">
                    <Editor ref="editor" v-model="form.content"></Editor>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                        <el-button @click="formVisible = false">取 消</el-button>
                        <el-button type="primary" @click="submit">确 定</el-button>
                  </span>
        </el-dialog>
        
        <el-dialog title="通知公告" :visible.sync="showVisible" width="60%" :before-close="$utils.handleClose">
            <Descriptions :value="descriptions"></Descriptions>
            <span slot="footer" class="dialog-footer">
                        <el-button @click="showVisible = false">关 闭</el-button>
                  </span>
        </el-dialog>
    </div>
</template>

<script>
import Editor from '@/components/commons/Editor.vue'
import Descriptions from '@/components/commons/Descriptions.vue'
import paginationMixin from "@/mixins/paginationMixin";

export default {
    mixins: [paginationMixin],
    components: {
        Editor,
        Descriptions
    },
    props: [],
    data() {
        return {
            descriptions: [],
            search_name: '',//
            form: {
                id: '',
                title: '',
                top: 0,
                content: '<p>这是初始化内容</p>'
            },
            search: {
                title: ''
            },
            pageUrlPath:'/admin/notice'
        }
    },
    methods: {
        linkNotice(row) {
            this.$router.push('/infra/showNotice?id=' + row.id)
        },
        showNotice(row) {
            this.descriptions = [];
            this.descriptions.push({name: '编号', value: row.id});
            this.descriptions.push({name: '创建日期', value: this.$utils.formatDateTime(row.createTime)});
            this.descriptions.push({name: '更新日期', value: this.$utils.formatDateTime(row.updateTime)});
            this.descriptions.push({name: '发布者', value: row.nickName});
            this.descriptions.push({name: '标题', value: row.title});
            this.descriptions.push({name: '内容', value: row.content});
            this.showVisible = true;
        },
        /**是否置顶状态发生变化 */
        topChange(row) {
            this.$root.loading = true;
            let format = new FormData();
            format.append("id", row.id);
            format.append("top", row.top);
            this.$axios({
                method: 'put',
                url: this.$url + "admin/notice/setStatus",
                data: format
            })
        },
    }
};
</script>