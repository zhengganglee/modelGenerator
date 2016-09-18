package com.qinglicai.webapp.util;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class RequestUtils {
	
	private static Logger logger = LoggerFactory.getLogger(RequestUtils.class);

	@SuppressWarnings("unchecked")
	public static <T> T extractObjectFromRequest(HttpServletRequest request, String attributeName, Class<?> clazz) {
		String value = request.getParameter(attributeName);
		return (T) convertValueType(value, clazz);
	}

	public static <T> List<T> extractListObjectFromRequest(HttpServletRequest request, String attributeName, Class<T> listItemClass) {
		String value = request.getParameter(attributeName);

		if (StringUtils.isBlank(value)) {
			return null;
		}

		List<T> list = new ArrayList<T>();
		for (String item : value.split(",")) {
			list.add(convertValueType(item, listItemClass));
		}

		return list;
	}

	@SuppressWarnings({ "unchecked" })
	public static <T> T convertValueType(Object value, Class<T> targetType) {
		
		if (targetType.isEnum() && value != null) {
			
			String enumValue = value.toString();
			
			if (StringUtils.isBlank(enumValue)) {
				return null;
			}
			
			Enum<?> convertedValue = null;
			try {// 先尝试用源字符串转Enum
				convertedValue = Enum.valueOf(targetType.asSubclass(Enum.class),  enumValue);
			} catch (Exception e) {
				try {// 再先尝试源字符串全大写转Enum
					convertedValue = Enum.valueOf(targetType.asSubclass(Enum.class),  enumValue.toUpperCase());
				} catch (Exception e1) {
				}
			}
			if (convertedValue != null) {
				return (T) convertedValue;
			} else {
				
				// 正常的应该走不到这个条件
				logger.error("未能智能转换枚举类型 Class:{} value:{}", targetType, value);
				
				// 一般是枚举值有问题
				return null;
				
			}
		
		} else if (targetType.isAssignableFrom(java.util.Date.class)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				return (T) sdf.parse(value.toString());
			} catch (Exception e) {
				logger.error("日期类型转换失败 Class:{} value:{}", targetType, value);
			}
		}
		
		return (T) ConvertUtils.convert(value, targetType);
	}

}
