package com.mujinnong.model.generator.meta.entity.component.search;

public class Item {
	/** 字段名称 */
	private String name;
	/** 字段类型 */
	private String type;
	/** 泛型类型(可选) */
	private String genericType;

	private String comment;

	@Override
	public String toString() {
		return String.format("Item [name=%s, type=%s, genericType=%s, comment=%s]", name, type, genericType, comment);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getGenericType() {
		return genericType;
	}

	public void setGenericType(String genericType) {
		this.genericType = genericType;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
