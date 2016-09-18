package com.mujinnong.model.generator.meta.entity.component.action;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;

import com.mujinnong.model.generator.meta.entity.component.search.Item;

public class ActionItem extends Item {

	private SubItem requiredItems;

	private SubItem optionalItems;

	public boolean hashSubItem() {
		return (requiredItems != null && requiredItems.getSubItemList() != null && !requiredItems.getSubItemList().isEmpty())
				||
				(optionalItems != null && optionalItems.getSubItemList() != null && !optionalItems.getSubItemList().isEmpty());
	}

	@Override
	public String toString() {
		return String.format("Item [requiredItems=%s, optionalItems=%s, getName()=%s, getType()=%s, getGenericType()=%s, getComment()=%s]", requiredItems, optionalItems, getName(), getType(), getGenericType(), getComment());
	}

	public SubItem getRequiredItems() {
		return requiredItems;
	}

	@XmlElement(name = "requireds")
	public void setRequiredItems(SubItem requiredItems) {
		this.requiredItems = requiredItems;
	}

	public SubItem getOptionalItems() {
		return optionalItems;
	}

	@XmlElement(name = "optionals")
	public void setOptionalItems(SubItem optionalItems) {
		this.optionalItems = optionalItems;
	}

	public static class SubItem extends Item {
		private List<Item> subItemList;

		public List<Item> getSubItemList() {
			if (subItemList == null) {
				subItemList = new ArrayList<Item>();
			}
			return subItemList;
		}

		@XmlElement(name = "item")
		public void setSubItemList(List<Item> subItemList) {
			this.subItemList = subItemList;
		}

	}

}
