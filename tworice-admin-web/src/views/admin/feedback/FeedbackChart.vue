<template>
    <div class="app-body">
        <div ref="chart" style="width: 1000px; height: 400px;"></div>
    </div>
</template><script>
import {loadECharts} from "@/components/commons/chart/EchartsLoader";
export default {
    name: 'FeedbackChart',
    props: ['value'],
    data() {
        return {
        
        };
    },
    methods: {
        init(){
            console.log(this.value)
            const chartDom = this.$refs.chart;
            const myChart = echarts.init(chartDom);
            const option = {
                title: {
                    text: '用户反馈统计报告'
                },
                tooltip: {},
                legend: {
                    data: ['处理总时长(分钟)', '平均处理时长(分钟)']
                },
                xAxis: {
                    data: this.value.map(item => item.typeName)
                },
                yAxis: {},
                series: [
                    {
                        name: '处理总时长(分钟)',
                        type: 'bar',
                        data: this.value.map(item => item.timeStampCount)
                    },
                    {
                        name: '平均处理时长(分钟)',
                        type: 'bar',
                        data: this.value.map(item => item.timeStampAvg)
                    },
                ]
            };
            
            myChart.setOption(option);
        }
    },
    async mounted() {
        await loadECharts();
        this.init();
    },
};
</script>
<style lang="less" scoped></style>