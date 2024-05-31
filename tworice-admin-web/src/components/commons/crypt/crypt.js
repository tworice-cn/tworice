
import AesUtil from "@/util/AESUtil";
export default {

    /**
     * TODO 待完善统一加密
     * @param data
     */
    encrypt:function (data){

    },

    decrypt: function (data) {
        switch (data.type) {
            case 'AES':
                return AesUtil.Decrypt(data.crypt).replace(/[^\x20-\x7E\u4E00-\u9FFF]+/g, "");
            case 'Base64':
                // Base64解密
                return decodeURIComponent(escape(atob(data.crypt)))
        }
    }
}