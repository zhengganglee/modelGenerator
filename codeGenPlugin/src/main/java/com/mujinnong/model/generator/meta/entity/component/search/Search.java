package com.mujinnong.model.generator.meta.entity.component.search;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;

import com.mujinnong.model.generator.meta.entity.component.Service;

public class Search {
	/**
	 * 查询的名称
	 */
	private String searchName;
	/**
	 * 每条查询条件
	 */
	private List<Item> itemList = new ArrayList<Item>();

	/**
	 * 该查询是否支持分页
	 */
	private boolean pageable = false;

	private Service service;

	private String comment;

	/**
	 * 标明Search需要uid参数（即登陆）
	 */
	private boolean requiredUid = false;

	@Override
	public String toString() {
		return String.format("Search [searchName=%s, itemList=%s, pageable=%s, service=%s, comment=%s, requiredUid=%s]", searchName, itemList, pageable, service, comment, requiredUid);
	}

	public String getSearchName() {
		return searchName;
	}

	@XmlAttribute(name = "sname")
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public List<Item> getItemList() {
		return itemList;
	}

	@XmlElement(name = "item")
	public void setItemList(List<Item> itemList) {
		this.itemList = itemList;
	}

	public boolean isPageable() {
		return pageable;
	}

	@XmlAttribute
	public void setPageable(boolean pageable) {
		this.pageable = pageable;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public boolean isRequiredUid() {
		return requiredUid;
	}

	@XmlAttribute(name = "requiredUid")
	public void setRequiredUid(boolean requiredUid) {
		this.requiredUid = requiredUid;
	}

}
