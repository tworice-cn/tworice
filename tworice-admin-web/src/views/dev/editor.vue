<template>
      <div>
            方法执行结果打印在控制台。当前代码示例位置：views/dev/editor.vue
            <div style="width:500px;">
                  <Editor ref="editor" v-model="value"></Editor>
            </div>
            <el-button @click="getHtml">获取HTML内容</el-button>
            <el-button @click="getText">获取Text内容</el-button>
            <el-button @click="clearHtml">清空内容</el-button>
      </div>
</template>

<script>

import Editor from '@/components/commons/Editor.vue'
export default {
      components:{
            Editor
      },
      props: [],
      data() {
            return {
                  value:'<p>这是初始化内容</p>'
            }
      },
      methods:{
            /**获取HTML内容 */
            getHtml(){
                  console.log(this.$refs.editor.getHtml());
            },
            /**清空内容 */
            clearHtml(){
                  this.$refs.editor.clearText();
            },
            /**获取文本内容 */
            getText(){
                  console.log(this.$refs.editor.getText());
            }
      }
};
</script>

<style lang="less">

</style>