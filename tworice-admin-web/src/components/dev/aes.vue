<template>
      <div>
            
      </div>
</template>

<script>
import CryptoJS from 'crypto-js';
const KEY = CryptoJS.enc.Utf8.parse('1234567890hijklm');
const IV = CryptoJS.enc.Utf8.parse('1234567890abcdef');
export default {
      name: "",
      props: [],
      data() {
            return {};
      },
      methods: {
            Decrypt(word) {
                  let base64 = CryptoJS.enc.Base64.parse(word);
                  let src = CryptoJS.enc.Base64.stringify(base64);

                  var decrypt = CryptoJS.AES.decrypt(src, KEY, {
                        iv: IV,
                        mode: CryptoJS.mode.CBC,
                        padding: CryptoJS.pad.ZeroPadding
                  });

                  var decryptedStr = decrypt.toString(CryptoJS.enc.Utf8);
                  return decryptedStr.toString();
            }
      },
      mounted(){
            this.$axios.get(this.$url+'/test').then(res=>{
                  let list=this.Decrypt(res.data.data.list)

                  console.log(list.substring(0,list.length-8));
            })
      }
};
</script>

<style scoped>
</style>