package com.solidextend.core.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.shiro.subject.Subject;

import com.solidextend.sys.security.UserDetails;

/**
 * @author songjunjie
 * @version 2014-3-20 下午5:17:56
 */
public class UserOnlineListener implements HttpSessionBindingListener {

	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		Subject subject = (Subject)session.getAttribute("_subject_");
		UserDetails userDetails =  (UserDetails)subject.getPrincipal();
		String loginName = userDetails.getLoginName();
		ServletContext application = session.getServletContext();
		 // 把用户名放入在线列表
	    Map<String,Subject> onlineUserList = (Map) application.getAttribute("onlineUserList");
	    // 第一次使用前，需要初始化
	    if (onlineUserList == null) {
	        onlineUserList = new HashMap<String,Subject>();
	        application.setAttribute("onlineUserList", onlineUserList);
	    }else{
	    	Subject subjectTemp = onlineUserList.get(loginName);
	    	subjectTemp.logout();
	    	onlineUserList.remove(loginName);
	    }
	    onlineUserList.put(loginName,subject);
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub

	}

}
