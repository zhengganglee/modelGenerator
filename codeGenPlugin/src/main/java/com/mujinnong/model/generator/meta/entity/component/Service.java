package com.mujinnong.model.generator.meta.entity.component;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;

public class Service {

	private String name;

	private List<String> paramList;

	public String getName() {
		return name;
	}

	@XmlAttribute(name = "name")
	public void setName(String name) {
		this.name = name;
	}

	public List<String> getParamList() {
		return paramList;
	}

	@XmlElement(name = "param")
	public void setParamList(List<String> paramList) {
		this.paramList = paramList;
	}

}
