package com.solidextend.core.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.context.ApplicationContext;

import com.alibaba.druid.util.DruidWebUtils;
import com.alibaba.druid.util.PatternMatcher;
import com.alibaba.druid.util.ServletPathMatcher;
import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.sys.log.controller.AuditLogController;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.quartz.service.JobService;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;

public class URLFilter implements Filter {
	private FilterConfig filterConfig; 
	private ModuleService moduleService;
	private Set excludesPattern;
	private String contextPath;
	protected PatternMatcher pathMatcher;
	private static final Log log = LogFactory.getLog(URLFilter.class);
	public URLFilter(){
		pathMatcher = new ServletPathMatcher();
	}
	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		String requestURI=((HttpServletRequest)request).getRequestURI().toString();
		if(isExclusion(requestURI))
        {
            chain.doFilter(request, response);
            return;
        }
		if(moduleService==null){
			ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
			moduleService = appContext.getBean("moduleService",ModuleService.class);
		}
		boolean haveUrl=false;
		boolean legitimate=true;
		if(requestURI.length()>contextPath.length()){
			requestURI=requestURI.substring(contextPath.length()+1);
		}else{
			requestURI="";
		}
		int index=requestURI.indexOf("?");
		if(index>0){
			requestURI=requestURI.substring(0,index-1);
		}
		
		log.debug(" requestURI is :"+requestURI);
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
				.getPrincipal();
		if(userDetails==null||requestURI.equals("home.zb")){
			chain.doFilter(request, response);
			return;
		}
		List<Role> roles = userDetails.getRoles();
		List<Module> moduleList = new ArrayList<Module>();
		List<String> roleId=new ArrayList<String>();
		for (Role role : roles) {//查找角色中是否有超级管理员
			//如果是超级管理员的话，就显示全部模块
			if(role.getId().equals("1")){
				chain.doFilter(request, response);
				return;
			}else{
				roleId.add(role.getId());
			}
		}
		moduleList = this.moduleService.getModuleInfoListByRole(null,roleId);
		for(Module module:moduleList){
			String mUrl=module.getUrl();
			if(mUrl==null||mUrl.length()==0)continue;
			int endIndex=mUrl.indexOf("?");
			String paramUrl = null;
			if(endIndex>0){
				paramUrl=mUrl.substring(endIndex+1);
				mUrl=mUrl.substring(0, endIndex);
			}
			if(mUrl.equals(requestURI)){
				haveUrl=true;
				legitimate=true;
				List<Map> funs=module.getFuns();
				Map pMap=getParamsByFuns(funs);
				if(endIndex>0){
					Map tempMap=this.getParamsByUrl(paramUrl);
					pMap.putAll(tempMap);
					
				}
				Iterator it = pMap.entrySet().iterator();
				while(it.hasNext()){

					Map.Entry entry = (Map.Entry) it.next();
				    String key = entry.getKey().toString();
				    String value = entry.getValue().toString();
				    String paramValue=request.getParameter(key);
				    if(!value.equals(paramValue)){
				    	log.error("++++++++++++++++request error+++++url:"+requestURI+",pName:"+key+",pValue:"+value+",requestValue:"+paramValue);
				    	legitimate=false;
				    	
				    	break;
				    }
				    
				}
			}
			if(haveUrl&&legitimate){
				chain.doFilter(request, response);
				return;
			}
			
		}
		
		
		if(!haveUrl||legitimate){
			chain.doFilter(request, response);
		}
		else{
			((HttpServletResponse) response).sendRedirect(contextPath+"/home.zb");
		}
		
	}
	private Map getParamsByUrl(String url){
		Map<String,String> pMap=new HashMap<String,String>();
		String[] temp=url.split("&");
		for(String subUrl:temp){
			String[] sub=subUrl.split("=");
			if(sub.length==2)
			pMap.put(sub[0], sub[1]);
		}
		return pMap;
	}
	private Map getParamsByFuns(List<Map> funs){
		Map<String,String> pMap=new HashMap<String,String>();
		for(Map fun:funs){
			if(fun.get("funCode")!=null&&fun.get("funValue")!=null){
				pMap.put(fun.get("funCode").toString(), fun.get("funValue").toString());
			}
			
		}
		return pMap;
	}
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.filterConfig = filterConfig;
		String exclusions = filterConfig.getInitParameter("exclusions");
        if(exclusions != null && exclusions.trim().length() != 0)
            excludesPattern = new HashSet(Arrays.asList(exclusions.split("\\s*,\\s*")));
        contextPath = DruidWebUtils.getContextPath(filterConfig.getServletContext());
	}
	public boolean isExclusion(String requestURI)
    {
        if(excludesPattern == null)
            return false;
        if(contextPath != null && requestURI.startsWith(contextPath))
        {
            requestURI = requestURI.substring(contextPath.length());
            if(!requestURI.startsWith("/"))
                requestURI = (new StringBuilder()).append("/").append(requestURI).toString();
        }
        for(Iterator i$ = excludesPattern.iterator(); i$.hasNext();)
        {
            String pattern = (String)i$.next();
            if(pathMatcher.matches(pattern, requestURI))
                return true;
        }

        return false;
    }
}
