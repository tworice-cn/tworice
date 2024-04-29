<template>
    <div ref="roseChart" style="width: 600px; height: 400px;"></div>
</template>

<script>
/**
 * 玫瑰图，类似饼状图
 * [{name:'',value:''}]
 */
import * as echarts from 'echarts';

export default {
    props: {
        data: {
            type: Array,
            required: true
        }
    },
    mounted() {
        const chart = echarts.init(this.$refs.roseChart);
        const option = {
            series: [
                {
                    type: 'pie',
                    data: this.data,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    },
                    roseType: 'area'
                }
            ]
        };
        chart.setOption(option);
    }
};
</script>
