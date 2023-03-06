<template>
      <div class="app-body">
            <!-- 条件查询 -->
            <el-col :span="24" class="info-search-box">
                  <div class="search">
                        <div class='search-item'>文件名称 : <el-input size='mini' v-model='search.name' placeholder='通过文件名称查询' clearable></el-input>
                        </div>
                        <div class="search-item">
                              <el-button size="mini" type="primary" @click="toPage">查询</el-button>
                        </div>
                  </div>
            </el-col>
            <el-col :span="24" class="button-box">
                  <el-button size="mini" type="primary" icon="el-icon-document-add" @click="add">上传</el-button>
                  <el-button size="mini" type="success" icon="el-icon-folder-add" @click="inductsVisible=true">新建文件夹</el-button>
                  <el-button size="mini" type="danger" icon="el-icon-delete" @click="delList">批量删除</el-button>
            </el-col>
            <el-col :span="24" class="button-box">
                  <el-breadcrumb separator="/">
                        <el-breadcrumb-item><a @click="toParent(1)">根目录</a></el-breadcrumb-item>
                        <el-breadcrumb-item v-if="info.id!='1'">{{info.name}}</el-breadcrumb-item>
                  </el-breadcrumb>
            </el-col>

            <el-table @selection-change="handleSelectionChange" size="mini" v-loading="loading" :header-cell-style="$setting.table_header" :stripe="true" :fit="true" :data="tableData" style="width: 100%">
                  <el-table-column type="selection" width="55"></el-table-column>
                  <el-table-column prop='id' label='类型' width="55" >
                        <template slot-scope="scope">
                              <i :class="scope.row.type==1?'el-icon-document':'el-icon-folder'" class="file-icon"></i>
                        </template>
                  </el-table-column>
                  <el-table-column prop='name' label='文件名称'>
                        <template slot-scope="scope">
                              <el-link @click="clickFile(scope.row)">{{scope.row.name}}</el-link>
                        </template>
                  </el-table-column>
                  <el-table-column prop='createTime' label='创建时间' :formatter='(row)=>formatDate(row.createTime)'></el-table-column>
                  <el-table-column prop='nickName' label='创建人'></el-table-column>
                  <el-table-column prop='share' label='分享'>
                        <template slot-scope="scope">
                              <el-popover v-if="scope.row.share=='1'" placement="top" width="200" trigger="click" :content="$url+pageUrlPath+'/downloadLocal/'+scope.row.id">
                                    <el-button size="mini" type="primary" slot="reference">分享中</el-button>
                              </el-popover>
                        </template>
                  </el-table-column>
                  <el-table-column prop='size' label='大小' :formatter='(row)=>changeSize(row.size)' width="80"></el-table-column>
                  <el-table-column label="操作"> <template slot-scope="scope">
                        <el-tooltip content="取消分享">
                              <el-button v-if="scope.row.type==1&&scope.row.share==1" size="mini" type="danger" icon="el-icon-share" circle @click.native="share(scope.row,0)"></el-button>
                        </el-tooltip>
                        <el-tooltip content="分享文件">
                              <el-button v-if="scope.row.type==1&&scope.row.share==0" size="mini" type="info" icon="el-icon-share" circle @click.native="share(scope.row,1)"></el-button>
                        </el-tooltip>
                        <el-tooltip content="编辑文件夹">
                              <el-button v-if="scope.row.type==2" size="mini" type="warning" icon="el-icon-edit" circle @click.native="edit(scope.row)"></el-button>
                        </el-tooltip>
                        <el-tooltip content="删除">
                              <el-button size="mini" type="danger" icon="el-icon-delete" circle @click.native="del(scope.row)"></el-button>
                        </el-tooltip>
                        </template> </el-table-column>
            </el-table>
            <el-col :span="24">
                  <div class="page-box">
                        <el-pagination @size-change="handleSizeChange" :small="true" :hide-on-single-page="true" @current-change="changePage" background layout="total, sizes, prev, pager, next" :total="total"
                              :page-size="pageSize"></el-pagination>
                  </div>
            </el-col> <!-- 弹出层 -->
            <el-dialog title="上传文件" :visible.sync="formVisible" top="5vh" width="30%" :before-close="handleClose">
                  <el-form :model="form" :rules="rules" ref="form">
                        <el-upload
                                    class="upload-demo"
                                    :data="getData()"
                                    drag
                                    :show-file-list="false"
                                    :action="$url+pageUrlPath+'/add'"
                                    :on-success="toPage"
                                    :multiple="false">
                                    <i class="el-icon-upload"></i>
                                    <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
                              </el-upload>
                  </el-form>
            </el-dialog>
            <el-dialog title="文件夹" :visible.sync="inductsVisible" width="30%" :before-close="handleClose">
                  <el-form size="mini">
                        <el-input :validate-event="true" :show-word-limit="true" minlength="2" maxlength="12" v-model="form.name" size="mini" placeholder="请输入文件夹名称"></el-input>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                        <el-button size="mini" @click="inductsVisible=false">取 消</el-button>
                        <el-button size="mini" type="primary" @click="mkdir">确定</el-button>
                  </div>
            </el-dialog>
      </div>
