package com.solidextend.sys.module.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;

/**
 * @author songjunjie
 * @version 2014-1-6 上午10:29:00
 */
@Controller
@RequestMapping("/module")
public class ModuleController {
	private static final Log log = LogFactory.getLog(ModuleController.class);
	@Resource
	private ModuleService moduleService;

	/**
	 * 模块管理主页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "module/moduleIndex";
	}

	/**
	 * 根据父模块id查询出子级模块。
	 * 
	 * @param request
	 * @param pid
	 *            如果没有指定此参数返回所有的顶级模块
	 * @return
	 */
	@RequestMapping("/getModuleByPid")
	@ResponseBody
	public List<Module> getModuleByPid(HttpServletRequest request, String pid) {
		List<Module> list = this.moduleService.getModuleByPid(pid);
		return list;
	}

	/**
	 * 得到当前用户拥有的所有模块信息
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleListByUser")
	@ResponseBody
	public List<Module> getModuleListByUser() {
		// 得到当前用户信息
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
				.getPrincipal();
		List<Role> roles = userDetails.getRoles();
		List<Module> moduleList = new ArrayList<Module>();
		List<String> roleId=new ArrayList<String>();
		for (Role role : roles) {//查找角色中是否有超级管理员
			//如果是超级管理员的话，就显示全部模块
			if(role.getId().equals("1")){
				moduleList = this.moduleService.getModuleList();
				return moduleList;
			}else{
				roleId.add(role.getId());
			}
		}
		
		moduleList = this.moduleService.getNormalModuleListByRole(roleId);
		
		return moduleList;
	}
	
	/**
	 * 得到当前用户拥有的所有模块信息
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleInfoList")
	@ResponseBody
	public List<Module> getModuleInfoList(String onlyFolder) {
		// 得到当前用户信息
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
				.getPrincipal();
		List<Role> roles = userDetails.getRoles();
		List<Module> moduleList = new ArrayList<Module>();
		List<String> roleId=new ArrayList<String>();
		for (Role role : roles) {//查找角色中是否有超级管理员
			//如果是超级管理员的话，就显示全部模块
			if(role.getId().equals("1")){
				moduleList = this.moduleService.getModuleInfoList(onlyFolder);
				return moduleList;
			}else{
				roleId.add(role.getId());
			}
		}
		
		moduleList = this.moduleService.getModuleInfoListByRole(onlyFolder,roleId);
		
		return moduleList;
	}
	

	/**
	 * 得到当前角色可使用的模块
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleListForRole")
	@ResponseBody
	public JsonData getModuleListForRole(String roleId) {
		JsonData jsonData = new JsonData();
		List<Module> list = null;
		try {
			list = this.moduleService.getModuleListForRole(roleId);
			jsonData.setSuccess(true);
			jsonData.setRows(list);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}

	/**
	 * 得到当前角色可分配的所有模块 角色分配时，可分配的模块即使模块不可用，也可分配
	 * 
	 * @return
	 */
	@RequestMapping("/getAssignModuleList")
	@ResponseBody
	public JsonData getAssignModuleList(String roleId) {
		JsonData jsonData = new JsonData();
		List<Module> list = null;
		try {
			list = this.moduleService.getAssignModule(roleId);
			jsonData.setSuccess(true);
			jsonData.setExtData(list);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}

	/**
	 * 得到当前角色可使用的所有模块 角色分配时，可使用的模块即使模块不可用，也可分配
	 * 
	 * @return
	 */
	@RequestMapping("/getUseModuleList")
	@ResponseBody
	public JsonData getUseModuleList(String roleId) {
		JsonData jsonData = new JsonData();
		List<Module> list = null;
		try {
			list = this.moduleService.getUseModule(roleId);
			jsonData.setSuccess(true);
			jsonData.setExtData(list);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}

	/**
	 * 得到模块信息
	 * 
	 * @return
	 */
	@RequestMapping("/saveModule")
	@ResponseBody
	public JsonData saveModule(Module module) {
		JsonData jsonData = new JsonData();
		try {
			// ID不为空，说明是修改
			if (StringUtils.isNotBlank(module.getId())) {
				this.moduleService.updateModuleById(module);
			} else {
				this.moduleService.saveModule(module);
			}
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}

	/**
	 * 删除模块信息
	 * 
	 * @param id
	 *            模块ID
	 * @return
	 */
	@RequestMapping("/deleteModule")
	@ResponseBody
	public JsonData deleteModule(String id) {
		JsonData jsonData = new JsonData();
		try {
			this.moduleService.deleteModuleById(id);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("删除数据时出现内部错误");
		}
		return jsonData;
	}

	/**
	 * 得到模块信息
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleById")
	@ResponseBody
	public JsonData getModuleById(String id) {
		JsonData jsonData = new JsonData();
		try {
			Module module = this.moduleService.getModuleById(id);
			jsonData.setSuccess(true);
			jsonData.setExtData(module);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	/**
	 * 得到模块信息
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleByIdAndRole")
	@ResponseBody
	public JsonData getModuleByIdAndRole(String id) {
		JsonData jsonData = new JsonData();
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
				.getPrincipal();
		List<Role> roles = userDetails.getRoles();
		Module module;
		List<String> roleId=new ArrayList<String>();
		for (Role role : roles) {//查找角色中是否有超级管理员
			//如果是超级管理员的话，就显示全部模块
			if(role.getId().equals("1")){
				module = this.moduleService.getModuleById(id);
				jsonData.setSuccess(true);
				jsonData.setExtData(module);
				return jsonData;
			}else{
				roleId.add(role.getId());
			}
		}
		try {
			module = this.moduleService.getModuleByIdAndRole(id,roleId);
			jsonData.setSuccess(true);
			jsonData.setExtData(module);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	/**
	 * 保存用户的快捷模块
	 * 
	 * @return
	 */
	@RequestMapping("/saveQuickModule")
	@ResponseBody
	public JsonData saveQuickModule(String id) {
		JsonData jsonData = new JsonData();
		try {
			this.moduleService.saveQuickModule(id);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 校验模块名称是否存在
	 * @param name
	 * @param id
	 * @return
	 */
	@RequestMapping("/checkName")
	@ResponseBody
	public boolean checkModuleName(@RequestParam(required=false) String name, @RequestParam(required=false) String id){
		boolean bool = false;
		if(StringUtils.isEmpty(id)){
			if(moduleService.selectModuleByName(name).size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}else{
			if(moduleService.findNameDuplicate(name, id).size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}
		return bool;
	}
	
	
	/**
	 * 校验模块编码是否存在
	 * @param name
	 * @param id
	 * @return
	 */
	@RequestMapping("/checkCode")
	@ResponseBody
	public boolean checkModuleCode(@RequestParam(required=false) String name, @RequestParam(required=false) String id){
		List<Module> list = this.moduleService.findCodeDuplicate(name, id);
		if(list.isEmpty()){
			return true;
		}else{
			return false;
		}
	}

	
	/**
	 * 模块移动并排序
	 * 
	 * @return
	 */
	@RequestMapping("/moveModule")
	@ResponseBody
	public JsonData moveModule(String id,String parentId) {
		JsonData jsonData = new JsonData();
		try {
			this.moduleService.moveModule(id,parentId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
}
