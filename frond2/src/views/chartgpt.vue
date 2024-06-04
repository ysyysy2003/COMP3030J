<template>
  <div>
    <v-header/>
    <div style="  padding-top: 100px;
  padding-bottom: 100px;
  position: relative;">
    <div class="chat-box">
      <div style="height: 50px; font-size: 20px; border-radius: 10px 10px 0 0;line-height: 50px;background-color: #48bbe2; color: #1a1e21; font-weight: 500">
<!--        <img src="../assets/images/chartgpt.jpg" style="width: 50px;height: 50px"/>-->
        Exchange Assistant </div>
      <div class="messages">
        <div
          v-for="(message, index) in messages"
          :key="index"
          :class="['message', messageClass(message)]"
        >
          <div class="bubble" >{{ message.content }}</div>
        </div>
      </div>
      <input
        v-model="inputMessage"
        @keyup.enter="sendMessage"
        placeholder="Send a message to Exchange Assistant..."
      />
    </div>
    </div>
    <v-footer/>
  </div>
</template>

<script>
import vHeader from './Header'
import vFooter from './footer'
export default {
  components: {
    vHeader,
    vFooter
  },
  name: 'chartgpt',
  data() {
    return {
      messages: [{content:'I am your exchange assistant, if you have any questions, please ask me.',    sender: "bot"}],
      inputMessage: ''
    };
  },
  methods: {
    sendMessage() {
      if (this.inputMessage.trim() === "") return;
      const userMessage = { content: this.inputMessage, sender: "user" };
      this.messages.push(userMessage);
      this.inputMessage = "";
      this.axios.post('/api/v1/product/get_ai/', userMessage).then(response => {
        console.log(response.data.data)
        const botMessage = {
          content: response.data.data,
          sender: "bot"
        };
        console.log(botMessage)
        this.messages.push(botMessage);
      }).catch(function (error) {
        console.log(error);
      });
    },
    messageClass(message) {
      return message.sender === "user" ? "user" : "bot";
    }
  }
}
</script>

<style scoped>
.chat-box {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  border: 1px solid #ccc;
  border-radius: 10px;
  padding: 25px;
  width: 80%;
  margin: auto;
  display: flex;
  flex-direction: column;
  height: 600px;
}
.messages {
  flex: 1;
  overflow-y: auto;
  margin-bottom: 10px;
  padding: 10px;
  background-color: #f9f9f9;
  border-radius: 10px;
}

.message {
  display: flex;
  margin-bottom: 10px;
}

.message.user {
  justify-content: flex-end;
}

.message.bot {
  justify-content: flex-start;
}

.bubble {
  max-width: 70%;
  text-align: left;
  padding: 10px;
  border-radius: 10px;
  position: relative;
}

.user .bubble {
  background-color: #007bff;
  color: white;
  border-bottom-right-radius: 0;
}

.bot .bubble {
  background-color: #e5e5ea;
  color: black;
  border-bottom-left-radius: 0;
}

input {
  border: 1px solid #ccc;
  border-radius: 20px;
  padding: 10px;
  width: calc(100% - 22px); /* Adjust for padding */
  outline: none;
  box-sizing: border-box;
}
</style>
