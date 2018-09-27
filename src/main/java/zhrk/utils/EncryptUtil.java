package zhrk.utils;

import java.net.URLDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.jfinal.kit.StrKit;

public class EncryptUtil {

	public static String sha1(String str) {
		if (StrKit.isBlank(str)) {
			return null;
		}
		MessageDigest sha = null;
		try {
			sha = MessageDigest.getInstance("SHA");
			sha.update(str.getBytes("utf8"));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		byte[] bytes = sha.digest();
		StringBuilder ret = new StringBuilder(bytes.length << 1);
		for (int i = 0; i < bytes.length; i++) {
			ret.append(Character.forDigit((bytes[i] >> 4) & 0xf, 16));
			ret.append(Character.forDigit(bytes[i] & 0xf, 16));
		}
		return ret.toString();
	}

	/**
	 * MD5加密
	 * 
	 * @param str
	 *            明文字符串
	 * @return 加密后字符串
	 * @throws Exception
	 */
	public static String md5(String str) {
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}

		char[] charArray = str.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++) {
			byteArray[i] = (byte) charArray[i];
		}
		byte[] md5Bytes = md5.digest(byteArray);

		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16) {
				hexValue.append("0");
			}
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();
	}
	
	public static void main(String[] args) {
		System.out.println(md5("admin123"));
	}
	/**
	 * 解码公用方法 
	 * @param str
	 * @param enc
	 * @return String
	 */
	public static String decode(String str,String enc){
		try {
			return URLDecoder.decode(str, enc); // url解码
		} catch (Exception e) {
			return "";
		}
	}
	
	/**
	 * 根据当前日期生成编号
	 * @return
	 * 2018年9月6日 下午4:16:08
	 */
	public static String getCode() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		return simpleDateFormat.format(new Date());
	}

}
