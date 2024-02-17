<template>
      <div id="main">
            <div style="width: 500px;height: 400px;">
                  <el-form ref="form" :model="payForm" label-width="200px">
                        <el-form-item label="商户订单号 ：">
                              <el-input v-model="payForm.outTradeNo"></el-input>
                        </el-form-item>
                        <el-form-item label="订单名称 ：">
                              <el-input v-model="payForm.subject"></el-input>
                        </el-form-item>
                        <el-form-item label="付款金额 ：">
                              <el-input v-model="payForm.totalAmount"></el-input>
                        </el-form-item>
                        <el-form-item label="商品描述：">
                              <el-input v-model="payForm.body"></el-input>
                        </el-form-item>
                  </el-form>
                  <span style="display: flex;justify-content: center;">
                        <el-button type="primary" @click="pay" style="width: 200px;text-align: center">支付</el-button>
                  </span>
                  <!-- <router-link to="/dev/goods/123">routerlink传参</router-link> -->

            </div>
            <!--接口返回的html代码渲染在页面上-->
            <div id="payDiv" v-html="payCont"></div>
      </div>
</template>

<script>
export default {
      name: "",
      props: [],
      data() {
            return {
                  //需要传到接口的必要参数
                  payForm: {
                        body: "",
                        outTradeNo: "",
                        subject: "",
                        totalAmount: "",
                  },
                  payCont: "",
            };
      },
      methods: {
            pay() {
                  
                  this.payForm.returnUrl=window.location.href
                  this.payForm.notifyUrl=window.location.href
                  let format = new FormData();
                  Object.keys(this.payForm).map((key) => {
                        format.append(key, this.payForm[key]);
                  });
                  console.log(this.payForm);
                  this.$axios({
                        method: "post",
                        url: this.$url + "pay/aliPay",
                        data: format,
                  }).then((res) => {
                        this.payCont=res.data.data.content;
                        /**
                         * this.$nextTick稍微解释一下：this.payCont 进行赋值的时候是异步的
                         * (1)如果不加this.$nextTick：有可能出现this.payCont还没有渲染完毕，我这边就submit了，这个时候控制台就会报找不到这个submit
                         * （2）加this.$nextTick：就是确保我已经渲染完成了，你去获取这个class完成提交。
                         *
                         */
                        this.$nextTick(() => {
                              //使用原生js去获取到渲染在页面上的from表单，我们手动的提交请求，转到支付页面
                              let payId =
                                    document.getElementsByName(
                                          "punchout_form"
                                    )[0];
                              //提交
                              payId.submit();
                        });
                  });
            },
            //生成订单编号---根据日期生成
            getWidoutTradeNo() {
                  let vNow = new Date();
                  let sNow = "";
                  sNow += String(vNow.getFullYear());
                  sNow += String(vNow.getMonth() + 1);
                  sNow += String(vNow.getDate());
                  sNow += String(vNow.getHours());
                  sNow += String(vNow.getMinutes());
                  sNow += String(vNow.getSeconds());
                  sNow += String(vNow.getMilliseconds());
                  this.payForm.outTradeNo = sNow;
            },
      },
      mounted() {
            console.log(this.$route.params.id);
            this.payForm.outTradeNo=this.$route.params.id;
      },
};
</script>

<style scoped>
</style>