</template><script>
export default {
      props: [],
      data() {
            return {
                  info:{},
                  startUpload:false,/**是否显示进度条，一般开始上传后开始显示 */
                  progress:0,/**上传进度 */
                  loading: true,
                  page: 0,
                  pageSize: 10,
                  total: 0,
                  tableData: [],
                  formTitle: "",
                  formVisible: false,
                  inductsVisible: false,
                  form: {
                        id: "",
                        createTime: "",
                        updateTime: "",
                        path: "",
                        name: "",
                        creator: "",
                        type:'',
                        parent:1,
                        size:'',
                        share:0
                  },
                  rules: {
                        id: [
                              {
                                    required: true,
                                    message: "请输入编号",
                                    trigger: "blur",
                              },
                        ],
                        createTime: [
                              {
                                    required: true,
                                    message: "请输入创建时间",
                                    trigger: "blur",
                              },
                        ],
                        updateTime: [
                              {
                                    required: true,
                                    message: "请输入更新时间",
                                    trigger: "blur",
                              },
                        ],
                        path: [
                              {
                                    required: true,
                                    message: "请输入文件路径",
                                    trigger: "blur",
                              },
                        ],
                        name: [
                              {
                                    required: true,
                                    message: "请输入文件名称",
                                    trigger: "blur",
                              },
                        ],
                        creator: [
                              {
                                    required: true,
                                    message: "请输入创建人",
                                    trigger: "blur",
                              },
                        ],
                  },
                  formLabelWidth: "80px",
                  /** 弹出框标签宽度*/ isChange: false,
                  search: { id: "", name: "", creator: "",parent:'1' },
                  multipleSelection: [],
                  pageUrlPath: "/file/systemFile",
            
            };
      },
      methods: {
            share(row,type){
                  this.form=row;
                  this.form.share=type;
                  this.submit();
            },
            changeSize(limit){
                  if(limit){
                        var size = "";
                        if(limit < 0.1 * 1024){                            //小于0.1KB，则转化成B
                              size = limit.toFixed(2) + "B"
                        }else if(limit < 0.1 * 1024 * 1024){            //小于0.1MB，则转化成KB
                              size = (limit/1024).toFixed(2) + "KB"
                        }else if(limit < 0.1 * 1024 * 1024 * 1024){        //小于0.1GB，则转化成MB
                              size = (limit/(1024 * 1024)).toFixed(2) + "MB"
                        }else{                                            //其他转化成GB
                              size = (limit/(1024 * 1024 * 1024)).toFixed(2) + "GB"
                        }
                        var sizeStr = size + "";                        //转成字符串
                        var index = sizeStr.indexOf(".");                    //获取小数点处的索引
                        var dou = sizeStr.substr(index + 1 ,2)            //获取小数点后两位的值
                        if(dou == "00"){                                //判断后两位是否为00，如果是则删除00               
                              return sizeStr.substring(0, index) + sizeStr.substr(index + 3, 2)
                        }
                        return size;
                  }
            },
            toParent(parent){
                  this.clickFile({type:2,id:parent});
            },
            initInfo(){
                  this.$axios.get(this.$url+this.pageUrlPath+'/info?id='+this.search.parent).then(res=>{
                        this.info=res.data.data.info;
                  })
            },
            clickFile(row){
                  if(row.type==1){
                        window.open(this.$url+row.path)
                  }else{
                        this.$router.push({
                              path:'/admin/file',
                              query:{
                                    parent:row.id
                              }
                        })
                  }
            },
            getData(){
                  // 设置文件上传时的参数
                  if(this.$route.query.parent){
                        this.search.parent=this.$route.query.parent;
                        this.form.parent=this.$route.query.parent;
                  }
                  this.form.type=1;
                  this.form.creator=JSON.parse(window.sessionStorage.getItem('admin')).id;
                  return this.form;
            },
            /**初始化字典 */ initDist() {},
            /**格式化日期 */ formatDate(timeStamp) {
                  let date = new Date(timeStamp);
                  let month =
                        date.getMonth() + 1 < 10
                              ? "0" + (date.getMonth() + 1)
                              : date.getMonth() + 1;
                  let day =
                        date.getDate() < 10
                              ? "0" + date.getDate()
                              : date.getDate();
                  let hours =
                        date.getHours() < 10
                              ? "0" + date.getHours()
                              : date.getHours();
                  let minutes =
                        date.getMinutes() < 10
                              ? "0" + date.getMinutes()
                              : date.getMinutes();
                  return (
                        date.getFullYear() +
                        "-" +
                        month +
                        "-" +
                        day +
                        " " +
                        hours +
                        ":" +
                        minutes
                  );
            },
            handleSizeChange(size) {
                  this.pageSize = size;
                  this.toPage();
            },
            init() {
                  this.form.creator=JSON.parse(window.sessionStorage.getItem('admin')).id;
                  this.search.creator=this.form.creator;
                  this.toPage();
                  this.initDist();
            },
            toPage() {
                  this.loading = true;
                  this.inductsVisible=false;
                  this.formVisible=false;
                  if(this.$route.query.parent){
                        this.search.parent=this.$route.query.parent;
                        this.form.parent=this.$route.query.parent;
                  }
                  this.initInfo();
                  let param = "";
                  Object.keys(this.search).map((key) => {
                        if (
                              this.search[key] != undefined &&
                              this.search[key] != ""
                        ) {
                              param += "&" + key + "=" + this.search[key];
                        }
                  });
                  this.$axios
                        .get(
                              this.$url +
                                    this.pageUrlPath +
                                    "/list?page=" +
                                    this.page +
                                    "&pageSize=" +
                                    this.pageSize +
                                    param
                        )
                        .then((response) => {
                              this.tableData = response.data.data.list;
                              this.total = response.data.data.total;
                              this.loading = false;
                        });
            },
            /**监听页码发生变化 */ changePage(e) {
                  this.page = e - 1;
                  this.toPage();
            },
            add() {
                  this.form = this.$options.data().form;
                  this.formTitle = "新增";
                  this.formVisible = true;
            },
            handleClose(done) {
                  this.$confirm("确认关闭？").then(() => {
                        done();
                  });
            },
            mkdir(){
                  this.form.type=2;
                  this.submit();
            },
            submit() {
                  // 创建文件夹
                  this.$root.loading = true;
                  
                  let formData = new FormData();
                  Object.keys(this.form).map((key) => {
                        if (
                              this.form[key] != undefined &&
                              this.form[key] != ""
                        ) {
                              formData.append(key, this.form[key]);
                        }
                  });
                  this.$axios({
                        method: "POST",
                        url: this.$url + this.pageUrlPath + "/add",
                        data: formData,
                  }).then((res) => {
                        if (res.data.status.code < 400) {
                              this.toPage();
                              this.inductsVisible = false;
                        }
                  });
            },
            edit(row) {
                  this.form = row;
                  this.formTitle = "编辑";
                  this.inductsVisible = true;
            },
            /*删除*/ del(row) {
                  this.$confirm("此操作将永久删除该信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.$root.loading = true;
                        let format = new FormData();
                        format.append("ids", row.id);
                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + this.pageUrlPath + "/del",
                        }).then((res) => {
                              if (res.data.status.code == 200) {
                                    this.toPage();
                              }
                        });
                  });
            },
            /**下载表 */ templateDownload() {
                  window.open(this.$url + this.pageUrlPath + "/template");
            },
            /**批量删除 */ delList() {
                  this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                  }).then(() => {
                        this.$root.loading = true;
                        let format = new FormData();
                        this.multipleSelection.forEach((item) => {
                              format.append("ids", item.id);
                        });
                        this.$axios({
                              method: "DELETE",
                              data: format,
                              url: this.$url + this.pageUrlPath + "/del",
                        });
                  });
            },
            /**选择框 val为当前所有选择的内容数组 */ handleSelectionChange(
                  val
            ) {
                  this.multipleSelection = val;
            },
            /**点击批量导入 */ inducts() {
                  this.inductsVisible = true;
            },
            /**选择批量 */ inductsChange() {
                  let files = this.$refs.inducts.files;
                  /*获取选择的文件*/ let len = files.length;
                  /*文件个数*/ if (len != 1) {
                        this.$message({
                              message: "需要且只能上传一个文件",
                              type: "warning",
                        });
                        return;
                  }
                  let formData = new FormData();
                  formData.append("file", files[0]);
                  this.$axios({
                        method: "post",
                        url: this.$url + this.pageUrlPath + "/inducts",
                        data: formData,
                        headers: { "Content-Type": "multipart/form-data" },
                  })
                        .then((res) => {
                              /*上传成功后是否需要将选择的文件滞空*/ this.$refs.inducts.value =
                                    null;
                              if (res.data.status.code == 200) {
                                    this.inductsVisible = false;
                                    this.toPage();
                              }
                        })
                        .catch(() => {
                              this.$refs.inducts.value = null;
                              this.$message({
                                    message: "上传失败，请检查文件合法性！",
                                    type: "error",
                              });
                        });
            },
      },
      mounted() {
            this.init();
      },
      watch:{
            '$route':'toPage'
      }
};
</script><style lang="less" scoped>
.file-icon{
      font-size: 20px!important;
}
</style>