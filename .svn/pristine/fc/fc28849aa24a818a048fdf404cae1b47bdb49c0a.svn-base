package com.solidextend.sys.security;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;  
import org.apache.shiro.session.SessionListenerAdapter;  
import org.slf4j.Logger;  
import org.slf4j.LoggerFactory;

import com.solidextend.core.util.DateUtil;
import com.solidextend.core.web.UserSessionStorage;
import com.solidextend.sys.log.service.LoginLogService;
import com.solidextend.sys.log.vo.LoginLog;  
  
  
public class ShiroSessionListener extends SessionListenerAdapter {  
	@Resource
	private LoginLogService loginLogService;
	
    Logger log=LoggerFactory.getLogger(ShiroSessionListener.class);  
     @Override    
        public void onStart(Session session) {//会话创建时触发    
            log.error("会话创建：" + session.getId());    
            
        }    
        @Override    
        public void onExpiration(Session session) {//会话过期时触发    
            log.error("会话过期：" + session.getId());   
            
        }    
        @Override    
        public void onStop(Session session) {//退出时触发    
            log.error("会话停止：" + session.getId());   
            
        }      
}  