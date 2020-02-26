package com.enmotech.clanalysis.util;

import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

public final class EntityUtil {

	/**
	 * 判断某个类是否具有指定的属性
	 *
	 * @param cls
	 * @param property
	 * @return
	 */
	public final static boolean isExistsProperty(Class<?> cls, String property) {
		boolean exists = false;
		Field[] fields = cls.getDeclaredFields();
		for (Field field : fields) {
			if (field.getName().equals(property)) {
				exists = true;
				break;
			}
		}
		if (!exists && !"java.lang.Object".equals(cls.getSuperclass().getName()))
			exists = isExistsProperty(cls.getSuperclass(), property);

		return exists;
	}

	/**
	 * @param params
	 *            查询条件参数
	 * @param object
	 *            数据对象
	 * @param isLinked
	 *            是否关联
	 */
	public static String createHQLParams(Object object, List<Object> params, boolean isLinked) {
		String queryString = "";
		Class cls = object.getClass();
		Field[] fields = cls.getDeclaredFields();
		for (Field field : fields) {
			String property = field.getName();
			String getMethod = "get" + property.substring(0, 1).toUpperCase() + property.substring(1);
			try {
				Method m = cls.getMethod(getMethod);
				Object val = m.invoke(object);
				if (StringUtils.isEmpty(val) && "status".equals(property)) {
					queryString += " and status != -1";
				} else if (!StringUtils.isEmpty(val)) {
					if (isLinked) {
						queryString += " and " + cls.getSimpleName().toLowerCase() + "." + property + " =?";
					} else {
						queryString += " and " + property + " = ?";
					}
					params.add(val);
				}
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}

		return queryString;
	}
}
