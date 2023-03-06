<template>
      <div>
            <el-form>
                  <el-form-item label='视频文件' :label-width='formLabelWidth'>
                        <input type="file" class="file-left-input" @change="uploadChange()" ref="inputer" multiple accept=".mp4"/>
                  </el-form-item>
                  <el-form-item v-if="startUpload" label='上传进度' :label-width='formLabelWidth'>
                        <el-progress :text-inside="true" :stroke-width="24" :percentage="progress" status="success"></el-progress>
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
            }
      },
      methods:{
            uploadChange(){
                  this.startUpload=true;
                  let files= this.$refs.inputer.files;// 获取选择的文件
                  let len=files.length;// 文件个数
                  if(len!=1){
                        this.$message({
                              message: '需要且只能上传一个文件',
                              type: 'warning'
                        });
                        return;
                  }
                  let formData=new FormData();
                  formData.append("file",files[0]);
                  this.$axios({
                        method: 'post',
                        url: this.$url+'admin/upload/upload',
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
                        if(res.data.status.code==200){
                              let url=this.$url+res.data.data.url;
				console.log(url);
                              this.$refs.inputer.value = null; // 上传成功后是否需要将选择的文件滞空
                        }
                  }).catch(()=>{this.$message({message: '上传失败，请检查文件合法性！',type: 'error'})})
            }
      }
};
</script>

<style lang="less">
      
</style>