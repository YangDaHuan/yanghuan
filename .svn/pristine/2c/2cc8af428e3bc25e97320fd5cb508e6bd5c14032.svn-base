package com.solidextend.sys.authorize.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.authorize.service.AuthorizeService;
import com.solidextend.sys.authorize.vo.Authorize;
import com.solidextend.sys.security.UserDetails;

/**
 * 授权管理
 * @author songjunjie
 * @version 2014-2-26 上午10:36:37
 */
@Controller
@RequestMapping("/authorize")
public class AuthorizeController {

	private static final Log log = LogFactory.getLog(AuthorizeController.class);
	
	@Resource
	private AuthorizeService authorizeService;
	
	
	@RequestMapping("/moduleAuthorize")
	public String moduleAuthorize(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "authorize/moduleAuthorize";
	}
	@RequestMapping("/roleAuthorize")
	public String roleAuthorize(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "authorize/roleAuthorize";
	}
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(Authorize authorize){
		JsonData jsonData = new JsonData();
		try {
			this.authorizeService.save(authorize);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	@RequestMapping("/saveModuleAuthorize")
	@ResponseBody
	public JsonData saveModuleAuthorize(Authorize authorize){
		JsonData jsonData = new JsonData();
		try {
			this.authorizeService.saveModuleAuthorize(authorize);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	
		
}
