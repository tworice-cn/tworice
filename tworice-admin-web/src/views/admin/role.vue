<template>
    <div class="app-body">
        <el-col :span="24" class="role">
            <el-col :span="24" class="role-main">
                <el-col :span="12" class="role-list">
                    <span class="title">角色列表</span>
                    <el-col :span="24" class="role-content">
                        <el-col :span="24" class="role-add">
                            <el-button size="mini" type="primary" icon="el-icon-plus"
                                       @click.native="editRole({id:-1,roleName:''},2)">添加角色
                            </el-button>
                        </el-col>
                        <el-col :span="24">
                            <el-table size="mini" class="role-table" :header-cell-style="$setting.table_header"
                                      v-loading="roleLoad" :data="roles" style="width: 100%" ref="roleTable"
                                      highlight-current-row @current-change="handleCurrentChange">
                                <el-table-column prop="roleName" label="角色名称"></el-table-column>
                                <el-table-column label="操作">
                                    <template slot-scope="scope">
                                        <el-tooltip content="权限管理">
                                            <el-button size="mini" type="primary" icon="el-icon-set-up"
                                                       @click.native="editResource(scope.row)" circle></el-button>
                                        </el-tooltip>
                                        <el-tooltip content="编辑">
                                            <el-button size="mini" icon="el-icon-edit"
                                                       @click.native="editRole(scope.row,1)" type="info"
                                                       circle></el-button>
                                        </el-tooltip>
                                        <el-tooltip content="删除">
                                            <el-button size="mini" icon="el-icon-delete"
                                                       @click.native="delRole(scope.row)" type="danger"
                                                       circle></el-button>
                                        </el-tooltip>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </el-col>
                    </el-col>
                </el-col>
                <el-col :span="12" class="role-setUser">
                    <span class="title">设置人员</span>
                    <el-col :span="24" class="role-content" v-if="currentRole">
                        <el-col :span="24" class="role-add">
                            <el-button size="mini" type="primary" icon="el-icon-edit" @click.native="addUser">设置人员
                            </el-button>
                        </el-col>
                        <el-col :span="24">
                            <el-table :header-cell-style="$setting.table_header" v-loading="adminLoad"
                                      empty-text="当前角色无人员" :data="admins" style="width: 100%" ref="roleTable">
                                <el-table-column prop="nickName" label="人员姓名"></el-table-column>
                                <el-table-column prop="loginName" label="人员账号"></el-table-column>
                            </el-table>
                        </el-col>
                    </el-col>
                    <el-col :span="24" class="role-content" v-else>
                        请选择角色
                    </el-col>
                </el-col>
            </el-col>
            
            <!-- 弹出层 -->
            <el-dialog :title="'当前角色：'+this.currentRole.roleName" :visible.sync="addUserDialog" width="50%"
                       :before-close="$utils.handleClose">
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
            
            <el-dialog title="管理权限" :visible.sync="resourceDialog" width="40%" top="5vh"
                       :before-close="$utils.handleClose">
                <el-tree v-loading="treeLoad" ref="resourceTree" :data="resourceTree" show-checkbox node-key="id"
                         :default-expand-all="true" :default-checked-keys="defaultChecked"
                         :props="resourceDefaultProps"></el-tree>
                
                <span slot="footer" class="dialog-footer">
                              <el-button @click="resourceDialog = false" type="primary" @click.native="submitResource">确 认</el-button>
                        </span>
            </el-dialog>
            
            <el-dialog title="设置角色" :visible.sync="roleDialog" width="40%" :before-close="$utils.handleClose">
                <b>请输入角色名 :</b>
                <el-input v-model="roleForm.id" type="hidden"></el-input>
                <el-input v-model="roleForm.roleName" placeholder="请输入角色名" maxlength="8"
                          show-word-limit></el-input>
                
                <span slot="footer" class="dialog-footer">
                              <el-button @click="roleDialog = false" type="primary"
                                         @click.native="submitRole">确 认</el-button>
                        </span>
            </el-dialog>
        </el-col>
    </div>
</template>

