<!-- 富文本编辑器 -->
<template>
      <div style="border: 1px solid #ccc;">
        <Toolbar style="border-bottom: 1px solid #ccc" :editor="editor" :defaultConfig="toolbarConfig" :mode="mode"/>
        <Editor style="height: 300px; overflow-y: hidden;" :value="value" @input="change" :defaultConfig="editorConfig" :mode="mode" @onCreated="onCreated"/>
    </div>
</template>

<script>
import Vue from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import '@wangeditor/editor/dist/css/style.css'

export default Vue.extend({
      components: { Editor, Toolbar },
      props:{
            value:{
                  type: String,
                  default: ''
            }
      },
      data() {
            return {
                  editor: null,
                  toolbarConfig: {},
                  editorConfig: { 
                        placeholder: '请输入内容...',
                        MENU_CONF:{
                              uploadImage:{
                                    server:this.$url+'/editor/editorUpload',
                                    fieldName:'editorFile'
                              }
                        }
                  },
                  mode: 'default', // or 'simple'
            }
      },
      methods: {
            onCreated(editor) {
                  this.editor = Object.seal(editor) // 一定要用 Object.seal() ，否则会报错
            },

            /**获取HTML代码 */
            getHtml(){
                  return this.editor.getHtml();
            },
            /**获取文本内容 */
            getText(){
                  return this.editor.getText();
            },
            /**清空内容 */
            clearText(){
                  
                  this.editor.clear();
            },
            /**
             * 初始化内容
             * htmlText为富文本内容
             */
            setText(htmlText){
                  this.html=htmlText;
            },
            change(e){
                  this.$emit('input', e)
            }
      },
      mounted() {
            
      },
      beforeDestroy() {
            const editor = this.editor
            if (editor == null) return
            editor.destroy() // 组件销毁时，及时销毁编辑器
      }
})
</script>
