package com.qinglicai.webapp.interceptor.annotation;

import com.qinglicai.webapp.interceptor.AuthorizeInterceptor;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 请求是否需要签名
 * 
 * @author Li Zhenggang
 * 
 * @see AuthorizeInterceptor
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface RequestSign {

	/**
	 * 默认需要签名
	 * 
	 * @return
	 */
	boolean required() default true;

}