<script>
export default {
    props: [],
    data() {
        return {
            roles: [],// 角色列表
            currentRole: {"roleName": ''},// 当前选中角色行
            admins: [],// 人员列表
            adminLoad: false,
            roleLoad: false,
            addUserDialog: false,// 设置人员
            resourceDialog: false,// 管理权限
            roleDialog: false,// 编辑或添加 弹框
            userList: [],// 角色待选人员
            selectUserList: [],// 角色已选人员
            resourceDefaultProps: { // 自定义权限管理 属性名称
                label: 'name'
            },
            resourceTree: [],
            defaultChecked: [],// 默认选中 ID
            treeLoad: false,
            roleForm: {
                id: -1,
                roleName: ''
            }
            
        }
    },
    methods: {
        init() {
            this.roleLoad = true;
            this.$axios.get(this.$url + 'admin/system/role/list').then(
                response => {
                    if (response.data.status.code == 200) {
                        this.roles = response.data.data.roleList;
                    }
                    this.roleLoad = false;
                }
            )
        },
        // 点击角色行
        handleCurrentChange(row) {
            this.adminLoad = true;
            this.currentRole = row;
            this.$axios.get(this.$url + 'admin/system/role/adminList?roleId=' + row.id).then(
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
        // 为当前角色添加人员
        addUser() {
            this.addUserDialog = true;
            // 获取不是该角色的人员
            this.$axios.get(this.$url + 'admin/system/role/getAdminByStatus?status=0').then(
                response => {
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
                }
            )
        },
        /**
         * 设置角色人员 穿梭框中的内容被改变后触发
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
                format.append("roleId", this.currentRole.id);
                // 添加人员
                this.$axios({
                    method: 'put',
                    url: this.$url + 'admin/system/role/adminToRole',
                    data: format
                }).then(
                    () => {
                        
                        // 刷新右侧人员列表
                        this.handleCurrentChange(this.currentRole);
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
                format.append("roleId", this.currentRole.id);
                
                this.$axios({
                    method: 'delete',
                    url: this.$url + 'admin/system/role/rmAdminToRole',
                    data: format
                }).then(
                    () => {
                        
                        // 刷新右侧人员列表
                        this.handleCurrentChange(this.currentRole);
                    }
                )
            }
        },
        /**管理权限 */
        editResource(row) {
            this.treeLoad = true;
            this.resourceDialog = true; // 打开窗口
            
            // 查询当前角色拥有的资源
            this.$axios.get(this.$url + "admin/system/role/resourcesByRole?roleId=" + row.id).then(
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
                    console.log(resources)
                    this.resourceTree = resources;
                    this.treeLoad = false;
                }
            )
        },
        /**
         * 提交角色权限
         */
        submitResource() {
            this.$confirm('此操作可能会导致系统功能无法访问，是否继续？', '是否确认覆盖权限', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
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
                    formData.append("roleId", this.currentRole.id);
                    
                    // 发起请求
                    this.$axios({
                        method: 'put',
                        url: this.$url + 'admin/system/role/updateResources',
                        data: formData
                    })
                }
            })
        },
        /**
         * 编辑角色
         */
        editRole(row, i) {
            this.roleForm = row;
            if (i == 1) {
                this.roleDialog = true;
            } else {
                // 添加
                this.roleDialog = true;
            }
            
        },
        /**提交角色 */
        submitRole() {
            this.$root.loading = true;
            let format = new FormData();
            format.append("roleId", this.roleForm.id);
            format.append("roleName", this.roleForm.roleName)
            
            this.$axios({
                method: 'put',
                url: this.$url + "admin/system/role/editRole",
                data: format
            }).then(
                response => {
                    this.roles = response.data.data.roleList;
                    this.roleDialog = false;
                }
            )
        },
        /**删除角色 */
        delRole(row) {
            this.$confirm('您确认删除角色' + row.roleName + '吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$root.loading = true;
                let format = new FormData();
                format.append("roleId", row.id);
                this.$axios({
                    method: 'delete',
                    url: this.$url + 'admin/system/role/delRole',
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

.role {
    padding-top: 20px;
    
    .role-main {
        //      padding-top: 30px;
        //      box-sizing: border-box;
        font-size: 14px;
        
        .title {
            font-weight: 700;
        }
        
        .role-list {
            padding-right: 20px;
        }
        
        .role-setUser {
            padding-left: 20px;
        }
        
        .role-content {
            .role-add {
                padding: 20px 0 10px 0;
            }
        }
    }
}


</style>