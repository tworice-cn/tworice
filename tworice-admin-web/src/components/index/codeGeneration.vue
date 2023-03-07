<template>
      <div class="app-body">
            <el-button type="primary" @click="add">代码生成</el-button>
            
            <!-- 弹出层 -->
            <el-dialog :title="form.formTitle" :visible.sync="form.formVisible" width="70%" :before-close="cancel">
                  <el-form :model="form.formData" size="mini" :rules="form.rules" ref="form.formData">
                        <el-form-item label="表名称" :label-width="form.formLabelWidth" prop="tableName">
                              <el-input placeholder="请输入内容" v-model="form.formData.tableName"></el-input>
                        </el-form-item>
                        <el-form-item label="表注释" :label-width="form.formLabelWidth" prop="tableComment">
                              <el-input placeholder="请输入内容" v-model="form.formData.tableComment"></el-input>
                        </el-form-item>
                        <el-form-item label="表字段" :label-width="form.formLabelWidth">
                              <el-table :data="form.formData.paramTable" style="width: 100%" size="mini">
                                    <el-table-column prop="field" label="" width="50">
                                          <template slot-scope="scope">
                                                <el-button :disabled="scope.row.field=='id' || scope.row.field=='create_time'" icon="el-icon-minus" circle @click="reduceField(scope)"></el-button>
                                          </template>
                                    </el-table-column>
                                    <el-table-column prop="field" label="字段名">
                                          <template slot-scope="scope">
                                                <el-input :disabled="scope.row.field=='id'" placeholder="请输入内容" size="mini" v-model="scope.row.field" ></el-input>
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
                                                      <el-option v-for="item in typeList" :key="item" :label="item" :value="item"></el-option>
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
                                                <el-select v-model="scope.row.queryType" @change="queryTypeChange" placeholder="请选择" :disabled="!scope.row.query">
                                                      <el-option v-for="item in queryType" :key="item" :label="item" :value="item"></el-option>
                                                </el-select>
                                          </template>
                                    </el-table-column>
                                    <el-table-column  prop="dist" label="字典" width="110">
                                          <template slot-scope="scope">
                                                <el-select size="mini" v-if="scope.row.queryType=='字典'||scope.row.queryType=='数据表'" v-model="scope.row.dist" placeholder="请选择" :disabled="!scope.row.query">
                                                      <el-option v-for="item in dist" :key="item.id" :label="item.name" :value="item.id"></el-option>
                                                </el-select>
                                          </template>
                                    </el-table-column>
                                    <el-table-column prop="update" label="更新" width="80">
                                          <template slot-scope="scope">
                                                <el-checkbox v-model="scope.row.update"></el-checkbox>
                                          </template>
                                    </el-table-column>
                              </el-table>
                              <el-button class="tworice-column" size="mini" type="primary" round icon="el-icon-plus" @click="addField"></el-button>
                        </el-form-item>
                        <el-form-item label="Vue页面" :label-width="form.formLabelWidth" prop="tableName">
                              <el-input placeholder="请输入Vue文件名称" v-model="form.formData.pageName"></el-input>
                        </el-form-item>
                        <el-form-item label="请求地址" :label-width="form.formLabelWidth" prop="tableName">
                              <el-input placeholder="如:/client/test" v-model="form.formData.url"></el-input>
                        </el-form-item>
                        <el-form-item label="创建服务" :label-width="form.formLabelWidth">
                              <el-switch v-model="form.formData.createServer" active-color="#13ce66" inactive-color="#ff4949"></el-switch>
                        </el-form-item>
                        <el-form-item label="创建Vue" :label-width="form.formLabelWidth">
                              <el-switch v-model="form.formData.createVue" active-color="#13ce66" inactive-color="#ff4949"></el-switch>
                        </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="cancel">取 消</el-button>
                        <el-button type="primary" @click="submit" :disabled="!(form.formData.createVue || form.formData.createServer)">确 定</el-button>
                  </div>
            </el-dialog>
      </div>
</template>

