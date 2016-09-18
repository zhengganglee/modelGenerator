package com.qinglicai.webapp.util;

import com.netmodel.api.model.base.ApiResult;
import com.netmodel.api.model.base.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class ResponseUtils {

	private static Logger logger = LoggerFactory.getLogger(ResponseUtils.class);

	private static final long CODE_SUCCESS = 0;
	private static final String EMPTY = "";
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static ApiResult<?> wrap(long code, String message, Object respContent, boolean cacheModel) {
		ApiResult<Object> apiResult = new ApiResult<Object>();

		// code and message
		apiResult.setCode(code);
		apiResult.setMessage(message == null ? EMPTY : message);
		
		// set data
		Data<Object> respData = new Data<Object>();
		List<Object> modelList = new ArrayList<Object>();
		if (respContent != null) {
			if (respContent instanceof Collection) {
				modelList.addAll((Collection<?>) respContent);

				respData.setTotal(modelList.size());
			} else if (respContent instanceof Page) {
				Page page = (Page) respContent;
				modelList.addAll(page.getContent());

				respData.setTotal(page.getTotalElements());
			} else {
				modelList.add(respContent);

				respData.setTotal(1);
			}
			respData.setRows(modelList.size());
		}
		respData.setModelList(modelList);
		apiResult.setData(respData);
		
		return apiResult;
	}

	/**
	 * 构建一个成功的响应
	 * 
	 * @param respContent
	 *            响应类容，可以是单个响应体，也可以是个集合
	 * @return
	 */
	public static ApiResult<?> wrapSuccess(Object respContent) {
		return wrapSuccess(respContent, false);
	}
	
	/**
	 * 构建一个成功的响应
	 * 
	 * @param respContent
	 *            响应类容，可以是单个响应体，也可以是个集合
	 * @param cacheModel
	 *            是否为缓存Model，缓存model没有签名，走CDN缓存
	 * @return
	 */
	public static ApiResult<?> wrapSuccess(Object respContent, boolean cacheModel) {
		return wrap(CODE_SUCCESS, null, respContent, cacheModel);
	}



}
