package com.mujinnong.model.generator.meta.entity;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;

import com.mujinnong.model.generator.meta.entity.component.action.Action;
import com.mujinnong.model.generator.meta.entity.component.search.Search;

public class EntityConfig {

	private String name;

	private String type;

	private boolean export = true;

	/**
	 * 标明Controller需要uid参数
	 */
	private boolean requiredUid = false;
	
	/**
	 * 标明Controller可以缓存（与cache目录下的model一样，这种方式可以兼容旧的model）
	 */
	private boolean cacheable = false;

	/**
	 * model的父类，取值“.user.UserInfo”
	 */
	private String extendsClass;

	private List<Property> propertiesList = new ArrayList<Property>();

	private List<Search> searchList = new ArrayList<Search>();

	private List<Action> actionList = new ArrayList<Action>();

	@Override
	public String toString() {
		return String.format("EntityConfig [name=%s, type=%s, export=%s, requiredUid=%s, cacheable=%s, extendsClass=%s, propertiesList=%s, searchList=%s, actionList=%s]", name, type, export, requiredUid, cacheable, extendsClass, propertiesList, searchList, actionList);
	}

	public String getName() {
		return name;
	}

	@XmlAttribute
	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	@XmlAttribute
	public void setType(String type) {
		this.type = type;
	}

	public boolean isExport() {
		return export;
	}

	@XmlAttribute
	public void setExport(boolean export) {
		this.export = export;
	}

	public boolean isRequiredUid() {
		return requiredUid;
	}

	@XmlAttribute
	public void setRequiredUid(boolean requiredUid) {
		this.requiredUid = requiredUid;
	}

	public boolean isCacheable() {
		return cacheable;
	}

	@XmlAttribute
	public void setCacheable(boolean cacheable) {
		if (this.requiredUid && cacheable) {
			throw new IllegalArgumentException("需要uid的model不支持缓存参数：cacheable");
		}
		this.cacheable = cacheable;
	}

	public List<Property> getPropertiesList() {
		return propertiesList;
	}

	public String getExtendsClass() {
		return extendsClass;
	}

	@XmlAttribute(name = "extends")
	public void setExtendsClass(String extendsClass) {
		this.extendsClass = extendsClass;
	}

	@XmlElement(name = "property")
	public void setPropertiesList(List<Property> propertiesList) {
		this.propertiesList = propertiesList;
	}

	public List<Search> getSearchList() {
		return searchList;
	}

	@XmlElement(name = "search")
	public void setSearchList(List<Search> searchList) {
		this.searchList = searchList;
	}

	public List<Action> getActionList() {
		return actionList;
	}

	@XmlElement(name = "action")
	public void setActionList(List<Action> actionList) {
		this.actionList = actionList;
	}

}