<script>
import utils from '@/core/utils.js'
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
                              tableComment:[
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
                              tableComment:"",/**表注释 */
                              paramTable: [
                                    { field: "id", name: "编号", type: "int", query:true,queryType:'=',dist:'',update:false},
                                    { field: "create_time", name: "创建时间", type: "bigint", query:false,queryType:'',dist:'',update:false},
                                    { field: "update_time", name: "更新时间", type: "bigint", query:false,queryType:'',dist:'',update:false},
                                    { field: "creator", name: "创建人", type: "varchar(64)", query:true,queryType:'=',dist:'',update:false},
                              ],
                              pageName: "" /**页面名称 */,
                              url: "/client/",
                              createServer: false,
                              createVue:true
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
                  ],
                  /**查询类型 */
                  queryType:[
                        "=",
                        "LIKE",
                        "字典",
                        "数据表"
                  ],
                  /**字典数据 */
                  dist:[],
                  /**数据表 */
                  tables:[]
            };
      },
      methods: {
            queryTypeChange(val){
                  if(val=='字典'){
                        this.initDist();
                  }else if(val=='数据表'){
                        this.initTables();
                  }
            },
            initTables(){
                  this.$axios.get(
                              this.$url+"admin/codeGeneration/tables"
                        ).then((response) => {
                              this.dist = response.data.data.list;
                        });
            },
            initDist(){
                  this.$axios.get(
                              this.$url+"/admin/dist/list?page=0&pageSize=100"
                        ).then((response) => {
                              this.dist = response.data.data.list;
                        });
            },
            add() {
                  this.form.formVisible = true;
                  this.form.formData = this.$options.data().form.formData;

                  this.initDist();
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
                  this.$root.loading=true;

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
                  let search="";
                  // 构建searchItem
                  let search_item="";
                  // 构建data中的各dist
                  let dist=""
                  // 构建各dist初始化方法
                  let initDist=""
                  // 构建调用各dist方法的
                  let initDists=""

                  // 表字段设置
                  this.form.formData.paramTable.forEach((item) => {
                        let fieldHump=utils.lineToHump(item.field);
                        // 构建展示表格
                        let time='';
                        if(item.field=='create_time'){
                              time=":formatter='(row)=>formatDate(row.createTime)'";
                        }else if(item.field=='update_time'){
                              time=":formatter='(row)=>formatDate(row.updateTime)'";
                        }
                        table_item += "<el-table-column prop='" + fieldHump + "' label='" + item.name + "' " + time + "></el-table-column>";

                        // 构建表单
                        if (item.field != "id" && item.field != "create_time" && item.field != 'update_time') {
                              if(item.queryType=='数据表'){
                                    form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>"+
                                          "<el-select size='mini' v-model='form."+fieldHump+"' placeholder='请选择' clearable>"+
                                                "<el-option v-for='item in "+fieldHump+"Dist' :key='item.id' :label='item.content' :value='item.id'></el-option>"
                                                +"</el-select></el-form-item>"
                              }else if(item.queryType=='字典'){
                                    form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>"+
                                          "<el-select size='mini' v-model='form."+fieldHump+"' placeholder='请选择' clearable>"+
                                                "<el-option v-for='item in "+fieldHump+"Dist' :key='item.id' :label='item.content' :value='item.content'></el-option>"
                                                +"</el-select></el-form-item>"
                              }else{
                                    form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>"+
                                          "<el-input placeholder='请输入"+item.name+"' v-model='form." + fieldHump + "' @change='isChange = true' size='small'></el-input></el-form-item>";
                              }
                        }

                        // 构建data中的form对象
                        form += fieldHump + ":'',";
                        // 构建data中的rules对象
                        rules += fieldHump + ":[{ required: true, message: '请输入" + item.name + "', trigger: 'blur' }],";

                        // 构建data中的search对象
                        if(item.query){
                              search+=fieldHump+":'',";
                              if(item.queryType=='数据表'){
                                    search_item+="<div class='search-item'>"+item.name+" : "+
                                          "<el-select size='mini' v-model='search."+fieldHump+"' placeholder='通过"+item.name+"查询' clearable>"+
                                                "<el-option v-for='item in "+fieldHump+"Dist' :key='item.id' :label='item.name' :value='item.id'></el-option>"
                                          +"</el-select></div>"
                              }else if(item.queryType=='字典'){
                                    search_item+="<div class='search-item'>"+item.name+" : "+
                                          "<el-select size='mini' v-model='search."+fieldHump+"' placeholder='通过"+item.name+"查询' clearable>"+
                                                "<el-option v-for='item in "+fieldHump+"Dist' :key='item.id' :label='item.content' :value='item.content'></el-option>"
                                          +"</el-select></div>"
                              }else{
                                    search_item+="<div class='search-item'>"+item.name+" : "+
                                          "<el-input size='mini' v-model='search."+fieldHump+"' placeholder='通过"+item.name+"查询' clearable></el-input></div>";
                              }
                        }
                        
                        // 判断是否选择了字典
                        if(item.queryType=='字典'){
                              dist+=fieldHump+"Dist:[],"
                              initDist+=this.buildInitDist(item,fieldHump)
                              initDists+='this.'+fieldHump+"Init();"
                        }else if(item.queryType=='数据表'){
                              dist+=fieldHump+"Dist:[],";
                              initDist+=this.buildTableDist(item,fieldHump);
                              initDists+='this.'+fieldHump+"Init();";
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
                  formData.append("dist",dist);
                  formData.append("initDist",initDist);
                  formData.append("initDists",initDists);
                  // formData.append("createServer", this.form.formData.createServer);

                  if(this.form.formData.createVue){
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
                  }else if(this.form.formData.createServer) {
                        this.createServer();
                  }else{
                        this.$root.loading=false;
                  }
            },
            /**构建字典 */
            buildInitDist(item,fieldHump){
                  let axios=fieldHump+"Init(){ this.$axios.get(this.$url +'/admin/distValue/list?page=0&pageSize=100&dist="
                        +item.dist+"').then((response) => {this."
                        +fieldHump+"Dist=response.data.data.list;});},"
            
                  return axios;
            },
            /*构建数据表字典*/
            buildTableDist(item,fieldHump){
                  let tableHump=utils.lineToHump(item.dist);
                  let axios=fieldHump+"Init(){ this.$axios.get(this.$url +'/client/"+tableHump
                        +"/list?page=0&pageSize=100').then((response) => {this."
                        +fieldHump+"Dist=response.data.data.list;});},"
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
                  
                  // console.log(this.$router.options.routes);
                  // console.log(JSON.stringify(this.$router.options.routes));
            },
            /*添加表格条目*/
            addField() {
                  let field = { field: "", name: "", type: "",query:false,queryType:'',dist:''};
                  this.form.formData.paramTable.push(field);
            },
            /* 删除表格条目 */
            reduceField(scope){
                  this.form.formData.paramTable.splice(scope.$index)
            }
      },
      mounted() {
            this.init();
      },
};
</script>

<style lang="less" scoped>
.tworice-column{
      margin-top: 10px;
}
</style>
