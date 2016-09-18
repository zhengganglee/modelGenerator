package com.mujinnong.model.generator.meta.entity.component.action;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;

import com.mujinnong.model.generator.meta.entity.component.search.Item;

public class Action {
	/**
	 * 动作名称
	 */
	private String actionName;

	/**
	 * 参数列表
	 */
	private List<ActionItem> itemList;

	/**
	 * 动作类型，create or update
	 */
	private String method;

	/**
	 * 根节点请求，默认请求是：/{packagePath}/{modelName}/{@link #actionName}， 为真是则是：/{packagePath}/{modelName}
	 */
	private boolean root = false;

	private String comment;

	/**
	 * 标明Search需要uid参数（即登陆）
	 */
	private boolean requiredUid = false;

	public List<Item> getAllItemList() {
		List<Item> allItemList = new ArrayList<Item>();
		if (this.getItemList() != null) {
			int length = this.getItemList().size();
			for (int i = 0; i < length; i++) {
				ActionItem subItem = this.getItemList().get(i);

				if (subItem.hashSubItem()) {
					if (subItem.getRequiredItems() != null) {
						allItemList.addAll(subItem.getRequiredItems().getSubItemList());
					}
					if (subItem.getOptionalItems() != null) {
						allItemList.addAll(subItem.getOptionalItems().getSubItemList());
					}
				} else {
					allItemList.add(subItem);
				}
			}
		}
		return allItemList;
	}

	@Override
	public String toString() {
		return String.format("Action [actionName=%s, itemList=%s, method=%s, root=%s, comment=%s, requiredUid=%s]", actionName, itemList, method, root, comment, requiredUid);
	}

	public String getActionName() {
		return actionName;
	}

	@XmlAttribute(name = "name")
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public List<ActionItem> getItemList() {
		if (itemList == null) {
			itemList = new ArrayList<ActionItem>();
		}
		return itemList;
	}

	@XmlElement(name = "item")
	// @XmlElementWrapper(name = "items")
	public void setItemList(List<ActionItem> itemList) {
		this.itemList = itemList;
	}

	public String getMethod() {
		return method;
	}

	@XmlAttribute(name = "method")
	public void setMethod(String method) {
		this.method = method;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public boolean isRoot() {
		return root;
	}

	@XmlAttribute(name = "root")
	public void setRoot(boolean root) {
		this.root = root;
	}

	public boolean isRequiredUid() {
		return requiredUid;
	}

	@XmlAttribute(name = "requiredUid")
	public void setRequiredUid(boolean requiredUid) {
		this.requiredUid = requiredUid;
	}

}
