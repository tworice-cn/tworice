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

let editor;
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
            WangEditor:null,
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
            editor = this.WangEditor.createEditor({
                selector: '#editor',
                config: editorConfig,
                html: this.value,
                mode: this.mode // 或 'simple' 参考下文
            })
            const toolbar = this.WangEditor.createToolbar({
                editor,
                selector: '#toolbar',
                config: this.toolbarConfig,
                mode: this.mode
            })
        },
        
        /**获取HTML代码 */
        getHtml() {
            return editor.getHtml();
        },
        /**获取文本内容 */
        getText() {
            return editor.getText();
        },
        /**清空内容 */
        clearText() {
            editor.clear();
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
        this.WangEditor = window.wangEditor;
        this.initEditor()
    }
})
</script>
<style >
@import url(/css/wangeditor.css);
</style >
