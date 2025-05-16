
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
                return AesUtil.Decrypt(data.crypt).replace(/\p{C}/gu, "");
            case 'DES':
                return DesUtil.desDecrypt(data.crypt,null).replace(/\p{C}/gu, "");
            case 'SM4':
                return SMCryptoUtil.sm4Decrypt(data.crypt, null, null).replace(/\p{C}/gu, "");
            case 'SM2+SM4':
                return SMCryptoUtil.sm4Decrypt(data.crypt, null, null).replace(/\p{C}/gu, "");
            case 'Base64':
                return decodeURIComponent(escape(atob(data.crypt)));
            default:
                return AesUtil.Decrypt(data.crypt).replace(/\p{C}/gu, "");
        }
    }
}