package com.netmodel.api.model.request;


public class RequestConfig {

	private static IProxyRequest proxyRequest = new ProxyRequest();

	public static IProxyRequest getProxyRequest() {
		return proxyRequest;
	}

	public static void setProxyRequest(IProxyRequest proxyRequest) {
		RequestConfig.proxyRequest = proxyRequest;
	}

}
