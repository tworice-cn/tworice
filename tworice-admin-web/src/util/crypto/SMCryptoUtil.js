// cryptoUtil.js
import { sm2, sm3, sm4 } from 'sm-crypto';
const defaultCipherMode = 1; // 1 表示 C1C3C2 格式，0 表示 C1C2C3
const KEY = '1234567890hijklm';
const IV = '1234567890123456';
export default {
    /**
     * SM2 加密
     * @param {String} plainText 要加密的明文
     * @param {String} publicKey SM2 公钥（16进制格式字符串）
     * @param {Number} cipherMode 加密模式：1（默认）或 0
     * @returns {String} 密文（16进制格式字符串）
     */
    sm2Encrypt(plainText, publicKey, cipherMode = defaultCipherMode) {
        try {
            return sm2.doEncrypt(plainText, publicKey, cipherMode);
        } catch (error) {
            console.error('SM2 加密失败：', error);
            return null;
        }
    },

    /**
     * SM2 解密
     * @param {String} cipherText SM2 密文（16进制格式字符串）
     * @param {String} privateKey SM2 私钥（16进制格式字符串）
     * @param {Number} cipherMode 加密模式：1（默认）或 0
     * @returns {String} 解密后的明文
     */
    sm2Decrypt(cipherText, privateKey, cipherMode = defaultCipherMode) {
        try {
            return sm2.doDecrypt(cipherText, privateKey, cipherMode);
        } catch (error) {
            console.error('SM2 解密失败：', error);
            return null;
        }
    },

    /**
     * SM3 摘要（哈希）
     * @param {String} message 输入字符串
     * @returns {String} 计算后的 SM3 哈希值（16进制格式字符串）
     */
    sm3Hash(message) {
        try {
            return sm3(message);
        } catch (error) {
            console.error('SM3 计算哈希失败：', error);
            return null;
        }
    },

    /**
     * SM4 加密
     * @param {String} plainText 要加密的明文
     * @param {String} key SM4 密钥（要求16字节，16进制字符串或普通字符串，根据配置）
     * @returns {String} SM4 密文（默认返回16进制字符串）
     */
    sm4Encrypt(plainText, key) {
        try {
            return sm4.encrypt(plainText, key);
        } catch (error) {
            console.error('SM4 加密失败：', error);
            return null;
        }
    },

    /**
     * SM4 解密
     * @param {String} cipherText SM4 密文（16进制格式字符串）
     * @param {String} key SM4 密钥（要求16字节，16进制字符串或普通字符串，根据配置）
     * @returns {String} 解密后的明文
     */
    sm4Decrypt(cipherText, key, iv) {
        try {
            key = key || KEY;
            iv = iv || IV;

            const keyHex = Buffer.from(key).toString('hex')
            const ivHex = Buffer.from(iv).toString('hex')
            const cipherBytes = Buffer.from(cipherText, 'base64')
            const cipherHex = cipherBytes.toString('hex')

            const decrypted = sm4.decrypt(cipherHex, keyHex, {
                mode: 'cbc',
                iv: ivHex,
                output: 'array'
            })
            return Buffer.from(decrypted).toString('utf8');
        } catch (error) {
            console.error('SM4 解密失败：', error);
            return null;
        }
    }
};
