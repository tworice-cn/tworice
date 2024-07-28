<template>
    <div>
        <el-col :span="24" class="app">
            <el-col :span="24">
                <el-col :span="8" class="info-item" id="memory"></el-col>
                <el-col :span="8" class="info-item" id="physicsCpu"></el-col>
                <el-col :span="8" class="info-item" id="jvmCpu"></el-col>
            </el-col>
            <el-col :span="24" class="monitor-info">
                <el-col :span="12">
                    <Descriptions :value="systemInfo"></Descriptions>
                </el-col>
                <el-col :span="12">
                    <Descriptions :value="processInfo"></Descriptions>
                </el-col>
            </el-col>
        </el-col>
    </div>
</template>

<script>
import Descriptions from '../../components/commons/Descriptions.vue'
import {loadECharts} from "@/components/commons/chart/EchartsLoader";

export default {
    components: {
        Descriptions
    },
    props: [],
    data() {
        return {
            systemInfo: [], // 系统信息
            processInfo: [], // 运行信息
            loading: true, // 是否加载
            memoryInfo: {
                memory: {}, // 内存占用
                percentage: 0,
            },
            cpuInfo: {},
        };
    },
    methods: {
        /**初始化运行监控 */
        initProcessInfo(info) {
            info.forEach(item => {
                item.name = item.key;
            });
            this.processInfo = info;
        },
        /**初始化内存仪表盘 */
        initMemoryInfo(info) {
            this.memoryInfo.memory = info;
            this.memoryInfo.percentage =
                (100 - ((info.availableMemory / info.totalMemory) * 100)).toFixed(2);
            let totalMemory = {
                name: "物理总内存",
                value: info.totalMemory + "MB",
            };
            this.processInfo.push(totalMemory);
            let availableMemory = {
                name: "可用物理内存",
                value: info.availableMemory + "MB",
            };
            this.processInfo.push(availableMemory);
            
            let chartDom = document.getElementById("memory");
            let myChart = echarts.init(chartDom, "dark");
            let option = {
                tooltip: {
                    formatter: "{a} <br/>{b} : {c}%",
                },
                series: [
                    {
                        name: "Pressure",
                        type: "gauge",
                        progress: {
                            show: true,
                        },
                        detail: {
                            valueAnimation: true,
                            formatter: "{value}%",
                        },
                        data: [
                            {
                                value: this.memoryInfo.percentage,
                                name: "内存使用率",
                            },
                        ],
                    },
                ],
            };
            option && myChart.setOption(option);
            this.resize(myChart);
        },
        /**初始化Cpu信息 */
        initCpuInfo(info) {
            // 系统CPU占用
            info.systemCpuLoad = Number(
                (info.systemCpuLoad * 100).toFixed(2)
            );
            let chartDom = document.getElementById("physicsCpu");
            let myChart = echarts.init(chartDom, "dark");
            let option = {
                tooltip: {
                    formatter: "{a} <br/>{b} : {c}%",
                },
                series: [
                    {
                        name: "Pressure",
                        type: "gauge",
                        progress: {
                            show: true,
                        },
                        detail: {
                            valueAnimation: true,
                            formatter: "{value}%",
                        },
                        data: [
                            {
                                value: info.systemCpuLoad,
                                name: "系统CPU使用率",
                            },
                        ],
                    },
                ],
            };
            option && myChart.setOption(option);
            this.resize(myChart);
            // JVM CPU
            info.processCpuLoad = Number(
                (info.processCpuLoad * 100).toFixed(2)
            );
            this.initJVMCpu(info);
            this.cpuInfo = info;
        },
        initJVMCpu(info) {
            let chartDom = document.getElementById("jvmCpu");
            let myChart = echarts.init(chartDom, "dark");
            let option = {
                tooltip: {
                    formatter: "{a} <br/>{b} : {c}%",
                },
                series: [
                    {
                        name: "Pressure",
                        type: "gauge",
                        progress: {
                            show: true,
                        },
                        detail: {
                            valueAnimation: true,
                            formatter: "{value}%",
                        },
                        data: [
                            {
                                value: info.processCpuLoad,
                                name: "JVM CPU使用率",
                            },
                        ],
                    },
                ],
            };
            option && myChart.setOption(option);
            this.resize(myChart);
        },
        initSystemInfo(info) {
            info.forEach(item => {
                item.name = item.key;
            });
            this.systemInfo = info;
        },
        // 使Echarts等比例缩放
        resize(echarts) {
            window.addEventListener('resize', function () {
                echarts.resize()
            })
        }
    },
    async mounted() {
        await loadECharts();
        this.$axios
            .get(this.$url + "/admin/system/systemInfo")
            .then((res) => {
                this.initSystemInfo(res.data.data.systemInfo);
                this.initProcessInfo(res.data.data.processInfo);
                this.initMemoryInfo(res.data.data.memoryInfo[0]);
                this.initCpuInfo(res.data.data.cpuInfo[0]);
                
                this.loading = false;
            });
    },
};
</script>

<style lang="less">
.app {
    background: #100c2a;
}

.monitor-info {
    height: 500px;
}

.info-item {
    height: 450px;
}

.el-descriptions__body, .el-descriptions-item__label.is-bordered-label {
    background-color: transparent !important;
    color: white !important;
}
</style>