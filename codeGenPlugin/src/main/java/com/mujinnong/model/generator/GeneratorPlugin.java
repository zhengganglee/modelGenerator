package com.mujinnong.model.generator;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;

import com.mujinnong.model.generator.meta.ModelNode;
import com.mujinnong.model.generator.util.CodeGenerator;
import com.mujinnong.model.generator.util.ModelParser;

/**
 * @goal generator
 */
public class GeneratorPlugin extends AbstractMojo {

	/**
	 * 模版目录（生成java文件的格式）
	 * 
	 * @parameter
	 */
	private File templatePathDir;
	/**
	 * Model配置目录
	 * 
	 * @parameter
	 */
	private File modelPathDir;
	/**
	 * 生成的目标路径
	 * 
	 * @parameter
	 */
	private File targetPath;
	/**
	 * 包名前缀
	 * 
	 * @parameter default-value="com/lecai/model"
	 */
	private String targetPackagePrefix;

	/**
	 * 是否采用导出模式
	 * 
	 * @parameter default-value=false
	 */
	private boolean exportEnabled;

	/**
	 * 单个文件输出模式（所有model的配置将一次传给模版且只生存1个文件）
	 * 
	 * @parameter default-value=false
	 */
	private boolean singleOutput;

	/**
	 * model字符串属性默认为""
	 * 
	 * @parameter default-value=false
	 */
	private boolean stringPropertyDefaultEmpty;

	private static final Map<String, ModelNode> modelNodeCache = new HashMap<String, ModelNode>();

	public void execute() throws MojoExecutionException, MojoFailureException {
		getLog().info("开始生成Code...");
		if (templatePathDir == null || !templatePathDir.exists() || !templatePathDir.isDirectory()) {
			getLog().error("参数templatePathDir[" + templatePathDir + "] 不是一个有效的目录");
			return;
		} else if (modelPathDir == null || !modelPathDir.exists() || !modelPathDir.isDirectory()) {
			getLog().error("参数modelPathDir[" + modelPathDir + "] 不是一个有效的目录");
			return;
		} else if (targetPath == null || !targetPath.exists() || !targetPath.isDirectory()) {
			getLog().error("参数targetPath[" + targetPath + "] 不是一个有效的目录");
			return;
		}

		getLog().debug("参数templatePathDir:" + templatePathDir);
		getLog().debug("参数modelPathDir:" + modelPathDir);
		getLog().debug("参数targetPath:" + targetPath);
		getLog().debug("参数exportEnabled:" + exportEnabled);
		getLog().debug("参数singleOutput:" + singleOutput);
		getLog().debug("参数stringPropertyDefaultEmpty:" + stringPropertyDefaultEmpty);
		try {
			String key = modelPathDir.getAbsolutePath();
			ModelNode modelTree = modelNodeCache.get(key);
			if (modelTree == null) {
				modelTree = ModelParser.parse(modelPathDir.getAbsolutePath());
				modelNodeCache.put(key, modelTree);
			} else {
				getLog().info("******************************modelTree from cache******************************");
			}
			CodeGenerator.setStringPropertyDefaultEmpty(stringPropertyDefaultEmpty);
			CodeGenerator.generate(modelTree, targetPackagePrefix, templatePathDir.getAbsolutePath(), targetPath.getAbsolutePath(), exportEnabled, singleOutput);
			getLog().info("Code生成完毕！目标路径：" + targetPath);
		} catch (Exception e) {
			getLog().info("生成Code发生异常：", e);
		}
	}

	public File getTemplatePathDir() {
		return templatePathDir;
	}

	public void setTemplatePathDir(File templatePathDir) {
		this.templatePathDir = templatePathDir;
	}

	public File getModelPathDir() {
		return modelPathDir;
	}

	public void setModelPathDir(File modelPathDir) {
		this.modelPathDir = modelPathDir;
	}

	public File getTargetPath() {
		return targetPath;
	}

	public void setTargetPath(File targetPath) {
		this.targetPath = targetPath;
	}

	public String getTargetPackagePrefix() {
		return targetPackagePrefix;
	}

	public void setTargetPackagePrefix(String targetPackagePrefix) {
		this.targetPackagePrefix = targetPackagePrefix;
	}

	public boolean getExportEnabled() {
		return exportEnabled;
	}

	public void setExportEnabled(boolean exportEnabled) {
		this.exportEnabled = exportEnabled;
	}

	public boolean isSingleOutput() {
		return singleOutput;
	}

	public void setSingleOutput(boolean singleOutput) {
		this.singleOutput = singleOutput;
	}

	public boolean isStringPropertyDefaultEmpty() {
		return stringPropertyDefaultEmpty;
	}

	public void setStringPropertyDefaultEmpty(boolean stringPropertyDefaultEmpty) {
		this.stringPropertyDefaultEmpty = stringPropertyDefaultEmpty;
	}

}
