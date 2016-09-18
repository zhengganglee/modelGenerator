package com.mujinnong.model.generator.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.mujinnong.model.generator.meta.ModelNode;
import com.mujinnong.model.generator.meta.entity.EntityConfig;
import org.apache.commons.io.FilenameUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class CodeGenerator {
	
	private static boolean stringPropertyDefaultEmpty;

	public static void setStringPropertyDefaultEmpty(boolean stringPropertyDefaultEmpty) {
		CodeGenerator.stringPropertyDefaultEmpty = stringPropertyDefaultEmpty;
	}

	public static void generate(ModelNode modelTree, String pathPrefix, String templatePathDir, String targetPath, boolean exportEnabled, boolean singleOutput) throws Exception {
		// if (modelTree.isLeaf()) {
		// for (EntityConfig entityConfig : modelTree.getEntityConfigs().getEntityConfigList()) {
		// generateFromTemplate(templatePathDir, targetPath, modelTree.getParentPath(), pathPrefix, exportEnabled, Collections.singletonList(entityConfig));
		// }
		// } else {
		// for (ModelNode node : modelTree.getChildren()) {
		// generate(node, pathPrefix, templatePathDir, targetPath, exportEnabled, singleOutput);
		// }
		// }

		Map<EntityConfig, ModelNode> configMap = allCongfigFormModelTree(modelTree);
		if (singleOutput) {
			List<EntityConfig> entityConfigList = new ArrayList<EntityConfig>();
			entityConfigList.addAll(configMap.keySet());
			String parentPath = "";
			generateFromTemplate(templatePathDir, targetPath, parentPath, pathPrefix, exportEnabled, entityConfigList);
		} else {
			for (EntityConfig entityConfig : configMap.keySet()) {
				String parentPath = configMap.get(entityConfig).getParentPath();
				generateFromTemplate(templatePathDir, targetPath, parentPath, pathPrefix, exportEnabled, Collections.singletonList(entityConfig));
			}
		}

	}

	private static Map<EntityConfig, ModelNode> allCongfigFormModelTree(ModelNode modelTree) {
		Map<EntityConfig, ModelNode> configMap = new LinkedHashMap<EntityConfig, ModelNode>();
		// List<EntityConfig> entityConfigList = new ArrayList<EntityConfig>();
		if (modelTree.isLeaf()) {
			for (EntityConfig entityConfig : modelTree.getEntityConfigs().getEntityConfigList()) {
				configMap.put(entityConfig, modelTree);
			}
			// entityConfigList.addAll(modelTree.getEntityConfigs().getEntityConfigList());
		} else {
			if (modelTree.getChildren() != null) {
				for (ModelNode node : modelTree.getChildren()) {
					// entityConfigList.addAll(allCongfigFormModelTree(node));
					configMap.putAll(allCongfigFormModelTree(node));
				}
			}
		}
		// return entityConfigList;
		return configMap;
	}

	private static final String ENTIRY = "entity";
	private static final String ENUM = "enum";
	private static final String ENTIRY_ALIAS = "object";
	private static final char CLASS_PATHS_SEPARATOR = '.';

	public static void generateFromTemplate(String templatePath, String targetPath, String path, String pathPrefix, boolean exportEnabled, List<EntityConfig> entityConfigList) throws Exception {
		File templateFile = new File(templatePath);
		if (templateFile.isDirectory()) {
			for (File file : templateFile.listFiles()) {

				String filename = file.getName();
				if (filename.contains("svn") || filename.contains("DS_Store")) {
					continue;
				}

				String newPathPrefix = file.isFile() ? pathPrefix
						: FilenameUtils.concat(pathPrefix, FilenameUtils.getBaseName(filename));
				generateFromTemplate(file.getAbsolutePath(), targetPath, path, newPathPrefix, exportEnabled, entityConfigList);
			}
		} else {
			if (entityConfigList.size() == 1) {
				boolean shouldGenerate = generateController(templateFile.getAbsolutePath(), targetPath, path, pathPrefix, entityConfigList.get(0), exportEnabled);
				if (shouldGenerate) {
					generateSingleFile(templatePath, targetPath, path, pathPrefix, entityConfigList);
				}
			} else {
				// 所有model只生成1个文件
//				List<EntityConfig> shouldGenerateEntityConfigList = new ArrayList<EntityConfig>();
//				for (EntityConfig entityConfig : entityConfigList) {
//					boolean shouldGenerate = generateController(templateFile.getAbsolutePath(), targetPath, path, pathPrefix, entityConfig, exportEnabled);
//					if (shouldGenerate) {
//						shouldGenerateEntityConfigList.add(entityConfig);
//					}
//				}
//				if (entityConfigList.size() > 0) {
					generateSingleFile(templatePath, targetPath, path, pathPrefix, entityConfigList);
//				}
			}
		}

	}

	private static boolean generateController(String templatePath, String targetPath, String path, String pathPrefix, EntityConfig entityConfig, boolean exportEnabled) throws Exception {
		String baseName = FilenameUtils.getBaseName(templatePath);
		if (ENTIRY.equals(baseName) || ENUM.equals(baseName)) {
			if ((ENUM.equals(entityConfig.getType()) && ENUM.equals(baseName))// 生成model，限制entity与enum不交叉生成
					|| ((ENTIRY.equals(entityConfig.getType()) || ENTIRY_ALIAS.equals(entityConfig.getType())) && ENTIRY.equals(baseName))) {
				// generateSingleFile(templatePath, targetPath, path, pathPrefix, entityConfig);
				return true;
			}
		} else {
			if (!ENUM.equals(entityConfig.getType())) {// 不对enum作用
				if (!exportEnabled) {// 开关没有打开
					// generateSingleFile(templatePath, targetPath, path, pathPrefix, entityConfig);
					return true;
				} else if (entityConfig.isExport()) {
					// generateSingleFile(templatePath, targetPath, path, pathPrefix, entityConfig);
					return true;
				}
			}
		}
		return false;
	}

	public static void generateSingleFile(String templatePath, String targetPath, String path, String pathPrefix, List<EntityConfig> entityConfigList) throws Exception {
		Configuration cfg = new Configuration();
		
		File templateFile = new File(templatePath);
		cfg.setDirectoryForTemplateLoading(templateFile.getParentFile());
//		cfg.setTemplateLoader(new TemplateAbsolutePathLoader());
		cfg.setDefaultEncoding("UTF-8");
		URL url = ClassLoader.getSystemResource("share.ftl");
		if (url != null) {
			cfg.addAutoInclude(cfg.getTemplate(url.getPath()).getName());
		}

		Template template = cfg.getTemplate(templateFile.getName());

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("stringPropertyDefaultEmpty", stringPropertyDefaultEmpty);
		data.put("prePackage", trim(filePath2ClassPath(pathPrefix), CLASS_PATHS_SEPARATOR));// com.lecai.xxx
		data.put("subPackage", trim(filePath2ClassPath(path), CLASS_PATHS_SEPARATOR));// user.order

		String fileName;
		String templateBaseName = FilenameUtils.getBaseName(templatePath);
		if (entityConfigList.size() == 1) {
			data.put("entity", entityConfigList.get(0));

			fileName = entityConfigList.get(0).getName();
			// 允许以entity、enum开始的占位符，如entityController=UserInfoController、PhaseController
			if (templateBaseName.startsWith(ENTIRY) && templateBaseName.length() > ENTIRY.length()) {
				fileName += StringUtils.capFirst(templateBaseName.substring(ENTIRY.length()));
			} else if (templateBaseName.startsWith(ENUM) && templateBaseName.length() > ENUM.length()) {
				fileName += StringUtils.capFirst(templateBaseName.substring(ENUM.length()));
			}
		} else {
			data.put("entityList", entityConfigList);

			fileName = templateBaseName;
		}

		// 使用模版名中的扩展名
		if (org.apache.commons.lang.StringUtils.isBlank(FilenameUtils.getExtension(fileName))) {
			fileName += ".java"; // 默认.java扩展名
		}

		String toGenerateFileName = targetPath + File.separator + pathPrefix + path + File.separator + StringUtils.capFirst(fileName);
		File file1 = new File(toGenerateFileName);
		File parent = file1.getParentFile();

		if (!parent.exists()) {
			parent.mkdirs();
		}
		if (!file1.exists()) {
			file1.createNewFile();
		}

		FileOutputStream file = new FileOutputStream(file1);
		Writer out = new OutputStreamWriter(file, "UTF-8");
		template.process(data, out);
		out.flush();
	}

	private static String filePath2ClassPath(String filePath) {
		return filePath.replace('/', CLASS_PATHS_SEPARATOR).replace('\\', CLASS_PATHS_SEPARATOR);
	}

	private static String trim(String str, char character) {
		return StringUtils.trimLeadingCharacter(StringUtils.trimTrailingCharacter(str, character), character);
	}
}
