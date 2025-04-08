
import AesUtil from "@/util/AESUtil";
import DesUtil from "@/util/crypto/DesUtil"
import SMCryptoUtil from '@/util/crypto/SMCryptoUtil';
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
            case 'DES':
                return DesUtil.desDecrypt(data.crypt,null).replace(/[^\x20-\x7E\u4E00-\u9FFF]+/g, "");
            case 'SM4':
                return SMCryptoUtil.sm4Decrypt(data.crypt,null).replace(/[^\x20-\x7E\u4E00-\u9FFF]+/g, "");
            case 'Base64':
                // Base64解密
                return decodeURIComponent(escape(atob(data.crypt)));
            default:
                return AesUtil.Decrypt(data.crypt).replace(/[^\x20-\x7E\u4E00-\u9FFF]+/g, "");
        }
    }
}