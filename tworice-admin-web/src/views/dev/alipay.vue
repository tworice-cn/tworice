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
        init() {
            // 初始化商品详情
            console.log("商品ID：",this.$route.params.id);
        },
        pay() {
            this.payForm.returnUrl = window.location.href
            this.payForm.notifyUrl = window.location.href
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
                this.payCont = res.data.data.content;
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
        submitOrder() {
            this.$root.loading = true;
            // 提交订单
            let order = {
                orderNo: this.$route.query.out_trade_no,
                payType: '支付宝支付',
                tradeNo:this.$route.query.trade_no
            };
            
            this.$axios({
                url:this .$url + '订单业务新增地址',
                method:'post',
                params:order
            }).then(res=>{
                if (res.data.status.code < 300) {
                    this.$message({
                        type:'success',
                        message:'购买成功'
                    })
                    // 跳转订单页
                } else{
                    this.init();
                    this.$router.push(this.$route.path);
                }
            }).catch(() => {
                this.$message({
                    type:'error',
                    message:'服务异常'
                })
                this.$router.push(this.$route.path);
            });
        },
    },
    mounted() {
        if (this.$route.query.out_trade_no) {
            this.submitOrder();
        } else {
            this.init();
        }
    },
};
</script>

<style scoped>
</style>