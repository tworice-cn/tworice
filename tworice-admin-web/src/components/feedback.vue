<script>
import {type} from '@/api/feedback/feedback'
export default {
  name: "Feedback",
  props: {

  },
  data() {
    return {
      typeList:[],
      form: {
        id: '',
        createTime: '',
        updateTime: '',
        creator: '',
        fbType: '',
        fbDescribe: '',
        fbContact: '',
        fbImg: '',
      },
    };
  },
  methods: {
    changeType(type){
      this.form.fbType=type;
    }
  },
  mounted() {
    type().then(res=>{
      this.typeList=res.data.data.list
    })
  }
};
</script>

<template>
  <el-col class="feedback-container">
    <el-col :span="24" class="feedback-header">
      <h3>{{form.fbType?'请填写反馈信息':'请选择反馈类型'}}</h3>
    </el-col>

    <el-col :span="24" class="feedback-type" v-if="form.fbType==''">
      <el-col :span="24" class="type-item" v-for="item in typeList" :key="item.type" @click.native="changeType(item.type)">
        <el-col :span="20" class="item-left">
          <el-col :span="24" class="type-title">{{item.type}}</el-col>
          <el-col :span="24" class="type-msg">{{item.msg}}</el-col>
        </el-col>
        <el-col :span="4" class="item-right el-icon-arrow-right"></el-col>
      </el-col>
    </el-col>


    <el-col :span="24" class="feedback-form" v-if="form.fbType">
      <form @submit.prevent="submitFeedback">
        <div class="form-group">
          <label for="name">姓名：</label>
          <input type="text" id="name" v-model="name" required>
        </div>
        <div class="form-group">
          <label for="email">邮箱：</label>
          <input type="email" id="email" v-model="email" required>
        </div>
        <div class="form-group">
          <label for="message">反馈内容：</label>
          <textarea id="message" v-model="message" required></textarea>
        </div>
        <button type="submit" class="submit-button">提交反馈</button>
      </form>
    </el-col>
  </el-col>
</template>

<style scoped lang="less">
.feedback-container {
  margin: 0 auto;
  padding: 20px;
}

.feedback-header {
  text-align: center;
  margin-bottom: 40px;
  margin-top: 75px;
}
/* 反馈类型 */
.feedback-type{
  border-bottom: 1px solid rgba(0,0,0,.1);

  .type-item{
    padding: 12px 34px;
    align-items: center;
    display: flex;
    border-top: 1px solid rgba(0,0,0,.1);
    cursor: pointer;

    .item-left{
      .type-title{
        font-size: 16px;
        line-height: 40px;
      }

      .type-msg{
        font-size: 12px;
        color: rgba(0,0,0,.5);
      }
    }

    .item-right{
      display: flex;
      justify-content: right;
      align-items: center;
    }

  }
}

.feedback-form {
  display: flex;
  flex-direction: column;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 10px;
}

label {
  display: block;
}

input[type="text"], input[type="email"], textarea {
  width: 100%;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.submit-button {
  width: 100%;
  padding: 10px;
  background-color: #4CAF50;
  color: white;
  font-size: 16px;
  border: none;
  cursor: pointer;
}
</style>