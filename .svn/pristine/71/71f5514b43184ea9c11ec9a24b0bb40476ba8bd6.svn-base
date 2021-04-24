package com.solidextend.sys.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.util.DateUtil;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.role.service.RoleService;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.user.service.UserService;
import com.solidextend.sys.user.vo.PartTimeInfo;


/**
 * 平台主页相关Controller
 * 
 * @author 宋俊杰
 * 
 */
@Controller
public class HomeController {
	private static final Log log = LogFactory.getLog(HomeController.class);
	@Resource
	private ModuleService moduleService;
	@Resource
	private UserService userService;
	@Resource
	private RoleService roleService;
	

	/**
	 * 平台首页面
	 * 
	 * @param reqs
	 * @param resp
	 * @return
	 */
	@RequestMapping("home")
	public String home(HttpServletRequest reqs,HttpServletResponse response) {
		
		String theme=reqs.getParameter("theme");
		if(theme==null){
			theme=(String) reqs.getSession().getAttribute("_theme");
		}
//		if(theme!=null){
//			Cookie cookie = new Cookie("theme", theme);
//			cookie.setMaxAge(60 * 60 * 24 * 365 * 10);// 设置为30min
//            cookie.setPath("/");
//            response.addCookie(cookie);
//		}else{
//			Cookie[] cookies = reqs.getCookies();
//			for(Cookie cookie : cookies){
//                if(cookie.getName().equals("theme")){
//                    theme=cookie.getValue();
//                    break;
//                }
//            }
//		}
		// 得到当前用户信息
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		List<Role> roles = userDetails.getRoles();
		if(roles==null){
			roles = this.roleService.getRolesByUser(userDetails.getId());
			userDetails.setRoles(roles);
		}
		List<Module> moduleList = new ArrayList<Module>();
		boolean isSuperAdmin = false;
		for (Role role : roles) {//查找角色中是否有超级管理员
			//如果是超级管理员的话，就显示全部模块
			if(role.getId().equals("1")){
				moduleList = this.moduleService.getTopModule();
				isSuperAdmin = true;
			}
		}
		if(!isSuperAdmin){
			List<String> roleId=new ArrayList<String>();
			for(Role role : roles){
				roleId.add(role.getId());
				//查询出顶级模块
				
			}
			//兼职机构的角色
			List<PartTimeInfo> jsRoles= userService.getPartTimeRolesById(userDetails.getId());
			for(PartTimeInfo obj : jsRoles){
				roleId.add(obj.getUserId());
				
			}
			moduleList = this.moduleService.getTopModuleForRole(roleId);
			
		}
		String cureDate = DateUtil.getCurrentDate("yyyy年MM月dd日");
		reqs.setAttribute("userDetails", userDetails);
		reqs.setAttribute("moduleList", moduleList);
		reqs.setAttribute("cureDate", cureDate);
		String version=reqs.getParameter("version");
		if(version!=null&&"0".equals(version)){
			return "home0";
		}
		if("mobile".equals(theme)){
			return "homeMobile";
		}
		return "home";
	}
	
	/**
	 * 去除重复的模块
	 * @param list
	 */
	private void removeDuplicate(List<Module> list) {
		for (int i = 0; i < list.size() - 1; i++) {
			for (int j = list.size() - 1; j > i; j--) {
				if (list.get(j).getId().equals(list.get(i).getId())) {
					list.remove(j);
				}
			}
		}
	}
	
	@RequestMapping("subModule")
	public String subModule(HttpServletRequest reqs,String parentId){
		// 得到当前用户信息
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
				.getPrincipal();
		List<Role> roles = userDetails.getRoles();
		List<Module> moduleList = new ArrayList<Module>();
		boolean isSuperAdmin = false;
		for (Role role : roles) {//查找角色中是否有超级管理员
			//如果是超级管理员的话，就显示全部模块
			if(role.getId().equals("1")){
				moduleList = this.moduleService.getModuleByPid(parentId);
				isSuperAdmin = true;
			}
		}
		
		if(!isSuperAdmin){
			List<String> roleId=new ArrayList<String>();
			
			for(Role role : roles){
				roleId.add(role.getId());
				
			}
			//兼职机构的角色
			List<PartTimeInfo> jsRoles= userService.getPartTimeRolesById(userDetails.getId());
			for(PartTimeInfo obj : jsRoles){
				roleId.add(obj.getUserId());
				//查询出顶级模块
				
			}
			moduleList = this.moduleService.getSubModuleForRole(roleId,parentId);
			
		}
		
		reqs.setAttribute("moduleList", moduleList);
		return "subModule";
	}
	
	/**
	 * 工作台跳转
	 * @param reqs
	 * @return
	 */
	@RequestMapping("workBench")
	public String workBench(Map<String, String> map){
		map.put("num", "5");
		return "workbench";
	}
	
	/**
	 * 获取快捷模块
	 */
	@RequestMapping("getQuickModules")
	@ResponseBody
	public JsonData getQuickModules(){
		JsonData jsonData = new JsonData();
		try {
			// 得到当前用户信息
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			//用户自主设置的快捷方式
			List<Module> quickModuleList = this.moduleService.getQuickModulesByUserId(userDetails.getId());
			jsonData.setSuccess(true);
			jsonData.setExtData(quickModuleList);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
}
