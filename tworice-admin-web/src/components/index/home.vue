<template>
      <el-col :span="24" class="big-screen">
            <el-col :span="24" class="head">
                  <h1>实时监控分析大屏</h1>
                  <div class="time" id="showTime">
                        {{ currentTime }}
                        <i class="el-icon-full-screen" @click="switchState"></i>
                  </div>
            </el-col>
            <el-col :span="24" class="chart-box">
                  <el-col :span="7" class="min-height left-box">
                        <el-col :span="24" class="min-height chart-item-box chart-1">
                              <el-col :span="24" class="chart-title">系统内存 <i class="el-icon-view" @click="toPage('/tools/monitor')"></i></el-col>
                              <el-col :span="24" class="chart-item" id="chart-1"></el-col>
                        </el-col>
                        <el-col :span="24" class="min-height chart-item-box chart-2">
                              <el-col :span="24" class="chart-title">登录异常 <i class="el-icon-view" @click="toPage('/log/loginLog')"></i></el-col>
                              <el-col :span="24" class="chart-item" id="chart-2"></el-col>
                        </el-col>
                  </el-col>
                  <el-col :span="10" class="min-height left-box">
                        <el-col :span="24" class="min-height chart-item-box chart-3">
                              <el-col :span="24" class="chart-title">在线人数 <i class="el-icon-view" @click="toPage('/tools/online')"></i></el-col>
                              <el-col :span="24" class="chart-item online-box-box" id="chart-3">
                                    当前在线人数 <span class="online-box">{{ online }}</span> 人
                              </el-col>
                        </el-col>
                        <el-col :span="24" class="min-height chart-item-box chart-4">
                              <el-col :span="24" class="chart-title">操作异常 <i class="el-icon-view" @click="toPage('/log/log')"></i></el-col>
                              <el-col :span="24" class="chart-item" id="chart-4">
                                    <el-col
                                          :span="24"
                                          class="log-item"
                                          v-for="item in adminLog"
                                          :key="item.id"
                                    >
                                          {{ item.admin }}【{{ item.ipAddr }}】于{{
                                                $utils.formatDate(item.createTime)
                                          }}【{{ item.active }}】
                                    </el-col>
                              </el-col>
                        </el-col>
                        <el-col :span="24" class="min-height chart-item-box chart-5">
                              <el-col :span="24" class="chart-title">最新获得管理员权限账户 <i class="el-icon-view" @click="toPage('/system/role')"></i></el-col>
                              <el-col :span="24" class="chart-item" id="chart-5">
                                    <table border="0" cellspacing="0">
                                          <tr>
                                                <th>用户编号</th>
                                                <th>用户账号</th>
                                                <th>用户昵称</th>
                                          </tr>
                                          <tr v-for="item in admin" :key="item.id">
                                                <th>{{ item.id }}</th>
                                                <td>{{ item.loginName }}</td>
                                                <td>{{ item.nickName }}</td>
                                          </tr>
                                    </table>

                                    <!-- <el-col :span="24" class="log-item" v-for="item in adminLog" :key="item.id">
                                          {{item.admin}}【{{item.ipAddr}}】于{{$utils.formatDate(item.createTime)}}【{{item.active}}】
                                    </el-col> -->
                              </el-col>
                        </el-col>
                  </el-col>
                  <el-col :span="7" class="min-height left-box">
                        <el-col :span="24" class="min-height chart-item-box chart-6">
                              <el-col :span="24" class="chart-title">流量监控 <i class="el-icon-view" @click="toPage('/tools/admin')"></i></el-col>
                              <el-col :span="24" class="chart-item" id="chart-6"></el-col>
                        </el-col>
                        <el-col :span="24" class="min-height chart-item-box chart-7">
                              <el-col :span="24" class="chart-title">访问IP</el-col>
                              <el-col :span="24" class="chart-item" id="chart-7"></el-col>
                        </el-col>
                        <!-- <el-col :span="24" class="min-height chart-item-box chart-8">
                              <el-col :span="24" class="chart-title">标题1</el-col>
                              <el-col :span="24" class="chart-item" id="chart-8"></el-col>
                        </el-col> -->
                  </el-col>
            </el-col>
      </el-col>
