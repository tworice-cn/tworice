<template>
    <div ref="pieChart" style="width: 600px; height: 400px;"></div>
</template>

<script>
/**
 * 饼状图
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
        const chart = echarts.init(this.$refs.pieChart);
        const option = {
            title: {
                text: this.title,
                left: 'center'
            },
            tooltip: {
                trigger: 'item'
            },
            series: [
                {
                    type: 'pie',
                    radius: '50%',
                    data: this.data,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        chart.setOption(option);
    }
};
</script>
