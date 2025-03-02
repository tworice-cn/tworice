<!-- 富文本编辑器 -->
<template>
    <div style="border: 1px solid #ccc;">
        <div id="toolbar"></div>
        <div id="editor" style="height: 300px; overflow-y: hidden;"></div>
    </div>
</template>

<script>
import Vue from 'vue';
import { loadEditor } from "@/components/commons/editor/EditorLoader";

export default Vue.extend({
    props: {
        value: {
            type: String,
            default: ''
        },
        mode:{
            type: String,
            default: 'default'
        },
        excludeKeys: {
            type: Array,
            default(){
                return []
            }
        },
        placeholder:{
            type: String,
            default(){
                return '请输入内容...'
            }
        },
        uploadImageUrl: {
            type: String,
            default(){
                return this.$url + '/editor/editorUpload'
            }
        },
        uploadFieldName: {
            type: String,
            default(){
                return 'editorFile'
            }
        }
    },
    data() {
        return {
            wangEditor: null, // 存放编辑器库对象
        }
    },
    methods: {
        initEditor() {
            const editorConfig = {
                placeholder: this.placeholder,
                MENU_CONF: {
                    uploadImage: {
                        server: this.uploadImageUrl,
                        fieldName: this.uploadFieldName,
                        meta: {
                            agent: this.$setting.uploadAgent,
                        }
                    }
                },
                onChange: (editor) => {
                    this.$emit('input', editor.getHtml());
                }
            };
            
            // 将编辑器实例挂载在组件实例上，避免放在 data 中引发响应性问题
            this.editorInstance = this.wangEditor.createEditor({
                selector: '#editor',
                config: editorConfig,
                html: this.value,
                mode: this.mode
            });
            
            this.wangEditor.createToolbar({
                editor: this.editorInstance,
                selector: '#toolbar',
                config: {
                    excludeKeys: this.excludeKeys
                },
                mode: this.mode
            });
        },
        /** 获取 HTML 内容 */
        getHtml() {
            return this.editorInstance ? this.editorInstance.getHtml() : '';
        },
        /** 获取纯文本内容 */
        getText() {
            return this.editorInstance ? this.editorInstance.getText() : '';
        },
        /** 清空编辑器内容 */
        clearText() {
            if (this.editorInstance) {
                this.editorInstance.clear();
            }
        },
        /**
         * 设置编辑器内容
         * @param {String} htmlText - 富文本内容
         */
        setText(htmlText) {
            if (this.editorInstance) {
                this.editorInstance.setHtml(htmlText);
            }
        },
    },
    beforeDestroy() {
        if (this.editorInstance) {
            this.editorInstance.destroy(); // 销毁编辑器实例
        }
    },
    async mounted() {
        await loadEditor();
        this.wangEditor = window.wangEditor;
        this.initEditor();
    }
});
</script>

<style>
@import url(/css/wangeditor.css);
</style>
