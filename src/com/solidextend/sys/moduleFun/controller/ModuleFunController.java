package com.solidextend.sys.moduleFun.controller;

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
import com.solidextend.sys.authorize.service.AuthorizeService;
import com.solidextend.sys.dict.vo.Dict;
import com.solidextend.sys.dict.vo.DictItem;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.moduleFun.service.ModuleFunService;
import com.solidextend.sys.moduleFun.vo.ModuleFun;
import com.solidextend.sys.moduleFun.vo.ModuleFunGroup;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;


/**
 * @author changxiaoxue
 * @version 2015-1-20 上午10:29:00
 */
@Controller
@RequestMapping("/moduleFun")
public class ModuleFunController {
	private static final Log log = LogFactory.getLog(ModuleFunController.class);
	@Resource
	private ModuleFunService moduleFunService;
	@Resource
	private AuthorizeService authorizeService;

	/**
	 * 模块管理主页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "moduleFun/moduleFunIndex";
	}

	

	/**
	 * 得到所有的模块功能组信息
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleFunGroupList")
	@ResponseBody
	public List<ModuleFunGroup> getModuleFunGroupList() {
		List<ModuleFunGroup> moduleFunGroupList = this.moduleFunService.getModuleFunGroupList();
		return moduleFunGroupList;
	}
	
	/**
	 * 得到所有的模块类型的code和name，不要禁用和公共的
	 * 
	 * @return
	 */
	@RequestMapping("/getModuleFunGroupOptions")
	@ResponseBody
	public List<ModuleFunGroup> selectModuleFunGroupOptions(){
		List<ModuleFunGroup> moduleFunGroupList = this.moduleFunService.selectModuleFunGroupOptions();
		return moduleFunGroupList;
	}
	
	
	/**
	 * 检查指定code的模块功能组是否存在，忽略指定id
	 * 
	 * @return
	 */
	@RequestMapping("/checkFunGroupCode")
	@ResponseBody
	public boolean checkFunGroupCode(String id,String code) {
		boolean bool = false;
		if(this.moduleFunService.selectModuleFunGroupByCode(id, code).size()>0){
			bool = false;
		}else{
			bool = true;
		}
		return bool;
		
	}
	
	/**
	 * 检查指定name的模块功能组是否存在，忽略指定id
	 * 
	 * @return
	 */
	@RequestMapping("/checkFunGroupName")
	@ResponseBody
	public boolean checkFunGroupName(String id,String name) {
		boolean bool = false;
		if(this.moduleFunService.selectModuleFunGroupByName(id, name).size()>0){
			bool = false;
		}else{
			bool = true;
		}
		return bool;
		
	}
	
	/**
	 * 保存模块功能组
	 * 
	 * @return
	 */
	@RequestMapping("/saveFunGroup")
	@ResponseBody
	public JsonData saveFunGroup(ModuleFunGroup funGroup){
		JsonData jsonData = new JsonData();
		
		try {
			if(StringUtils.isBlank(funGroup.getId())){
				this.moduleFunService.saveFunGroup(funGroup);
				jsonData.setSuccess(true);
			}else{
				this.moduleFunService.updateModuleFunGroup(funGroup);
				jsonData.setSuccess(true);
			}
			jsonData.setExtData(funGroup);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	
	
	
	
	/**
	 * 根据组编号得到所有的模块功能参数
	 * @return
	 */
	@RequestMapping("/getModuleFunListByGroupCode")
	@ResponseBody
	public List<ModuleFun> getModuleFunListByGroupCode(String funGroupCode) {
		List<ModuleFun> moduleFunList = this.moduleFunService.getModuleFunListByGroupCode(funGroupCode);
		return moduleFunList;
	}
	
	
	
	/**
	 * 检查指定code的模块功能组是否存在，忽略指定id
	 * 
	 * @return
	 */
	@RequestMapping("/checkFunCode")
	@ResponseBody
	public boolean checkFunCode(String id,String code) {
		boolean bool = false;
		if(this.moduleFunService.selectModuleFunByCode(id, code).size()>0){
			bool = false;
		}else{
			bool = true;
		}
		return bool;
		
	}
	
	/**
	 * 检查指定name的模块功能组是否存在，忽略指定id
	 * 
	 * @return
	 */
	@RequestMapping("/checkFunName")
	@ResponseBody
	public boolean checkFunName(String id,String name) {
		boolean bool = false;
		if(this.moduleFunService.selectModuleFunByName(id, name).size()>0){
			bool = false;
		}else{
			bool = true;
		}
		return bool;
		
	}
	
	/**
	 * 保存模块功能组
	 * 
	 * @return
	 */
	@RequestMapping("/saveModuleFun")
	@ResponseBody
	public JsonData saveModuleFun(ModuleFun fun){
		JsonData jsonData = new JsonData();
		
		try {
			if(StringUtils.isBlank(fun.getId())){
				this.moduleFunService.saveModuleFun(fun);
				jsonData.setSuccess(true);
			}else{
				this.moduleFunService.updateModuleFun(fun);
				jsonData.setSuccess(true);
			}
			jsonData.setExtData(fun);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	/**
	 * 排序模块功能组
	 * 
	 * @return
	 */
	@RequestMapping("/sortModuleFunGroup")
	@ResponseBody
	public JsonData sortModuleFunGroup(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				ModuleFunGroup fg = new ModuleFunGroup();
				fg.setId(idList[i]);
				fg.setOrderNo(i);
				this.moduleFunService.updateModuleFunGroup(fg);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	/**
	 * 排序模块功能
	 * 
	 * @return
	 */
	@RequestMapping("/sortModuleFun")
	@ResponseBody
	public JsonData sortModuleFun(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				ModuleFun fun = new ModuleFun();
				fun.setId(idList[i]);
				fun.setOrderNo(i);
				this.moduleFunService.updateModuleFun(fun);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	
	/**
	 * 删除功能根据功能编码
	 * 
	 * @return
	 */
	@RequestMapping("/deleteModuleFunByCode")
	@ResponseBody
	public JsonData deleteModuleFunByCode(String funCode){
		JsonData jsonData = new JsonData();
		
		try {
			this.moduleFunService.deleteModuleFunByCode(funCode);
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	/**
	 * 删除功能根据功能组编码
	 * 
	 * @return
	 */
	@RequestMapping("/deleteModuleFunGroupByCode")
	@ResponseBody
	public JsonData deleteModuleFunGroupByCode(String groupCode){
		JsonData jsonData = new JsonData();
		
		try {
			this.moduleFunService.deleteModuleFunGroupByCode(groupCode);
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
}
