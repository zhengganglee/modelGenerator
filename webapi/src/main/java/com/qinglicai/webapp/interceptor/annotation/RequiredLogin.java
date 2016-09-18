package com.qinglicai.webapp.interceptor.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Controller需要登录的注解标识，支持方法和类（优先识别方法上的注解）
 * 
 * @author Li Zhenggang
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.METHOD, ElementType.TYPE })
public @interface RequiredLogin {

	ResultType value() default ResultType.JSON;

}
