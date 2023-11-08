<template>
  <div>
    <input type="text" placeholder="输入所在组标识" v-model="group"/>
    <button @click="connect">连接服务器</button>
    <button @click="sendMessage">发送消息</button>
    <!-- <button @click="close">关闭连接</button> -->
    <br/>
    <input type="text" placeholder="输入接收方标识" v-model="to"/>
    <input type="text" placeholder="输入消息类型" v-model="type"/>
    <input type="text" placeholder="输入发送内容" v-model="message"/>

    <textarea placeholder="这里展示收到的消息" v-model="textarea" disabled></textarea>

    
  </div>
</template>

<script>
export default {
  data() {
    return {
      socket: null,
      group: '',
      textarea: '',
      to:'1',
      type:'TO_ONE',
      message:''
    };
  },
  methods: {
    connect() {
      const socket = new WebSocket('ws://127.0.0.1:18080/websocket?t=1');
      socket.addEventListener('open', (event) => {
        console.log('Connected to WebSocket');
        this.socket = socket;

        let data = {
          uid:JSON.parse(window.localStorage.getItem('admin')).id,
          type:'LOGIN'
        }
        if(this.group){
          data.gid=this.group
        }
        socket.send(JSON.stringify(data));
      });

      socket.addEventListener('message', (event) => {
        console.log('收到消息:', event.data);
        this.textarea=this.textarea+'\n'+event.data;
      });

      socket.addEventListener('close', (event) => {
        console.log('连接断开');
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
          uid:JSON.parse(window.localStorage.getItem('admin')).id,
          content:this.message,
          to:this.to,
          type:this.type
        }
        this.socket.send(JSON.stringify(message));
      }
    },
  },
};
</script>
