import CryptoJS from 'crypto-js';
const KEY = CryptoJS.enc.Utf8.parse('1234567890hijklm');
const IV = CryptoJS.enc.Utf8.parse('1234567890abcdef');
export default {
      Decrypt:function (word, keyStr, ivStr) {
            let key = KEY;
            let iv = IV;

            if (keyStr) {
                  key = CryptoJS.enc.Utf8.parse(keyStr);
                  iv = CryptoJS.enc.Utf8.parse(ivStr);
            }

            let base64 = CryptoJS.enc.Base64.parse(word);
            let src = CryptoJS.enc.Base64.stringify(base64);

            var decrypt = CryptoJS.AES.decrypt(src, key, {
                  iv: iv,
                  mode: CryptoJS.mode.CBC,
                  padding: CryptoJS.pad.ZeroPadding
            });

            var decryptedStr = decrypt.toString(CryptoJS.enc.Utf8);
            return decryptedStr.toString();
      },

      Encrypt:function (word, keyStr, ivStr) {
            let key = KEY;
            let iv = IV;
            if (keyStr) {
                  key = CryptoJS.enc.Utf8.parse(keyStr);
                  iv = CryptoJS.enc.Utf8.parse(ivStr);
            }

            let base64 = CryptoJS.enc.Base64.stringify(word);
            let src = CryptoJS.enc.Base64.parse(base64);

            var encrypted = CryptoJS.AES.encrypt(src, key, {
                  iv: iv,
                  mode: CryptoJS.mode.CBC,
                  padding: CryptoJS.pad.ZeroPadding
            });

            var encryptedStr = encrypted.ciphertext.toString(CryptoJS.enc.Base64);
            return encryptedStr;
      }
}
