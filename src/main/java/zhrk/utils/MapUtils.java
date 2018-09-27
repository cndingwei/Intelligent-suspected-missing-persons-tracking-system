package zhrk.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class MapUtils {

	 /**
     * JavaBean对象转化成Map对象
     * @param javaBean
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static Map<String, Object> java2Map(Object javaBean) {
        Map map = new HashMap();
        try {
            // 获取javaBean属性
            BeanInfo beanInfo = Introspector.getBeanInfo(javaBean.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            if (propertyDescriptors != null && propertyDescriptors.length > 0) {
                String propertyName = null; // javaBean属性名
                Object propertyValue = null; // javaBean属性值
                for (PropertyDescriptor pd : propertyDescriptors) {
                    propertyName = pd.getName();
                    if (!propertyName.equals("class")) {
                        Method readMethod = pd.getReadMethod();
                        propertyValue = readMethod.invoke(javaBean, new Object[0]);
                        map.put(propertyName.toUpperCase(), propertyValue);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }  
        return map;
    }
}
