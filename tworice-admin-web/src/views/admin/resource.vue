<template>
      <div class="resource app-body">

            <el-col :span="24" class="resource-list">
                  <el-col :span="24" class="button-box">
                        <el-button type="primary" icon="el-icon-plus" size="mini" @click="addModule">新增</el-button>
                  </el-col>
                  <el-col :span="24">
                        <el-table size="mini" :data="tableData" style="width: 100%;margin-bottom: 20px;" row-key="id" border :tree-props="{children: 'children', hasChildren: 'hasChildren'}" :header-cell-style="$setting.table_header">
                              <el-table-column prop="name" label="资源名称"></el-table-column>
                              <el-table-column prop="url" label="页面路径"></el-table-column>
                              <!-- <el-table-column prop="path" label="请求路径"></el-table-column> -->
                              <el-table-column prop="pid" label="上级ID"></el-table-column>
                              <el-table-column prop="sort" label="排序" sortable></el-table-column>
                              <el-table-column prop="icon" label="图标">
                                    <template slot-scope="scope">
                                          <i :class="scope.row.icon" style="font-size: 22px;"></i>
                                    </template>
                              </el-table-column>
                              <el-table-column prop="type" label="类型" width="100">
                                    <template slot-scope="scope">
                                          <el-tag type="success" v-if="scope.row.type==1">模块</el-tag>
                                          <el-tag type="primary" v-if="scope.row.type==2">页面</el-tag>
                                          <el-tag type="warning" v-if="scope.row.type==3">功能</el-tag>
                                    </template>
                              </el-table-column>
                              <el-table-column label="操作">
                                    <template slot-scope="scope">
                                          <el-button v-if="scope.row.type!=3" size="mini" type="primary" icon="el-icon-plus" circle @click.native="addResource(scope.row)"></el-button>
                                          <el-button size="mini" type="warning" icon="el-icon-edit" circle @click.native="editResource($event,scope.row)"></el-button>
                                          <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="delResource($event,scope.row)"></el-button>
                                    </template>
                              </el-table-column>
                        </el-table>
                  </el-col>
            </el-col>

            <!-- 添加弹窗 -->
            <el-dialog :title="formTitle" :visible.sync="dialogFormVisible" width="30%" :before-close='$utils.handleClose'>
                  <el-form :model="form" size="mini" :rules="rules" ref="form">
                        <el-form-item label="资源名称" :label-width="formLabelWidth" prop="name">
                              <el-input v-model="form.name" @change="isChange = true" placeholder="展示名称"></el-input>
                        </el-form-item>
                        <el-form-item label="页面路径" :label-width="formLabelWidth" prop="url">
                              <el-input v-model="form.url" @change="isChange = true" placeholder="Vue路由"></el-input>
                        </el-form-item>
                        <!-- <el-form-item label="请求路径" :label-width="formLabelWidth" prop="path">
                              <el-input v-model="form.path" @change="isChange = true" placeholder="请求接口"></el-input>
                        </el-form-item> -->
                        <el-form-item label="排序" :label-width="formLabelWidth" prop="sort">
                              <el-input v-model="form.sort" @change="isChange = true"></el-input>
                        </el-form-item>
                        <el-form-item label="资源图标" :label-width="formLabelWidth" prop="icon">
                              <el-select @change="isChange = true" size="mini" v-model="form.icon" filterable placeholder="请选择" :loading="iconFontLoading" @focus="iconFocus">
                                    <el-option
                                          v-for="item in iconFont"
                                          :key="item"
                                          :label="item"
                                          :value="item">
                                          <span style="float: left;font-size: 12px">{{item==''?'暂不设置图标':item}}</span>
                                          <span style="float: right; color: #8492a6; font-size: 22px"><i :class="item"></i></span>
                                    </el-option>
                              </el-select>
                        </el-form-item>
                        <el-form-item label="资源类型" :label-width="formLabelWidth" prop="type">
                              <el-select size="mini" :disabled="state==0" v-model="form.type" style="width: 100%;">
                                    <el-option label="模块" :value="1" v-if="state<2"></el-option>
                                    <el-option label="页面" :value="2" v-if="state<2"></el-option>
                                    <el-option label="功能" :value="3" v-if="state>=2"></el-option>
                              </el-select>
                        </el-form-item>
                        <el-form-item label="更新路由" :label-width="formLabelWidth">
                              <el-switch v-model="form.router" active-color="#13ce66" inactive-color="#ff4949"></el-switch>
                        </el-form-item>
                        <el-input v-model="form.pid" type="hidden"></el-input>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button @click="dialogFormVisible=false">取 消</el-button>
                        <el-button type="primary" @click="submit">确 定</el-button>
                  </div>
            </el-dialog>
      </div>
</template>

