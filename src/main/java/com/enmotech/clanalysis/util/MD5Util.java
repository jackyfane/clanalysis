package com.enmotech.clanalysis.util;

import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;
import java.util.Base64;

/**
 * Created by Administrator on 2015/5/26.
 */
public final class MD5Util {
	private final static String KEY_MD5 = "MD5";

	private final static String KEY_SHA = "SHA";

	private final static String KEY_HMAC = "HmacMD5";

	/**
	 * BASE64解码
	 *
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static byte[] decryptBASE64(String key) throws Exception {
		Base64.Decoder decoder = Base64.getDecoder();
		return decoder.decode(key);
	}

	/**
	 * BASE64编码
	 *
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static String encryptBASE64(String key) throws Exception {
		return MD5Util.encryptBASE64(key.getBytes());
	}

	/**
	 * BASE64编码
	 *
	 * @param bytes
	 * @return
	 * @throws Exception
	 */
	public static String encryptBASE64(byte[] bytes) throws Exception {
		Base64.Encoder encoder = Base64.getEncoder();
		return encoder.encodeToString(bytes);
	}

	/**
	 * MD5不可逆加密： 使用MD5算法得到的字节数组再进行一次Base64编码得到一组密钥
	 *
	 * @param encrypt
	 * @return
	 * @throws Exception
	 */
	public static String encryptMD5(String encrypt) throws Exception {
		MessageDigest md5 = MessageDigest.getInstance(KEY_MD5);
		md5.update(encrypt.getBytes());
		String encryptStr = MD5Util.encryptBASE64(md5.digest());

		return encryptStr;
	}

	/**
	 * SHA算法
	 *
	 * @param encrypt
	 * @return
	 * @throws Exception
	 */
	public static String encryptSHA(String encrypt) throws Exception {
		MessageDigest md5 = MessageDigest.getInstance(KEY_SHA);
		md5.update(encrypt.getBytes());

		Base64.Encoder encoder = Base64.getEncoder();
		String encryptStr = encoder.encodeToString(md5.digest());

		return encryptStr;
	}

	/**
	 * HMAC初始化
	 *
	 * @return
	 * @throws Exception
	 */
	public static String initMacKey() throws Exception {
		KeyGenerator keyGenerator = KeyGenerator.getInstance(KEY_HMAC);
		SecretKey secretKey = keyGenerator.generateKey();
		return encryptBASE64(secretKey.getEncoded());
	}

	/**
	 * HMAC加密
	 *
	 * @param data
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static String encryptHMAC(byte[] data, String key) throws Exception {
		SecretKey secretKey = new SecretKeySpec(decryptBASE64(key), KEY_HMAC);
		Mac mac = Mac.getInstance(secretKey.getAlgorithm());
		mac.init(secretKey);
		byte[] bytes = mac.doFinal(data);
		return new String(bytes);
	}

	public static void main(String[] args) throws Exception {
		String password = "12312312";

		System.out.println(encryptBASE64(password));

		String encryptStr = MD5Util.encryptMD5(password);
		System.out.println("MD5加密：" + encryptStr);

		encryptStr = MD5Util.encryptSHA(password);
		System.out.println("SHA加密：" + encryptStr);
	}
}