</template>

<script>
export default {
      props: [],
      data() {
            return {
                  currentTime: "2023/03/22 18:17:19",
                  online: 1,
                  adminLog: [],
                  admin: [],
                  echarts1: "",
                  echarts2: "",
                  echarts3: "",
                  echarts4: "",
                  echarts5: "",
                  echarts6: "",
                  echarts7: "",
                  secondsInterval:'',
                  minuteInterval:''
            };
      },
      methods: {
            switchState(){
                  if(this.$route.path=='/bigScreen'){
                        this.$router.push('/admin/home')
                  }else{
                        this.$router.push('/bigScreen')
                  }
                  
            },
            toPage(page){
                  this.$emit('handleSelect',page);
                  this.$router.push(page);
            },
            initEcharts1() {
                  let echartsData = [];
                  this.$axios.get(this.$url + "/admin/system/systemInfo").then((res) => {
                        let data = res.data.data.processInfo;
                        let sum =
                              parseInt(data[2].value) +
                              parseInt(data[3].value) +
                              parseInt(data[4].value);
                        echartsData.push({ value: parseInt(data[2].value), name: data[2].key });
                        echartsData.push({ value: parseInt(data[3].value), name: data[3].key });
                        echartsData.push({ value: parseInt(data[4].value), name: data[4].key });
                        echartsData.push({
                              value: sum,
                              itemStyle: { color: "none", decal: { symbol: "none" } },
                              label: {
                                    show: false,
                              },
                        });

                        let option = {
                              tooltip: {
                                    trigger: "item",
                              },
                              legend: {
                                    top: "5%",
                                    left: "center",
                                    selectedMode: false,
                                    textStyle: {
                                          color: "#ffffff", //字体颜色
                                    },
                              },
                              series: [
                                    {
                                          name: "系统内存",
                                          type: "pie",
                                          radius: ["40%", "70%"],
                                          center: ["50%", "70%"],
                                          // adjust the start angle
                                          startAngle: 180,
                                          label: {
                                                show: true,
                                                formatter(param) {
                                                      // correct the percentage
                                                      return (
                                                            param.name +
                                                            " (" +
                                                            param.percent * 2 +
                                                            "%)"
                                                      );
                                                },
                                          },
                                          data: echartsData,
                                    },
                              ],
                        };
                        option && this.echarts1.setOption(option);
                  });
            },
            initEcharts2() {
                  this.$axios.get(this.$url + "/admin/monitor/log").then((res) => {
                        let xAxisData = [];
                        let seriesData = [];
                        res.data.data.monitor.forEach((item) => {
                              xAxisData.push(item.name);
                              seriesData.push(item.value);
                        });
                        let option = {
                              tooltip: {
                                    trigger: "axis",
                                    axisPointer: {
                                          type: "shadow",
                                    },
                              },
                              xAxis: {
                                    type: "category",
                                    data: xAxisData,
                              },
                              yAxis: {
                                    type: "value",
                              },
                              series: [
                                    {
                                          data: seriesData,
                                          type: "bar",
                                          itemStyle: {
                                                barBorderRadius: [2, 2, 0, 0], //柱体圆角   
                                                color: new this.$echarts.graphic.LinearGradient(
                                                      //前四个参数用于配置渐变色的起止位置，这四个参数依次对应 右下左上 四个方位。也就是从右边开始顺时针方向。
                                                      //通过修改前4个参数，可以实现不同的渐变方向
                                                      /*第五个参数则是一个数组，用于配置颜色的渐变过程。
                                                      每项为一个对象，包含offset和color两个参数
                                                      */
                                                      0, 0, 0, 1, [{
                                                            offset: 0, //offset范围是0~1，用于表示位置，0是指0%处的颜色
                                                            color: '#fbc20c'
                                                      },
                                                      {
                                                            offset: 1, //指100%处的颜色
                                                            color: '#f08441'
                                                      }
                                                      ]
                                                ),
                                          }
                                    },
                              ],
                        };

                        option && this.echarts2.setOption(option);
                  });
            },
            initEcharts3() {
                  this.$axios
                        .get(this.$url + "/admin/system/online?page=0&pageSize=100")
                        .then((res) => {
                              this.online = Object.keys(res.data.data.list).length;
                        });
            },
            initEcharts4() {
                  this.$axios.get(this.$url + "/admin/monitor/operation").then((res) => {
                        this.adminLog.push(res.data.data.monitor[0]);
                        this.adminLog.push(res.data.data.monitor[1]);
                        this.adminLog.push(res.data.data.monitor[2]);
                        this.adminLog.push(res.data.data.monitor[3]);
                        this.adminLog.push(res.data.data.monitor[4]);
                  });
            },
            initEcharts5() {
                  this.$axios
                        .get(this.$url + "admin/system/role/adminList?roleId=2")
                        .then((res) => {
                              let length = res.data.data.adminList.length;
                              for (let i = length - 1; i >= 0 && i >= length - 3; i--) {
                                    this.admin.push(res.data.data.adminList[i]);
                              }
                        });
            },
            initEcharts6() {
                  this.$axios.get(this.$url + "admin/monitor/flow").then((res) => {
                        let xAxisData = [];
                        let seriesData = [];
                        let time = res.data.data.time;
                        Object.keys(time).forEach((item) => {
                              xAxisData.push(item);
                              seriesData.push(time[item]);
                        });
                        let option = {
                              tooltip: {
                                    trigger: 'axis'
                              },
                              xAxis: {
                                    type: "category",
                                    data: xAxisData,
                              },
                              yAxis: {
                                    type: "value",
                              },
                              series: [
                                    {
                                          data: seriesData,
                                          type: "line",
                                          smooth: true,
                                          areaStyle: {
                                                normal: {
                                                      color: {
                                                            x: 0,
                                                            y: 0,
                                                            x2: 0,
                                                            y2: 1,
                                                            colorStops: [
                                                                  {
                                                                        offset: 0,
                                                                        color: "rgba(255,255,255,1)", // 0% 处的颜色
                                                                  },
                                                                  {
                                                                        offset: 0.5,
                                                                        color: "rgba(67,104,219,.5)", // 50% 处的颜色
                                                                  },
                                                                  {
                                                                        offset: 1,
                                                                        color: "rgba(33,54,139,0)", // 100% 处的颜色
                                                                  },
                                                            ],
                                                            globalCoord: false,
                                                      },
                                                },
                                          },
                                    },
                              ],
                        };

                        option && this.echarts6.setOption(option);
                        this.initEcharts7(res.data.data.ip);
                  });
            },
            initEcharts7(ip) {
                  let xAxisData = [];
                  let seriesData = [];
                  Object.keys(ip).forEach((item) => {
                        xAxisData.push(item);
                        seriesData.push(ip[item]);
                  });

                  let option = {
                        tooltip: {
                              trigger: "axis",
                              axisPointer: {
                                    type: "shadow",
                              },
                        },
                        legend: {},
                        grid: {
                              left: "3%",
                              right: "4%",
                              bottom: "3%",
                              containLabel: true,
                        },
                        xAxis: {
                              type: "value",
                              boundaryGap: [0, 0.01],
                        },
                        yAxis: {
                              type: "category",
                              data: xAxisData,
                        },
                        series: [
                              {
                                    type: "bar",
                                    data: seriesData,
                              },
                        ],
                  };

                  option && this.echarts7.setOption(option);
            },
            initECharts() {
                  this.initEcharts1();
                  this.initEcharts2();
                  this.initEcharts3();
                  this.initEcharts4();
                  this.initEcharts5();
                  this.initEcharts6();
                  this.minuteInterval=setInterval(()=>{
                        this.initEcharts6();
                  },60000);
                  
            },
            initTime() {
                  this.secondsInterval=setInterval(() => {
                        let dt = new Date();
                        var y = dt.getFullYear();
                        var mt = dt.getMonth() + 1;
                        var day = dt.getDate();
                        var h = dt.getHours(); //获取时
                        var m = dt.getMinutes(); //获取分
                        var s = dt.getSeconds(); //获取秒
                        this.currentTime =
                              y +
                              "/" +
                              this.Appendzero(mt) +
                              "/" +
                              this.Appendzero(day) +
                              " " +
                              this.Appendzero(h) +
                              ":" +
                              this.Appendzero(m) +
                              ":" +
                              this.Appendzero(s) +
                              "";
                  }, 1000);
            },
            Appendzero(obj) {
                  if (obj < 10) return "0" + "" + obj;
                  else return obj;
            },
      },
      mounted() {
            var chartDom = document.getElementById("chart-1");
            this.echarts1 = this.$echarts.init(chartDom);
            chartDom = document.getElementById("chart-2");
            this.echarts2 = this.$echarts.init(chartDom);
            chartDom = document.getElementById("chart-6");
            this.echarts6 = this.$echarts.init(chartDom);
            chartDom = document.getElementById("chart-7");
            this.echarts7 = this.$echarts.init(chartDom);

            this.initTime();
            this.initECharts();
      },
      beforeDestroy(){
            clearInterval(this.secondsInterval);
            clearInterval(this.minuteInterval);
      }
};
</script>

