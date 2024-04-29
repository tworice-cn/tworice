<script>
/**
 * 词云图
 * 使用前请使用 npm install echarts-wordcloud 安装依赖
 * [{name:'',value:''}]
 */
import * as echarts from 'echarts';
import "echarts-wordcloud/dist/echarts-wordcloud";
import "echarts-wordcloud/dist/echarts-wordcloud.min";
export default {
    name: "WordChart",
    props: {
        data: {
            type: Array,
            required: true
        }
    },
    mounted() {
        const chart = echarts.init(this.$refs.wordChart);
        const option = {
            title: {
                text: "词云图",
                x: "left",
            },
            backgroundColor: "#fff",
            series: [
                {
                    type: "wordCloud",
                    //用来调整词之间的距离
                    gridSize: 10,
                    //用来调整字的大小范围
                    sizeRange: [14, 60],
                    //用来调整词的旋转方向，，[0,0]--代表着没有角度，也就是词为水平方向，需要设置角度参考注释内容
                    // rotationRange: [-45, 0, 45, 90],
                    // rotationRange: [ 0,90],
                    rotationRange: [0, 0],
                    //随机生成字体颜色
                    textStyle: {
                        normal: {
                            color: function() {
                                return "rgb(" + Math.round(Math.random() * 255) + ", " + Math.round(Math.random() * 255) + ", " + Math.round(Math.random() * 255) + ")";
                            },
                        },
                    },
                    //位置相关设置
                    // Folllowing left/top/width/height/right/bottom are used for positioning the word cloud
                    // Default to be put in the center and has 75% x 80% size.
                    left: "center",
                    top: "center",
                    right: null,
                    bottom: null,
                    width: "200%",
                    height: "200%",
                    //数据
                    data: this.data,
                },
            ],
        };
        
        option && chart.setOption(option);
        
        
        
        
        
        
    }
}
</script>

<template>
    <div ref="wordChart" style="width: 800px; height: 400px;"></div>
</template>

<style scoped lang="less">

</style>