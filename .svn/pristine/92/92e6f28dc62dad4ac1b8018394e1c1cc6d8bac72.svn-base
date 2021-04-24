package com.solidextend.core.web;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

public class KictoutFilter extends FormAuthenticationFilter {

	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) {
		System.out.println("--");
		boolean r = super.isAccessAllowed(request, response, mappedValue);
		HttpSession session = ((HttpServletRequest) request).getSession();
		Boolean isKickout = (Boolean) session.getAttribute("_kickout_");

		if (isKickout != null && isKickout) {
			session.invalidate();
			String loginUrl = this.getLoginUrl();
			if(!loginUrl.contains("kickout=1")){
				loginUrl += "?kickout=1";
			}
			this.setLoginUrl(loginUrl);
//			session.removeAttribute("_kickout_");
			return false;
		}
		return super.isAccessAllowed(request, response, mappedValue);
	}
	
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		
		return super.onAccessDenied(request, response);
	}


	// @Override
	// protected boolean isAccessAllowed(ServletRequest request,
	// ServletResponse arg1, Object response) throws Exception {
	// HttpSession session = ((HttpServletRequest)request).getSession();
	// Boolean isKickout = (Boolean)session.getAttribute("_kickout_");
	// if(isKickout!=null && isKickout){
	// session.invalidate();
	// ((HttpServletResponse)response).sendRedirect("login.zb?kickout=1");
	// }
	// String loginUrl = this.getLoginUrl();
	// this.setLoginUrl(loginUrl+"kickout=1");
	// return false;
	// }

}
