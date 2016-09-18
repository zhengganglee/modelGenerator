package com.mujinnong.model.generator.meta.entity;

public class Property {

	private String defaultValue;

	private String name;

	private String type;

	/** 泛型类型(可选) */
	private String genericType;

	private boolean ref = false;

	private String path;

	private String cnName;// for enum type

	private String displayName;// for enum type

	private String id;// for enum type

	private boolean queryKey;

	private String comment;

	@Override
	public String toString() {
		return String.format("Property [defaultValue=%s, name=%s, type=%s, genericType=%s, ref=%s, path=%s, cnName=%s, displayName=%s, id=%s, queryKey=%s, comment=%s]", defaultValue, name, type, genericType, ref, path, cnName, displayName, id, queryKey, comment);
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
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

	public boolean isRef() {
		return ref;
	}

	public void setRef(boolean ref) {
		this.ref = ref;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getCnName() {
		return cnName;
	}

	public void setCnName(String cnName) {
		this.cnName = cnName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public boolean isQueryKey() {
		return queryKey;
	}

	public void setQueryKey(boolean queryKey) {
		this.queryKey = queryKey;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
