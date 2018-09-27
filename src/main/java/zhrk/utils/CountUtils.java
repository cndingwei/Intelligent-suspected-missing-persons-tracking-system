package zhrk.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class CountUtils {

	public static final int ARRAY_SIZE = 20;
	public static final int RANDOM_MAX_SIZE = 100;

	public static void main(String[] args) {
		try {
			String area = "1957-08-26";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(area);
			System.out.println(getAgeByBirth(date));
			
			System.out.println(getForInte());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 随机生成100以内的某个数，判断奇偶
	 * @param array
	 * 2018年8月1日 下午3:24:46
	 */
	public static boolean getCount() {
		Random r = new Random();
		Integer flag = r.nextInt(RANDOM_MAX_SIZE);
		if(flag%2 == 0)
			return true;
		return false;
	}
	
	/**
	 * 0-100随机生成一个数字
	 * @return
	 * 2018年8月7日 下午5:35:23
	 */
	public static Integer getInt() {
		Random r = new Random();
		return r.nextInt(RANDOM_MAX_SIZE);
	}
	
	/**
	 * 四个数字随机生成一个数字
	 * @return
	 * 2018年9月27日 下午3:40:40
	 */
	public static Integer getForInte() {
		int [] arr = {0,1,2,3,4};
		//产生0-(arr.length-1)的整数值,也是数组的索引
		int index=(int)(Math.random()*arr.length);
		int rand = arr[index];
		return rand;
	}
	
	private static void bubbleSort(int[] array) {
		for (int i = 0; i < array.length - 1; i++) {
			for (int j = 0; j < array.length - i - 1; j++){
				if (array[j] < array[j + 1]) {
					int temp = array[j];
					array[j] = array[j + 1];
					array[j + 1] = temp;
				}
			}
		}
     }

	/**
	 * 年龄段划分
	 * @return
	 * 2018年9月23日 上午9:52:51
	 */
	public static List<String> getAreas() {
		List<String> list = new ArrayList<>();
		list.add("Infant");
		list.add("Teens");
		list.add("Middle");
		list.add("Elderly");
		return list;
	}
	
	public static Integer getAgeByBirth(Date birthday) {
		Integer age = 0;
        try {
            Calendar now = Calendar.getInstance();
            now.setTime(new Date());// 当前时间

            Calendar birth = Calendar.getInstance();
            birth.setTime(birthday);
            if (birth.after(now)) {//如果传入的时间，在当前时间的后面，返回0岁
                age = 0;
            } else {
                age = now.get(Calendar.YEAR) - birth.get(Calendar.YEAR);
                if (now.get(Calendar.DAY_OF_YEAR) > birth.get(Calendar.DAY_OF_YEAR)) {
                    age += 1;
                }
            }
            return age;
        } catch (Exception e) {//兼容性更强,异常后返回数据
           return 0;
        }
	}

	public static String getAgeName(Date birty) {
		Integer age = getAgeByBirth(birty);
		if(age > 0 && age < 6)
			return "Infant";
		if(age > 6 && age < 18)
			return "Teens";
		if(age > 18 && age < 60)
			return "Middle";
		return "Elderly";
	}
}
