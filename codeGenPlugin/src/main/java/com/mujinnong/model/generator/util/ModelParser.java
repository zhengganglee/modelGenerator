package com.mujinnong.model.generator.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

import com.mujinnong.model.generator.exception.ModelParseException;
import com.mujinnong.model.generator.meta.EntityConfigs;
import com.mujinnong.model.generator.meta.ModelNode;

public class ModelParser {

	/**
	 * 
	 * @param baseDir
	 * @return model objects as a tree, according to the path of the model file.
	 * @throws Exception
	 */
	public static ModelNode parse(String baseDir) throws Exception {
		File file = new File(baseDir);
		if (!file.isDirectory()) {
			throw new ModelParseException("baseDir: " + baseDir + " has to be a directory");
		}
		ModelNode tree = new ModelNode();
		tree.setPath(File.separator);
		traversalDirectory(file, tree);

		return tree;
	}

	private static void traversalDirectory(File file, ModelNode inputNode) throws Exception {
		if (file.isDirectory()) {
			
			if (file.getName().indexOf("svn")!=-1) {
				return;
			}
			File[] files = file.listFiles();
			List<ModelNode> childrenNodeList = new ArrayList<ModelNode>(files.length);
			for (File subfile : files) {
				ModelNode node = new ModelNode();
				node.setParentPath(inputNode.getPath());
				if (subfile.isDirectory()) {
					node.setPath(inputNode.getPath() + subfile.getName() + File.separator);
				} else {
					node.setPath(inputNode.getPath() + subfile.getName());
				}
				traversalDirectory(subfile, node);
				childrenNodeList.add(node);
			}
			inputNode.setChildren(childrenNodeList);
		} else {

			if (file.getName().indexOf("DS_Store")!=-1) {// Ignore .DS_Store for mac
				return;
			}
			inputNode.setEntityConfigs(parseEntityConfigsFromFile(file));
			inputNode.setLeaf(true);
		}
	}

	public static EntityConfigs parseEntityConfigsFromFile(File file) throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();

		Document document = builder.parse(file);

		EntityConfigs entityConfigs = (EntityConfigs) JAXBContext.newInstance(EntityConfigs.class).createUnmarshaller().unmarshal(document);

		// System.out.println(entityConfigs);

		return entityConfigs;
	}

}
