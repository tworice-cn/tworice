<template>
    <div ref="lineChart" style="width: 600px; height: 400px;"></div>
</template>

<script>
/**
 * 折线图
 * [{name:'',value:''}]
 */
import {loadECharts} from "@/components/commons/chart/EchartsLoader";

export default {
    props: {
        data: {
            type: Array,
            required: true
        },
        title: {
            type: String,
            default: ''
        }
    },
    async mounted() {
        await loadECharts();
        const chart = echarts.init(this.$refs.lineChart);
        const option = {
            title: {
                text: this.title,
                left: 'center'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    crossStyle: {
                        color: '#999'
                    }
                }
            },
            xAxis: {
                type: 'category',
                data: this.data.map(item => item.name)
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    data: this.data.map(item => item.value),
                    type: 'line'
                }
            ],
            dataZoom: [{
                type: 'slider', // 这里使用滑动条类型的 dataZoom
                start: 0, // 默认开始位置
                end: 100 // 默认结束位置
            }]
        };
        chart.setOption(option);
    }
};
</script>
