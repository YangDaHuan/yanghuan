package com.solidextend.core.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.util.DateUtil;
import com.solidextend.sys.log.service.LoginLogService;
import com.solidextend.sys.log.vo.LoginLog;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.security.ShiroSessionListener;
import com.solidextend.sys.security.UserDetails;

/**
 * session超时监听
 * @author songjunjie
 * @version 2014-3-12 下午4:44:37
 */
public class SessionTimeoutListener implements HttpSessionListener {
	
	
    Logger log=LoggerFactory.getLogger(SessionTimeoutListener.class);  
	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		log.debug("会话创建了"+session.getId());
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		log.debug("会话超时了"+session.getId());
		String username = (String)session.getAttribute("_username_");
		if(username!=null){
			UserSessionStorage.remove(username);
		}
		String jsessionid = (String)session.getId();
		if(jsessionid!=null){
			try {
				LoginLog loginLog = new LoginLog();
				loginLog.setJsessionid(jsessionid);
				loginLog.setLogoutTime(DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
				ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
				LoginLogService loginLogService = appContext.getBean("loginLogService",LoginLogService.class);
				loginLogService.updateByJsessionid(loginLog);
			
			} catch (Exception e) {
				log.error("保存登录日志信息时出现错误",e);
			}		
		
		}
	}
}
