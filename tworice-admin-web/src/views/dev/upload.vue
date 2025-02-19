<template>
    <div>
        <el-upload :data="{agent:$setting.uploadAgent}" :show-file-list="true" :headers="$setting.uploadHeader" name="file"
                   class="upload-demo" drag :action="$url + 'admin/upload/upload'" :on-success="uploadChange" multiple>
            <i class="el-icon-upload"></i>
            <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        </el-upload>
    </div>
</template>

<script>
export default {
    props: [],
    data() {
        return {};
    },
    methods: {
        uploadChange(e) {
            console.log(e.data.file);
        },
    },
};
</script>

<style lang="less"></style>
