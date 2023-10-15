<template>
      <div>
            <el-form>
                  <el-form-item label='上传图片' :label-width='formLabelWidth'>
                        <input type="file" class="file-left-input" @change="uploadChange()" ref="inputer" multiple accept=".png,.jpg"/>
                  </el-form-item>
                  <el-form-item v-if="startUpload" label='上传进度' :label-width='formLabelWidth'>
                        <el-progress :text-inside="true" :stroke-width="24" :percentage="progress" status="success"></el-progress>
                  </el-form-item>
                  <el-form-item v-if="startUpload" label='识别内容' :label-width='formLabelWidth'>
                        <el-input type="textarea" :rows="8" placeholder="请输入内容" v-model="content"></el-input>
                  </el-form-item>
            </el-form>
      </div>
</template>

<script>
export default {
      props: [],
      data() {
            return {
                  formLabelWidth: "80px",
                  startUpload:false,/**是否显示进度条，一般开始上传后开始显示 */
                  progress:0,/**上传进度 */
                  content:''
            }
      },
      methods:{
            uploadChange(){
                  this.startUpload=true;
                  let files= this.$refs.inputer.files;// 获取选择的文件
                  let len=files.length;// 文件个数
                  if(len!=1){
                        this.$msg({
                              message: '需要且只能上传一个文件',
                              type: 'warning'
                        });
                        return;
                  }
                  let formData=new FormData();
                  formData.append("img",files[0]);
                  this.$axios({
                        method: 'post',
                        url: this.$url+'admin/ocr/ocr',
                        data: formData,
                        headers: {
                              'Content-Type': 'multipart/form-data'
                        },
                        onUploadProgress:event=>{
                              if(event.lengthComputable) {
                                    let val= (event.loaded / event.total * 100).toFixed(0);
                                    this.progress=val;
                              }
                        }
                  }).then(res=>{
                        console.log(res);
                        if(res.data.status.code==200){
                              this.content=res.data.data.content;
                              // let url=this.$url+res.data.data.url;
                              // console.log(url);
                              // this.$refs.inputer.value = null; // 上传成功后是否需要将选择的文件滞空
                              this.$msg({
                                    message: res.data.status.message,
                                    type: 'success'
                              });
                        }else{
                              this.$msg({
                                    message: res.data.status.message,
                                    type: 'error'
                              });
                        }
                  }).catch(()=>{this.$msg({message: '上传失败，请检查文件合法性！',type: 'error'})})
            }
      }
};
</script>

<style lang="less">
      
</style>