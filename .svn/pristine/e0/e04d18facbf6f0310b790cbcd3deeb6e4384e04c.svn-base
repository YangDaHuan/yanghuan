package com.solidextend.core;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

@Service
public class ApplicationContextHolder implements ApplicationContextAware {
	private static ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext appContext) throws BeansException {
		ApplicationContextHolder.applicationContext = appContext;
	}
	
	public static  ApplicationContext getApplicationContext(){
		return applicationContext;
	}

}
