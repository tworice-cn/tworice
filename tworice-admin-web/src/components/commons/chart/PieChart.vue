<template>
    <div ref="pieChart" style="width: 600px; height: 400px;"></div>
</template>

<script>
/**
 * 饼状图
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
        const chart = echarts.init(this.$refs.pieChart);
        const option = {
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
