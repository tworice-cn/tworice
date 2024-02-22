<template>
    <div class="app-body">
        <el-col :span="24" class="department">
            <el-col :span="24" class="department-main">
                <el-col :span="12" class="department-list">
                    <span class="title">部门列表</span>
                    <el-col :span="24" class="department-content">
                        <el-col :span="24" class="department-add">
                            <el-button size="mini" type="primary" icon="el-icon-plus"
                                       @click.native="editDepartment({id:-1,departmentName:''},2)">添加部门
                            </el-button>
                        </el-col>
                        <el-col :span="24">
                            <el-table size="mini" class="department-table" :header-cell-style="$setting.table_header"
                                      v-loading="departmentLoad" :data="departments" style="width: 100%"
                                      ref="departmentTable" highlight-current-row @current-change="handleCurrentChange">
                                <el-table-column prop="departmentName" label="部门名称"></el-table-column>
                                <el-table-column label="操作">
                                    <template slot-scope="scope">
                                        <el-tooltip content="编辑">
                                            <el-button size="mini" icon="el-icon-edit"
                                                       @click.native="editDepartment(scope.row,1)" type="info"
                                                       circle></el-button>
                                        </el-tooltip>
                                        <el-tooltip content="删除">
                                            <el-button size="mini" icon="el-icon-delete"
                                                       @click.native="delDepartment(scope.row)" type="danger"
                                                       circle></el-button>
                                        </el-tooltip>
                                        <el-tooltip content="调动记录">
                                            <el-button size="mini" icon="el-icon-view"
                                                       @click.native="showLog(scope.row)" type="primary"
                                                       circle></el-button>
                                        </el-tooltip>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </el-col>
                    </el-col>
                </el-col>
                <el-col :span="12" class="department-setUser">
                    <span class="title">设置人员</span>
                    <el-col :span="24" class="department-content" v-if="currentDepartment">
                        <el-col :span="24" class="department-add">
                            <el-button size="mini" type="primary" icon="el-icon-edit" @click.native="addUser">设置人员
                            </el-button>
                        </el-col>
                        <el-col :span="24">
                            <el-table :header-cell-style="$setting.table_header" v-loading="adminLoad"
                                      empty-text="当前部门无人员" :data="admins" style="width: 100%"
                                      ref="departmentTable">
                                <el-table-column prop="nickName" label="人员姓名"></el-table-column>
                                <el-table-column prop="loginName" label="人员账号"></el-table-column>
                            </el-table>
                        </el-col>
                    </el-col>
                    <el-col :span="24" class="department-content" v-else>
                        请选择部门
                    </el-col>
                </el-col>
            </el-col>
            
            <!-- 弹出层 -->
            <el-dialog :title="'当前部门：'+this.currentDepartment.departmentName" :visible.sync="addUserDialog"
                       width="50%" :before-close="$utils.handleClose">
                <div class="userTransfer">
                    <!-- 穿梭框 -->
                    <el-transfer filterable filter-placeholder="请输入人员名称" :button-texts="[ '移除人员','添加人员']"
                                 v-model="selectUserList" :data="userList" :titles="['未选人员', '已选人员']"
                                 @change="adminChange"></el-transfer>
                </div>
                
                <span slot="footer" class="dialog-footer">
                              <el-button @click="addUserDialog = false">取 消</el-button>
                        </span>
            </el-dialog>
            
            <el-dialog title="调动记录" :visible.sync="resourceDialog" width="60%" top="5vh"
                       :before-close="$utils.handleClose">
                <DepartLog v-if="resourceDialog" :id="currentDepartment.id"></DepartLog>
            </el-dialog>
            
            <el-dialog title="设置部门" :visible.sync="departmentDialog" width="40%" :before-close="$utils.handleClose">
                <b>请输入部门名 :</b>
                <el-input v-model="departmentForm.id" type="hidden"></el-input>
                <el-input v-model="departmentForm.departmentName" placeholder="请输入部门名" maxlength="8"
                          show-word-limit></el-input>
                
                <span slot="footer" class="dialog-footer">
                              <el-button @click="departmentDialog = false" type="primary"
                                         @click.native="submitDepartment">确 认</el-button>
                        </span>
            </el-dialog>
        </el-col>
    </div>
</template>

<script>
import DepartLog from './systemDeployLog.vue'

