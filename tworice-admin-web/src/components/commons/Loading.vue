<!--加载动画组件-->
<template>
    <div id="loading-main">
        <div class="loading">
            <div class="loading-item loading-one"></div>
            <div class="loading-item loading-two"></div>
            <div class="loading-item loading-three"></div>
            <div class="loading-item loading-four"></div>
            <div class="loading-item loading-five"></div>
        </div>
    </div>
</template>

<script>
export default {
    props: [],
    data() {
        return {};
    },
};
</script>

<style scoped>
#loading-main {
    width: 100vw;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    background: gray;
    opacity: 0.5;
    z-index: 9999;
}
.loading{
	margin: 40vh auto;
	width: 50px;
	height: 50px;
	display: flex;
	transform: rotate(180deg);
      
      
}
.loading-item{
	width: 10px;
	height: 50px;
      z-index: 99999;
}
.loading-one{
	background-color: #2983bb;
	animation: loading 1.5s linear infinite 0.8s;
}
.loading-two{
	background-color: #229453;
	animation: loading 1.5s linear infinite 0.6s;
}
.loading-three{
	background-color: #74787a;
	animation: loading 1.5s linear infinite 0.4s;
}
.loading-four{
	background-color: #fba414;
	animation: loading 1.5s linear infinite 0.2s;
}
.loading-five{
	background-color: #de1c31;
	animation: loading 1.5s linear infinite;
}
@keyframes loading{
	0%{height: 10px;}
	50%{height: 50px;}
	100%{height: 10px;}
}

.loading-circle{
	width: 60px;
	height: 60px;
	margin: 0 auto;
	background-color: #f5f5f5;
	color: #666;
	border-radius: 50%;
	font-size: 12px;
	text-align: center;
	line-height: 60px;
	position: relative;
	animation: textColor 1.5s linear infinite;
}
.loading-circle::before{
	content: "";
	position: absolute;
	top: -4px;
	left: -4px;
	right: -4px;
	bottom: -4px;
	z-index: -2;
	border-radius: 50%;
	background: linear-gradient(to bottom,#2983bb,#229453,#fba414,#de1c31);
	animation: rotate 1.5s linear infinite;
}
@keyframes rotate{
	from{transform: rotate(0deg);}
	to{transform: rotate(360deg);}
}
@keyframes textColor{
	0%{color: transparent;}
	50%{color: #666;}
	100%{color: transparent;}
}
</style>