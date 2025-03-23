<script>
import {type, submitForm} from '@/api/feedback/feedback'
import Editor from '@/components/commons/editor/Editor.vue'

export default {
    name: "Feedback",
    components: {
        Editor
    },
    data() {
        return {
            typeList: [],
            form: {
                id: '',
                createTime: '',
                updateTime: '',
                creator: '',
                fbType: '',
                fbDescribe: '',
                fbContact: '',
                typeName: '',
                fbState: '处理中'
            },
        };
    },
    methods: {
        changeType(typeId, typeName) {
            this.form.fbType = typeId;
            this.form.typeName = typeName;
        },
        submit() {
            submitForm(this.form).then(res => {
                if (res.data.status.code < 400) {
                    this.form.fbType = '';
                }
            })
        }
    },
    mounted() {
        type().then(res => {
            this.typeList = res.data.data.list
        })
    }
};
</script>

<template>
    <el-col class="feedback-container">
        <el-col :span="24" class="feedback-header">
            <h3>{{ form.fbType ? '请填写【' + form.typeName + '】反馈信息' : '请选择反馈类型' }}</h3>
        </el-col>
        
        <el-col :span="24" class="feedback-type" v-if="form.fbType==''">
            <el-col :span="24" class="type-item" v-for="item in typeList" :key="item.id"
                    @click.native="changeType(item.id,item.typeName)">
                <el-col :span="20" class="item-left">
                    <el-col :span="24" class="type-title">{{ item.typeName }}</el-col>
                    <el-col :span="24" class="type-msg">{{ item.typeDesc }}</el-col>
                </el-col>
                <el-col :span="4" class="item-right el-icon-arrow-right"></el-col>
            </el-col>
        </el-col>
        
        
        <el-col :span="24" class="feedback-form" v-if="form.fbType">
            <form @submit="submit">
                <div class="form-group">
                    <label for="email">联系邮箱：</label>
                    <el-input type="email" id="email" v-model="form.fbContact" required/>
                </div>
                <div class="form-group">
                    <label for="message">反馈内容：</label>
                    <Editor ref="editor" v-model="form.fbDescribe"></Editor>
                </div>
                <button type="submit" class="submit-button">提交反馈</button>
                <el-col :span="24" class="reset">
                    <el-link @click="form.fbType=''">重新选择</el-link>
                </el-col>
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
    margin-top: 40px;
}

/* 反馈类型 */
.feedback-type {
    border-bottom: 1px solid rgba(0, 0, 0, .1);
    
    .type-item {
        padding: 12px 34px;
        align-items: center;
        display: flex;
        border-top: 1px solid rgba(0, 0, 0, .1);
        cursor: pointer;
        
        .item-left {
            .type-title {
                font-size: 16px;
                line-height: 40px;
            }
            
            .type-msg {
                font-size: 12px;
                color: rgba(0, 0, 0, .5);
            }
        }
        
        .item-right {
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
    
    .form-group {
        margin-bottom: 10px;
        
        label {
            display: block;
            line-height: 30px;
        }
    }
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

.reset {
    margin-top: 10px;
    text-align: center;
}
</style>