export default {
    components: {
        DepartLog
    },
    props: [],
    data() {
        return {
            departments: [],// 部门列表
            currentDepartment: {"departmentName": ''},// 当前选中部门行
            admins: [],// 人员列表
            adminLoad: false,
            departmentLoad: false,
            addUserDialog: false,// 设置人员
            resourceDialog: false,// 管理权限
            departmentDialog: false,// 编辑或添加 弹框
            userList: [],// 部门待选人员
            selectUserList: [],// 部门已选人员
            resourceDefaultProps: { // 自定义权限管理 属性名称
                children: 'list',
                label: 'name'
            },
            resourceTree: [],
            defaultChecked: [],// 默认选中 ID
            treeLoad: false,
            departmentForm: {
                id: -1,
                departmentName: ''
            }
            
        }
    },
    methods: {
        showLog(row) {
            this.currentDepartment = row;
            this.resourceDialog = true;
        },
        init() {
            this.departmentLoad = true;
            this.$axios.get(this.$url + 'admin/system/department/list').then(
                response => {
                    if (response.data.status.code == 200) {
                        this.departments = response.data.data.departmentList;
                    }
                    this.departmentLoad = false;
                }
            )
        },
        // 点击部门行
        handleCurrentChange(row) {
            this.adminLoad = true;
            this.currentDepartment = row;
            this.$axios.get(this.$url + 'admin/system/department/adminList?departmentId=' + row.id).then(
                response => {
                    if (response.data.status.code == 200) {
                        this.admins = response.data.data.adminList;
                    }
                    this.adminLoad = false;
                }
            )
        },
        // 多选框
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        // 为当前部门添加人员
        addUser() {
            this.addUserDialog = true;
            this.$axios.get(this.$url + '/admin/system/department/getNoDepartmentAdmin?departmentId=' + this.currentDepartment.id).then(response => {
                
                // 初始化待选人员
                let result = [];
                response.data.data.result.forEach(
                    item => {
                        let obj = {
                            key: item.id,
                            label: item.nickName,
                            loginName: item.loginName
                        }
                        result.push(obj);
                    }
                )
                this.userList = result;
                // 初始化已选中人员
                result = [];
                this.admins.forEach(
                    item => {
                        result.push(item.id);
                    }
                )
                this.selectUserList = result;
            })
        },
        /**
         * 设置部门人员 穿梭框中的内容被改变后触发
         * direction 判断是左穿梭框还是右穿梭框
         * value 当前选中穿梭框的ID数组内容
         * movedKeys 被移动的ID
         */
        adminChange(value, direction, movedKeys) {
            if (direction == 'right') {
                let format = new FormData();
                movedKeys.forEach(
                    item => {
                        format.append("userId", item);
                    }
                )
                format.append("departmentId", this.currentDepartment.id);
                // 添加人员
                this.$axios({
                    method: 'put',
                    url: this.$url + 'admin/system/department/adminToDepartment',
                    data: format
                }).then(
                    () => {
                        
                        // 刷新右侧人员列表
                        this.handleCurrentChange(this.currentDepartment);
                    }
                )
            } else {
                // 移除人员
                let format = new FormData();
                movedKeys.forEach(
                    item => {
                        format.append("adminIds", item);
                    }
                )
                format.append("departmentId", this.currentDepartment.id);
                
                this.$axios({
                    method: 'delete',
                    url: this.$url + 'admin/system/department/rmAdminToDepartment',
                    data: format
                }).then(
                    () => {
                        
                        // 刷新右侧人员列表
                        this.handleCurrentChange(this.currentDepartment);
                    }
                )
            }
        },
        /**管理权限 */
        editResource(row) {
            this.treeLoad = true;
            this.resourceDialog = true; // 打开窗口
            
            // 查询当前部门拥有的资源
            this.$axios.get(this.$url + "admin/system/department/resourcesByDepartment?departmentId=" + row.id).then(
                response => {
                    let checked = [];
                    response.data.data.result.forEach(
                        item => {
                            checked.push(item.resourceId);
                        }
                    )
                    this.defaultChecked = checked; // 设置默认选中
                    // 设置所有资源
                    let resources = window.localStorage.getItem("resources");
                    resources = JSON.parse(resources);
                    this.resourceTree = resources;
                    this.treeLoad = false;
                }
            )
        },
        /**
         * 提交部门权限
         */
        submitResource() {
            // this.$root.loading=true;
            
            let checkedKeys = [];// 选中的叶子节点（页面）
            
            this.$refs.resourceTree.getCheckedNodes().forEach(
                item => {
                    // 获取页面节点
                    if (item.type == 2) {
                        checkedKeys.push(item.id);
                    }
                }
            )
            // 如果更新后的权限列表和原权限列表相同的 则不提交至后台
            if (checkedKeys.sort().toString() == this.defaultChecked.sort().toString()) {
                return;
            } else {
                // 构建参数
                let formData = new FormData();
                checkedKeys.forEach(item => {
                    formData.append("resourcesId", item);
                })
                formData.append("departmentId", this.currentDepartment.id);
                
                // 发起请求
                this.$axios({
                    method: 'put',
                    url: this.$url + 'admin/system/department/updateResources',
                    data: formData
                })
            }
            
        },
        /**
         * 编辑部门
         */
        editDepartment(row, i) {
            this.departmentForm = row;
            if (i == 1) {
                this.departmentDialog = true;
            } else {
                // 添加
                this.departmentDialog = true;
            }
            
        },
        /**提交部门 */
        submitDepartment() {
            this.$root.loading = true;
            let format = new FormData();
            format.append("departmentId", this.departmentForm.id);
            format.append("departmentName", this.departmentForm.departmentName)
            
            this.$axios({
                method: 'put',
                url: this.$url + "admin/system/department/editDepartment",
                data: format
            }).then(
                response => {
                    this.departments = response.data.data.departmentList;
                }
            )
        },
        /**删除部门 */
        delDepartment(row) {
            this.$confirm('您确认删除部门' + row.departmentName + '吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let format = new FormData();
                format.append("departmentId", row.id);
                this.$axios({
                    method: 'delete',
                    url: this.$url + 'admin/system/department/delDepartment',
                    data: format
                }).then(
                    () => {
                        this.init();
                    }
                )
            })
            
        },
    },
    mounted() {
        this.init();
    }
};
</script>

<style lang="less" scoped>

.department {
    padding-top: 20px;
    
    .department-main {
        //      padding-top: 30px;
        //      box-sizing: border-box;
        font-size: 14px;
        
        .title {
            font-weight: 700;
        }
        
        .department-list {
            padding-right: 20px;
        }
        
        .department-setUser {
            padding-left: 20px;
        }
        
        .department-content {
            .department-add {
                padding: 20px 0 10px 0;
            }
        }
    }
}


</style>