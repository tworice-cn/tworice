<template>
    <div class="message-sender">
        <el-form ref="form" :model="form" label-width="120px">
            <el-form-item label="所在分组">
                <el-select v-model="form.group" placeholder="请选择分组">
                    <el-option
                        v-for="item in groups"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="发送给谁">
                <el-input v-model="form.receiver" placeholder="请输入接收者标识"></el-input>
            </el-form-item>
            <el-form-item label="发送模式">
                <el-select v-model="form.mode" placeholder="请选择发送模式">
                    <el-option
                        v-for="item in modes"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="发送内容">
                <el-input type="textarea" v-model="form.message" ></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="warning" @click="connect">连接服务器</el-button>
                <el-button type="primary" @click="sendMessage">发送消息</el-button>
            </el-form-item>
        </el-form>
        <el-divider></el-divider>
        
        <el-input
            type="textarea"
            v-model="receivedMessages"
            disabled>
        </el-input>
        
    </div>
</template>

<script>
export default {
    data() {
        return {
            form: {
                group: 1,
                receiver: '1', // 发送给谁
                message: '',
                mode: 'TO_GROUP'
            },
            groups: [{label: '山西太原', value: 1}],
            modes: [{label: '单聊', value: 'TO_ONE'}, {label: '群聊', value: 'TO_GROUP'}, {label: '广播', value: 'TO_ALL'}],
            receivedMessages: '', // 收到的消息
            socket: null,
        };
    },
    methods: {
        connect() {
            const socket = new WebSocket('ws://127.0.0.1:18080/websocket');
            socket.addEventListener('open', (event) => {
                this.$message({
                    type: 'success',
                    message: '连接成功'
                })
                this.socket = socket;
                
                let data = {
                    uid: this.$utils.getLoginUserID(),
                    type: 'LOGIN'
                }
                if (this.form.group) {
                    data.gid = this.form.group
                }
                socket.send(JSON.stringify(data));
            });
            
            socket.addEventListener('message', (event) => {
                console.log('收到消息:', event);
                this.messageList.push(JSON.parse(event.data))
                // this.receivedMessages = this.receivedMessages + '\n' + JSON.parse(event.data).message;
            });
            
            socket.addEventListener('close', (event) => {
                console.log('连接断开:',event)
                this.$message({
                    type: 'warning',
                    message: '连接断开'
                })
            });
            
            socket.addEventListener('error', (event) => {
                console.error('WebSocket error:', event);
            });
            
            socket.addEventListener('beforeopen', (event) => {
                socket.setRequestHeader('Authorization', '123456');
            });
        },
        sendMessage() {
            if (this.socket && this.socket.readyState === WebSocket.OPEN) {
                let message = {
                    uid: this.$utils.getLoginUserID(),
                    content: this.form.message,
                    to: this.form.receiver,
                    type: this.form.mode
                }
                console.log('发送消息:', message)
                this.socket.send(JSON.stringify(message));
            } else {
                this.$message({
                    type: 'error',
                    message: '连接失败'
                })
            }
        },
    },
};
</script>
<style lang="less" scoped>
.message-sender {
    max-width: 600px;
    margin: 30px auto;
}
</style>