<script>
import fontFontArray from '../../assets/json/iconFont.json';
export default {
      props: [],
      data() {
            return {
                  state:1,// 编辑：0 新增：1-外部的新增 2-模块上的新增 3-页面上的新增
                  search_name:'',
                  tableData: [],
                  formTitle:'',
                  dialogFormVisible: false, // 弹出框状态
                  form: {
                        pid: -1,
                        name: '',
                        url: '',
                        path:'',
                        sort: '',
                        icon: '',
                        type: 1,
                        router:true
                  },
                  formLabelWidth: '80px', // 弹出框标签宽度
                  // 表单校验规则
                  rules:{
                        name:[
                              { required: true, message: '请输入资源名称', trigger: 'blur' }
                        ],
                        url:[
                              { required: true, message: '请输入请求路径', trigger: 'blur' }
                        ],
                        sort:[
                              { required: true, message: '请输入序号', trigger: 'blur' }
                        ]
                  },
                  // 删除提示消息
                  delMsg:'',
                  // 行的id
                  rowId:-1,
                  isChange:false,// 是否有修改
                  iconFont:[],// 可供选择图标
                  iconFontLoading:false,// 正在加载图标库
            }
      },
      methods:{
            // 表格初始化
            init(){
                  this.$axios({
                        method:'get',
                        url:this.$url+'/admin/system/resources/list',
                  }).then(
                        res=>{
                              if(res.data.status.code<400) {
                                  this.tableData = res.data.data.resourceList;
                              }
                        }
                  )
            },

            //添加模块
            addModule(){
                  this.dialogFormVisible=true;
                  this.state=1
                  this.formTitle=`在根路径下新增`;
                  this.form.pid=0;
                  this.form.type=1;
            },

            // 添加资源
            addResource(row){
                  this.state=row.type;
                  this.form.pid=row.id;

                  if(row.type==1){
                        this.formTitle=`在模块「${row.name}」下新增`;
                        this.form.type=2;
                        this.form.url=row.url+'/';

                  }else if(row.type==2){
                        this.formTitle=`在页面「${row.name}」下新增`;
                        this.form.type=3;
                        this.form.url=row.url+'/';
                  }
                  this.dialogFormVisible=true;
            },

            // 编辑资源
            editResource(e,row){
                  let form=this.form;
                  this.state=0;
                  this.dialogFormVisible=true;
                  this.$nextTick(function(){
                        if(row.type==1){
                              this.formTitle=`编辑「${row.name}」模块`;
                              this.form.type=1;
                        }else if(row.type==2){
                              this.formTitle=`编辑「${row.name}」页面`;
                              this.form.type=2;
                        }else if(row.type==3){
                              this.formTitle=`编辑「${row.name}」功能`;
                              this.form.type=3;
                        }

                        form.pid=row.pid;
                        form.name=row.name;
                        form.url=row.url;
                        form.sort=row.sort;
                        form.icon=row.icon;
                  })
                  
                  this.forceBlur(e);
                  this.rowId=row.id;
            },

            // 提交添加或编辑内容
            submit(){
                  if(this.form.name==''||this.form.sort==''){
                        this.$msg({
                              type:"warning",
                              message:'带*项不能为空'
                        })
                        return
                  }

                  if(this.isChange){
                        /**判断请求路径是否为空 */
                        if(this.form.url==''){
                              this.$msg({
                                    type:'error',
                                    message:'请求路径不能为空'
                              })
                              return;
                        }

                        this.$root.loading=true;
                        let format = new FormData();
                        for(let key in this.form){
                              format.append(key,this.form[key]);
                        }

                        if(this.formTitle.indexOf('编辑')!==-1){
                              format.append('id',this.rowId);
                        }
                        this.$axios({
                              method:'put',
                              url:this.$url+'/admin/system/resources/edit',
                              data:format
                        }).then(
                              res=>{
                                    if(res.data.status.code==200){
                                          this.init();
                                    }
                              }
                        )
                  }
                  this.resetForm();
                  this.dialogFormVisible = false;
                  
            },
            
            // 重置表单和表单验证
            resetForm(){
                  //重置表单
                  this.$refs.form.resetFields();
                  //重置表单验证
                  this.$refs.form.clearValidate();
            },

            // 删除资源
            delResource(e,row){
                  if(row.type==1){
                        this.delMsg='该模块及其下的页面与功能'
                  }else if(row.type==2){
                        this.delMsg='该页面及其下的功能'
                  }else if(row.type==3){
                        this.delMsg='该功能'
                  }

                  this.$confirm(`此操作将永久删除${this.delMsg}, 是否继续?`, '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                  }).then(() => {
                        let format = new FormData();
                        format.append('ids',row.id);
                        if(row.type==1){
                              if(row.children){
                                    row.children.forEach(page => {
                                          format.append('ids',page.id);
                                          page.children.forEach(func => {
                                          format.append('ids',func.id); 
                                          })
                                    });
                              }
                        }else if(row.type==2){
                              if(row.children){
                                    row.children.forEach(func => {
                                          format.append('ids',func.id); 
                                    });
                              }
                        }
                        

                        this.$axios({
                              method:'delete',
                              url:this.$url+'/admin/system/resources/del',
                              data:format
                        }).then(
                              res=>{
                                    if(res.data.status.code==200){
                                          this.init();
                                    }
                              }
                        )
                  }).catch(() => {
                        this.$msg({
                              type: 'info',
                              message: '已取消删除'
                        });          
                  });
                  

                  this.forceBlur(e);
            },

            // 强制按钮失去焦点
            forceBlur(e){
                  let target = e.target;
                  if(target.nodeName == "I"){
                        target = e.target.parentNode;
                  }
                  target.blur();
            },

            // 加载icon资源
            iconFocus(){
                  this.iconFont=fontFontArray.iconFont;
            }

      },
      mounted(){
            this.$root.loading=true;
            this.init();
            this.$root.loading=false;
      }
};
</script>