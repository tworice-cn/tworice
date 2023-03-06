<template>
      <div>
            <el-descriptions :column="1" border size="mini">
                  <el-descriptions-item v-for="(item,index) in value" :key="index" :labelStyle='labelStyle'>
                        <template slot="label">
                              <i :class="item.icon?item.icon:''"></i>
                              {{item.name}}
                        </template>
                        {{item.value}}
                  </el-descriptions-item>
            </el-descriptions>
      </div>
</template>

<script>
export default {
      name: "Descriptions",
      props: [
            'value'
      ],
      data() {
            return {
                  labelStyle:{'width': '200px' }
            };
      },
      methods: {},
};
</script>