package com.solidextend.sys.df.controller;

import java.io.File;
import java.io.IOException;

import freemarker.template.Configuration;

public class ConfigurationHelper {
	
	private static Configuration cfg = null;

	public static Configuration getConfiguration(String templateFileDir) {
		if (null == cfg) {			
			try {
				cfg = new Configuration();
				cfg.setDirectoryForTemplateLoading(new File(templateFileDir));				
				cfg.setDefaultEncoding("UTF-8");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return cfg;
	}
}
