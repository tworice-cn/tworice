<template>
      <div>
            <el-upload :show-file-list="true" :headers="header" name="file" class="upload-demo" drag :action="$url + 'admin/upload/upload'" :on-success="uploadChange" multiple>
                  <i class="el-icon-upload"></i>
                  <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
            </el-upload>
      </div>
</template>

<script>
export default {
      props: [],
      data() {
            return {
                  header: {
                        token: window.localStorage.getItem("token"),
                        adminID: JSON.parse(window.localStorage.getItem("admin")).id,
                  }
            };
      },
      methods: {
            uploadChange(e) {
                  console.log(e.data.file);
            },
      },
};
</script>

<style lang="less"></style>
