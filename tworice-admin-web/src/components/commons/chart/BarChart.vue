<template>
    <div ref="barChart" style="width: 600px; height: 400px;"></div>
</template>

<script>
/**
 * 柱状图
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
        const chart = echarts.init(this.$refs.barChart);
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
                    type: 'bar'
                }
            ]
        };
        chart.setOption(option);
    }
};
</script>
