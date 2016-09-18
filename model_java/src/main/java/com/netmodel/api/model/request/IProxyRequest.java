package com.netmodel.api.model.request;

import java.util.Map;

public interface IProxyRequest {

	public static final String HTTP_METHOD_GET = "GET";
	public static final String HTTP_METHOD_POST = "POST";
	public static final String HTTP_METHOD_PUT = "PUT";

	public String getProxyApi();

	// public <T> T getFormObject(String url, Class<T> clazz, Map<String, ?> uriVariables);
	//
	// public <T> T postFormObject(String url, Class<T> clazz, MultiValueMap<String, String> body);

	/**
	 * 4.1.2弃用，代替{@link #doRequest(String, Map, String, boolean, Class, RequestCallback)}。多了一个boolean参数urlCacheMode，true表示请求链接以可缓存的方式生成。
	 * @param url
	 * @param params
	 * @param httpMethod
	 * @param clazz
	 * @param requestCallback
	 */
	@Deprecated
	public <T> void doRequest(String url, Map<String, String> params, String httpMethod, Class<T> clazz, RequestCallback requestCallback);
	
	/**
	 * 
	 * @param url
	 * @param params
	 * @param httpMethod
	 * @param urlCacheMode true表示请求链接以可缓存的方式生成（没有签名、没有公告参数）；
	 * @param clazz
	 * @param requestCallback
	 */
	public <T> void doRequest(String url, Map<String, String> params, String httpMethod, boolean urlCacheMode, Class<T> clazz, RequestCallback requestCallback);

	// public <T> void doGet(String url, Class<T> clazz, Map<String, ?> uriVariables, RequestCallback requestCallback);
	//
	// public <T> void doPost(String url, Class<T> clazz, MultiValueMap<String, String> body, RequestCallback requestCallback);
	//
	// public <T> void doPut(String url, Class<T> clazz, MultiValueMap<String, String> body, RequestCallback requestCallback);

	// public <T> void handleException(Exception exception, RequestCallback<T> requestCallback);

}
