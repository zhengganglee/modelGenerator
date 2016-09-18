package com.mujinnong.model.generator.meta;

import java.util.List;

/**
 * @author gb
 * 
 */
public class ModelNode {

	private String path;

	private String parentPath;

	private List<ModelNode> children;

	private EntityConfigs entityConfigs;

	private boolean isLeaf = false;

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public List<ModelNode> getChildren() {
		return children;
	}

	public void setChildren(List<ModelNode> children) {
		this.children = children;
	}

	public EntityConfigs getEntityConfigs() {
		return entityConfigs;
	}

	public void setEntityConfigs(EntityConfigs entityConfigs) {
		this.entityConfigs = entityConfigs;
	}

	public boolean isLeaf() {
		return isLeaf;
	}

	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}

	public String toString() {
		return this.path;
	}

	public String getParentPath() {
		return parentPath;
	}

	public void setParentPath(String parentPath) {
		this.parentPath = parentPath;
	}

}
