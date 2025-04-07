import CryptoJS from 'crypto-js';

const KEY = "12345678";
export default {

    /**
     * DES 解密工具函数
     * @param {String} cipherText 加密后的字符串（Base64 格式）
     * @param {String} key 密钥（要求为8字节，不足时自动补 "="，超过时截取前8位）
     * @returns {String} 解密后的明文
     */
    desDecrypt(cipherText, key) {
        if (!key) {
            key = KEY;
        }

        // 处理密钥：不足8字节则补 "="，超过则截取前8字节
        let processedKey = key;
        const keyUtf8 = CryptoJS.enc.Utf8.parse(processedKey);
        if (keyUtf8.sigBytes < 8) {
            console.log("密钥不足8字节，已自动补齐");
            while (CryptoJS.enc.Utf8.parse(processedKey).sigBytes < 8) {
                processedKey += "=";
            }
        }
        if (CryptoJS.enc.Utf8.parse(processedKey).sigBytes > 8) {
            // 截取前8个字符
            processedKey = processedKey.substr(0, 8);
        }
        // 将处理后的密钥转换为 CryptoJS 可识别的格式
        const keyHex = CryptoJS.enc.Utf8.parse(processedKey);

        // 解密：传入 ciphertext 参数时，需要构造 CipherParams 对象
        const decrypted = CryptoJS.DES.decrypt(
            { ciphertext: CryptoJS.enc.Base64.parse(cipherText) },
            keyHex,
            {
                mode: CryptoJS.mode.ECB,
                padding: CryptoJS.pad.Pkcs7,
            }
        );
        return decrypted.toString(CryptoJS.enc.Utf8);
    }
};
