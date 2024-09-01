<!-- 富文本编辑器 -->
<template>
    <div style="border: 1px solid #ccc;">
        <div id="toolbar"></div>
        <div id="editor" style="height: 300px; overflow-y: hidden;"></div>
    </div>
</template>

<script>
import Vue from 'vue';
import {loadEditor} from "@/components/commons/editor/EditorLoader";
export default Vue.extend({
    props: {
        value: {
            type: String,
            default: ''
        }
    },
    data() {
        return {
            toolbarConfig: {},
            mode: 'default',
            Editor:null
        }
    },
    methods: {
        initEditor() {
            const editorConfig = {
                placeholder: '请输入内容...',
                MENU_CONF: {
                    uploadImage: {
                        server: this.$url + '/editor/editorUpload',
                        fieldName: 'editorFile',
                        meta:{
                            agent:this.$setting.uploadAgent,
                        }
                    }
                },
            }
            editorConfig.onChange = (editor) => {
                this.$emit('input', editor.getHtml())
            }
            const editor = this.Editor.createEditor({
                selector: '#editor',
                config: editorConfig,
                html: this.value,
                mode: this.mode // 或 'simple' 参考下文
            })
            const toolbar = this.Editor.createToolbar({
                editor,
                selector: '#toolbar',
                config: this.toolbarConfig,
                mode: this.mode
            })
        },
        onCreated(editor) {
            this.editor = Object.seal(editor) // 一定要用 Object.seal() ，否则会报错
        },
        
        /**获取HTML代码 */
        getHtml() {
            return this.editor.getHtml();
        },
        /**获取文本内容 */
        getText() {
            return this.editor.getText();
        },
        /**清空内容 */
        clearText() {
            this.editor.clear();
        },
        /**
         * 初始化内容
         * htmlText为富文本内容
         */
        setText(htmlText) {
            this.html = htmlText;
        },
    },
    beforeDestroy() {
        if (this.editor == null) return;
        this.editor.destroy() // 组件销毁时，及时销毁编辑器
    },
    async mounted() {
        await loadEditor();
        this.Editor = window.wangEditor;
        this.initEditor()
    }
})
</script>
<style >
@import url(https://cdn.jsdelivr.net/npm/@wangeditor/editor@latest/dist/css/style.css);
</style >
