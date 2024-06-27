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
                        <el-button size="mini" type="warning" icon="el-icon-edit" circle
                                   @click="edit(scope.row)"></el-button>
                    </el-tooltip>
                    <el-tooltip content="删除">
                        <el-button size="mini" type="danger" icon="el-icon-delete" circle
                                   @click="del(scope.$index)"></el-button>
                    </el-tooltip>
                </template>
            </el-table-column>
        </el-table>
        
        <!-- 代码生成弹出层 -->
        <el-dialog :title="form.formTitle" :visible.sync="form.formVisible" width="70%"
                   :before-close="$utils.handleClose" :fullscreen="true">
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
                                <el-button :disabled="scope.$index<4"
                                           icon="el-icon-minus" circle @click="reduceField(scope)"></el-button>
                            </template>
                        </el-table-column>
                        <el-table-column prop="field" label="字段名">
                            <template slot-scope="scope">
                                <el-input :disabled="scope.$index<4" placeholder="请输入内容" size="mini"
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
                        <el-table-column prop="update" label="编辑" width="50">
                            <template slot-scope="scope">
                                <el-checkbox v-model="scope.row.update"></el-checkbox>
                            </template>
                        </el-table-column>
                        <el-table-column prop="dict" label="编辑表单" width="110">
                            <template slot-scope="scope">
                                <el-select size="mini" v-if="scope.row.update" v-model="scope.row.inputForm"
                                           placeholder="请选择">
                                    <el-option v-for="item in formInput" :key="item" :label="item"
                                               :value="item"></el-option>
                                </el-select>
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
export {default} from './codeGeneration';
</script>

<style lang="less" scoped>
.tworice-column {
    margin-top: 10px;
}
</style>
