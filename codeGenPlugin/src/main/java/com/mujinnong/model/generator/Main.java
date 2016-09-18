package com.mujinnong.model.generator;

import java.io.File;

import com.mujinnong.model.generator.meta.ModelNode;
import com.mujinnong.model.generator.util.CodeGenerator;
import com.mujinnong.model.generator.util.ModelParser;

public class Main {

	// public static String targetBaseDir = "E:\\workspace_wireless\\model\\generated\\";

	public static String templatePathDir = new File("./../model_java/src/main/template").getAbsolutePath();
	public static String targetPath = new File("./../model_java/src/main/generated").getAbsolutePath();

	public static String targetPackagePrefix = "./com/lecai/core/model";

	public static void main(String args[]) throws Exception {
		ModelNode modelTree = ModelParser.parse(new File("./../model/src/main/java/com/lecai/core/model").getAbsolutePath());
		CodeGenerator.generate(modelTree, targetPackagePrefix, templatePathDir, targetPath, false, false);

//		// service
//		templatePathDir = new File("./../proxy_core/src/main/template/service").getAbsolutePath();
//		targetPath = new File("./../proxy_core/src/main/generated").getAbsolutePath();
//		targetPackagePrefix = "./com/lecai/proxy/service";
//		modelTree = ModelParser.parse(new File("./../model/src/main/java/com/lecai/core/model").getAbsolutePath());
//		CodeGenerator.generate(modelTree, targetPackagePrefix, templatePathDir, targetPath, false, false);
//
//		// controller
//		templatePathDir = new File("./../proxy_core/src/main/template/controller").getAbsolutePath();
//		targetPath = new File("./../proxy_core/src/main/generated").getAbsolutePath();
//		targetPackagePrefix = "./com/lecai/proxy/controller";
//		modelTree = ModelParser.parse(new File("./../model/src/main/java/com/lecai/core/model").getAbsolutePath());
//		CodeGenerator.generate(modelTree, targetPackagePrefix, templatePathDir, targetPath, false, false);
		
		System.out.println("generate completed!!!");
	}
}
