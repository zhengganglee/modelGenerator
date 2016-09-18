package com.mujinnong.model.generator.meta;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.mujinnong.model.generator.meta.entity.EntityConfig;

@XmlRootElement
public class EntityConfigs {

	private List<EntityConfig> entityConfigList;

	@Override
	public String toString() {
		return String.format("EntityConfigs [entityConfigList=%s]", entityConfigList);
	}

	public List<EntityConfig> getEntityConfigList() {
		return entityConfigList;
	}

	@XmlElement(name = "entityConfig")
	public void setEntityConfigList(List<EntityConfig> entityConfigList) {
		this.entityConfigList = entityConfigList;
	}

}