<style lang="less" scoped>
.left-box {
      padding: 0 10px;
}
.big-screen {
      height: 100vh;
      padding: 0;
      overflow: auto;

      background: #000d4a url(~@/assets/BigScreen/images/bg.jpg) center center;
      background-size: cover;
      color: #fff;
      font-size: 0.1rem;
}
.head {
      height: 5rem;
      background: url(~@/assets/BigScreen/images/head_bg.png) no-repeat center center;
      background-size: 100% 100%;
      position: relative;
}
.head h1 {
      color: #399bff;
      text-align: center;
      font-size: 2.2rem;
      line-height: 3.8rem;
      letter-spacing: -1px;
}
.head h1 img {
      width: 1.5rem;
      display: inline-block;
      vertical-align: middle;
}
.time {
      position: absolute;
      right: 0.35rem;
      top: 0;
      line-height: 3.75rem;
      color: rgba(255, 255, 255, 0.7);
      font-size: 1.4rem;
      padding-right: 0.5rem;
      font-family: electronicFont;
}
.chart-box {
      padding: 15px;
}
.chart-item-box {
      margin: 10px;
      background-color: rgba(6, 48, 109, 0.5);
      padding: 10px;

      .chart-title {
            line-height: 40px;
            font-size: 15px;
            color: white;
      }
      .chart-item {
            width: 100%;
            height: 100%;
      }
}

@font-face {
      font-family: electronicFont;
      src: url(~@/assets/BigScreen/font/DS-DIGIT.TTF);
}
.chart-1 {
      height: 18rem;
}
.chart-2 {
      height: 18rem;
}
.chart-3 {
      height: 10rem;
}
.chart-4 {
      height: 13rem;
}
.chart-5 {
      height: 12rem;
}
.chart-6 {
      height: 18rem;
}
.chart-7 {
      height: 18rem;
}
#chart-3 {
      color: #fef000;
      text-align: center;
      line-height: 7rem;
}
.online-box-box{
      font-size:2.2rem;
}
.online-box {
      font-family: Impact, Haettenschweiler, "Arial Narrow Bold", sans-serif;
      font-size: 4.2rem;
}

table {
      width: 100%;
      text-align: center;
}
table th {
      font-size: 0.16rem;
      background: rgba(0, 0, 0, 0.1) !important;
      color: #fff !important;
}
table td {
      font-size: 0.16rem;
      color: rgba(255, 255, 255, 0.6);
}
table th,
table td {
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      padding: 0.1rem 0;
}

.log-item {
      line-height: 25px;
}
i{
      cursor: pointer;
}
</style>
