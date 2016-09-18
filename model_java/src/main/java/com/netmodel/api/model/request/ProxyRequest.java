package com.netmodel.api.model.request;

import com.netmodel.api.model.base.ApiResult;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.GsonHttpMessageConverter;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProxyRequest implements IProxyRequest {

	public String proxyApi = "http://172.16.22.114:9091/proxy_core-0.0.1-SNAPSHOT";
	
	@Override
	@Deprecated
	public <T> void doRequest(String url, Map<String, String> params, String httpMethod, Class<T> clazz, RequestCallback requestCallback) {
		doRequest(url, params, httpMethod, true, clazz, requestCallback);
	}

	@Override
	public <T> void doRequest(String url, Map<String, String> params, String httpMethod, boolean urlCacheMode, Class<T> clazz, RequestCallback requestCallback) {
		try {
			T result = send(url, params, httpMethod, clazz);
			final ApiResult<?> apiResult = (ApiResult<?>) result;
			requestCallback.HttpResponseOk(clazz, apiResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public <T> T send(String url, Map<String, String> params, String httpMethod, Class<T> clazz) {
		if (HTTP_METHOD_GET.equals(httpMethod)) {
			StringBuilder builder = new StringBuilder();

			Map<String, String> uriVariables = new HashMap<String, String>();
			for (Map.Entry<String, String> paramEntry : params.entrySet()) {
				if (builder.length() > 0) {
					builder.append("&");
				}
				builder.append(paramEntry.getKey()).append("={").append(paramEntry.getKey()).append("}");
				uriVariables.put(paramEntry.getKey(), paramEntry.getValue());
			}
			builder.insert(0, "?").insert(0, url);
			// System.out.println(uriVariables);
			// System.out.println(builder.toString());
			return getFormObject(builder.toString(), clazz, uriVariables);
		} else if (HTTP_METHOD_POST.equals(httpMethod) || HTTP_METHOD_PUT.equals(httpMethod)) {
			MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
			for (Map.Entry<String, String> paramEntry : params.entrySet()) {
				body.add(paramEntry.getKey(), paramEntry.getValue());
			}

			if (HTTP_METHOD_POST.equals(httpMethod)) {
				return postFormObject(url, clazz, body);
			} else {
				return putFormObject(url, clazz, body);
			}
		}
		throw new RuntimeException("不支持的请求类型, url=" + url + ", httpMethod=" + httpMethod);
	}

	public <T> T getFormObject(String url, Class<T> clazz, Map<String, ?> uriVariables) {
		HttpHeaders requestHeaders = getRequestHeaders(HttpMethod.GET);

		HttpEntity<?> requestEntity = new HttpEntity<Object>(requestHeaders);

		ResponseEntity<T> responseEntity;
		if (uriVariables != null) {
			responseEntity = getRestTemplate(HttpMethod.GET).exchange(url, HttpMethod.GET, requestEntity, clazz, uriVariables);
		} else {
			responseEntity = getRestTemplate(HttpMethod.GET).exchange(url, HttpMethod.GET, requestEntity, clazz);
		}

		return responseEntity.getBody();
	}

	public <T> T postFormObject(String url, Class<T> clazz, MultiValueMap<String, String> body) {
		HttpHeaders requestHeaders = getRequestHeaders(HttpMethod.POST);

		HttpEntity<?> requestEntity = new HttpEntity<Object>(body, requestHeaders);

		ResponseEntity<T> responseEntity = getRestTemplate(HttpMethod.POST).exchange(url, HttpMethod.POST, requestEntity, clazz);

		return responseEntity.getBody();
	}

	public <T> T putFormObject(String url, Class<T> clazz, MultiValueMap<String, String> body) {
		HttpHeaders requestHeaders = getRequestHeaders(HttpMethod.PUT);

		HttpEntity<?> requestEntity = new HttpEntity<Object>(body, requestHeaders);

		ResponseEntity<T> responseEntity = getRestTemplate(HttpMethod.PUT).exchange(url, HttpMethod.PUT, requestEntity, clazz);

		return responseEntity.getBody();
	}

	public HttpHeaders getRequestHeaders(HttpMethod httpMethod) {
		HttpHeaders requestHeaders = new HttpHeaders();

		requestHeaders.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		if (HttpMethod.POST == httpMethod || HttpMethod.PUT == httpMethod) {
			requestHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		}

		return requestHeaders;
	}

	public RestTemplate getRestTemplate(HttpMethod httpMethod) {
		HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();

		requestFactory.setConnectTimeout(5000);

		requestFactory.setReadTimeout(5000);

		RestTemplate restTemplate = new RestTemplate(requestFactory);

		// Set a custom GsonHttpMessageConverter that supports the application/json media type
		GsonHttpMessageConverter gsonHttpMessageConverter = new GsonHttpMessageConverter();
		List<MediaType> supportedMediaTypes = new ArrayList<MediaType>();
		supportedMediaTypes.add(new MediaType("application", "json", Charset.forName("UTF-8")));
		gsonHttpMessageConverter.setSupportedMediaTypes(supportedMediaTypes);

		List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
		messageConverters.add(gsonHttpMessageConverter);
		if (HttpMethod.POST == httpMethod || HttpMethod.PUT == httpMethod) {
			messageConverters.add(new FormHttpMessageConverter());
		}
		// messageConverters.add(new StringHttpMessageConverter());
		restTemplate.setMessageConverters(messageConverters);
		return restTemplate;
	}

	public String getProxyApi() {
		return proxyApi;
	}

	public void setProxyApi(String proxyApi) {
		this.proxyApi = proxyApi;
	}

}
