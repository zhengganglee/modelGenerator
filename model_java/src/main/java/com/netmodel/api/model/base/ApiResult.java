package com.netmodel.api.model.base;

import java.io.Serializable;
import java.util.List;

/**
 * return wrapper from proxy service
 * 
 * @param <T>
 */
// @JsonIgnoreProperties(ignoreUnknown = true)
public class ApiResult<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private Data<T> data;

	private long code = -1;

	private String message;

	// ============================ 便捷方法
	// @JsonIgnore
	public T firstModel() {
		if (this.allModel() == null || this.allModel().size() == 0) {
			return null;
		}
		return this.allModel().get(0);
	}

	// @JsonIgnore
	public List<T> allModel() {
		if (this.getData() == null) {
			return null;
		}
		return this.getData().getModelList();
	}

	public ApiResult<T> setSessionId(String sessionId) {
		this.data.setSessionId(sessionId);
		return this;
	}

	// ============================ getter and setter
	public Data<T> getData() {
		return data;
	}

	public void setData(Data<T> data) {
		this.data = data;
	}

	public long getCode() {
		return code;
	}

	public void setCode(long code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
