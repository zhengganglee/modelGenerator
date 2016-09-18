package com.netmodel.api.model.base;

import java.io.Serializable;
import java.util.List;

// @JsonIgnoreProperties(ignoreUnknown = true)
public class Data<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private long rows;

	private long total;

	// @JsonProperty("data")
	// @SerializedName("data")
	private List<T> modelList;

	private String sessionId;

	public long getRows() {
		return rows;
	}

	public void setRows(long rows) {
		this.rows = rows;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<T> getModelList() {
		return modelList;
	}

	public void setModelList(List<T> modelList) {
		this.modelList = modelList;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

}
