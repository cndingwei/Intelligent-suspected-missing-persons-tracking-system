package zhrk.utils;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class IdcardUtil {

	private final static Map<String, String> cityMap;  
	//粗略的校验  
    private static final Pattern pattern = Pattern.compile("^(\\d{6})(19|20)(\\d{2})(1[0-2]|0[1-9])(0[1-9]|[1-2][0-9]|3[0-1])(\\d{3})(\\d|X|x)?$");  
  
    /** 
     * 18位身份证校验,粗略的校验 
     * @param idCard 
     * @return 
     */  
    public static boolean is18ByteIdCard(CharSequence idCard){  
        return pattern.matcher(idCard).matches();  
    }  
	
    /**
     * 根据身份编号获取年龄
     * @param idCard
     * @return 年龄
     */
    public static int getAgeByIdCard(String idCard) {
        int iAge = 0;
        Calendar cal = Calendar.getInstance();
        String year = idCard.substring(6, 10);
        int iCurrYear = cal.get(Calendar.YEAR);
        iAge = iCurrYear - Integer.valueOf(year);
        return iAge;
    }

    /**
     * 根据身份编号获取生日
     * @param idCard 身份编号
     * @return 生日(yyyyMMdd)
     */
    public static String getBirthByIdCard(String idCard) {
        return idCard.substring(6, 14);
    }

    /**
     * 根据身份编号获取生日年
     * @param idCard 身份编号
     * @return 生日(yyyy)
     */
    public static Short getYearByIdCard(String idCard) {
        return Short.valueOf(idCard.substring(6, 10));
    }

    /**
     * 根据身份编号获取生日月
     * @param idCard 身份编号
     * @return 生日(MM)
     */
    public static Short getMonthByIdCard(String idCard) {
        return Short.valueOf(idCard.substring(10, 12));
    }

    /**
     * 根据身份编号获取生日天
     * @param idCard 身份编号
     * @return 生日(dd)
     */
    public static Short getDateByIdCard(String idCard) {
        return Short.valueOf(idCard.substring(12, 14));
    }

    /**
     * 根据身份编号获取性别
     * @param idCard 身份编号
     * @return 性别(M-男，F-女，N-未知)
     */
    public static Integer getGenderByIdCard(String idCard) {
        String sGender = "未知";
        String sCardNum = idCard.substring(16, 17);
        if (Integer.parseInt(sCardNum) % 2 != 0) {
            sGender = "1";//男
        } else {
            sGender = "0";//女
        }
        return Integer.parseInt(sGender);
    }
    
	public static boolean is18ByteIdCardComplex(CharSequence idCard){  
        int[] prefix = new int[]{7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};  
        char[] suffix = new char[]{ '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' };  
        if(is18ByteIdCard(idCard)){  
            if(cityMap.get(idCard.subSequence(0,2).toString()) == null ){  
                return false;  
            }  
            int idCardWiSum=0;  //用来保存前17位各自乖以加权因子后的总和  
            for(int i=0;i<17;i++){  
                idCardWiSum+=(idCard.charAt(i) - '0') *prefix[i];  
            }  
  
            int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置  
            char idCardLast=idCard.charAt(17);//得到最后一位身份证号码  
  
            return idCardLast == suffix[idCardMod];  
        }  
        return false;  
    } 
	
	static {  
        cityMap = new HashMap<>();  
        cityMap.put("11", "北京");  
        cityMap.put("12", "天津");  
        cityMap.put("13", "河北");  
        cityMap.put("14", "山西");  
        cityMap.put("15", "内蒙古");  
  
        cityMap.put("21", "辽宁");  
        cityMap.put("22", "吉林");  
        cityMap.put("23", "黑龙江");  
  
        cityMap.put("31", "上海");  
        cityMap.put("32", "江苏");  
        cityMap.put("33", "浙江");  
        cityMap.put("34", "安徽");  
        cityMap.put("35", "福建");  
        cityMap.put("36", "江西");  
        cityMap.put("37", "山东");  
  
        cityMap.put("41", "河南");  
        cityMap.put("42", "湖北");  
        cityMap.put("43", "湖南");  
        cityMap.put("44", "广东");  
        cityMap.put("45", "广西");  
        cityMap.put("46", "海南");  
  
        cityMap.put("50", "重庆");  
        cityMap.put("51", "四川");  
        cityMap.put("52", "贵州");  
        cityMap.put("53", "云南");  
        cityMap.put("54", "西藏");  
  
        cityMap.put("61", "陕西");  
        cityMap.put("62", "甘肃");  
        cityMap.put("63", "青海");  
        cityMap.put("64", "宁夏");  
        cityMap.put("65", "新疆");  
  
        cityMap.put("71", "台湾");  
        cityMap.put("81", "香港");  
        cityMap.put("82", "澳门");  
        cityMap.put("91", "国外");  
    }  
	
	public static void main(String[] args) {
		String idcard="460200199209275127";
        String sr=getBirthByIdCard(idcard);
        System.out.println("生日:" + sr);
	}
}
