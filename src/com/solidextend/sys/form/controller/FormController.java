package com.solidextend.sys.form.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.lic.SolidBILicense;
import com.solidextend.core.util.SysConfigUtil;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.form.service.FormService;
import com.solidextend.sys.form.vo.SysForm;
import com.solidextend.sys.form.vo.SysFormItem;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.moduleFun.vo.ModuleFun;
import com.solidextend.sys.quartz.service.JobService;
import com.solidextend.sys.quartz.vo.Job;
import com.solidextend.sys.quartz.vo.JobGroup;
import com.solidextend.sys.quartz.vo.JobParam;
import com.solidextend.sys.quartz.vo.JobType;
import com.solidextend.sys.quartz.vo.JobTypeParam;
import com.solidextend.sys.role.controller.RoleController;
import com.solidextend.sys.role.service.RoleService;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.user.service.UserService;

@Controller
@RequestMapping("/form")
public class FormController {
	private static final Log log = LogFactory.getLog(FormController.class);

	@Resource
	private FormService formService;
	
	
	@RequestMapping("/formIndex")
	public String index(){
		return "form/formIndex";
	}
	
	
	@RequestMapping("/saveForm")
	@ResponseBody
	public JsonData saveForm(SysForm form){
		JsonData jsonData = new JsonData();
		try {
			this.formService.saveForm(form);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	@RequestMapping("/deleteForm")
	@ResponseBody
	public JsonData deleteForm(String formId){
		JsonData jsonData = new JsonData();
		try {
			if(this.formService.deleteForm(formId)==0){
				jsonData.setSuccess(false);
				jsonData.setMsg("不能删除再任务中正在使用的表单");
			}else{
				jsonData.setSuccess(true);
			}
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	
	@RequestMapping("/selectForm")
	@ResponseBody
	public List<SysForm> selectForm(SysForm form){
		
		return this.formService.getFormList(form);
	}
	
	
	@RequestMapping("/selectFormItemByFormId")
	@ResponseBody
	public List<SysFormItem> selectFormItemByFormId(String disable,String formId){
		
		return this.formService.getFormItemList(disable,formId);
	}
	
	@RequestMapping("/saveFormItem")
	@ResponseBody
	public JsonData saveFormItem(SysFormItem formItem){
		JsonData jsonData = new JsonData();
		
		
		try {
			this.formService.saveFormItem(formItem);
			
			
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	
	@RequestMapping("/deleteFormItem")
	@ResponseBody
	public JsonData deleteFormItem(String formItemId){
		JsonData jsonData = new JsonData();
		try {
			this.formService.deleteFormItem(formItemId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	
	
	/**
	 * 排序表单
	 * 
	 * @return
	 */
	@RequestMapping("/sortForm")
	@ResponseBody
	public JsonData sortForm(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				SysForm form = new SysForm();
				form.setFormId(idList[i]);
				form.setSortno(i);
				this.formService.saveForm(form);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	/**
	 * 排序表单项
	 * 
	 * @return
	 */
	@RequestMapping("/sortFormItem")
	@ResponseBody
	public JsonData sortFormItem(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				SysFormItem formItem = new SysFormItem();
				formItem.setInputId(idList[i]);
				formItem.setSortno(i);
				this.formService.saveFormItem(formItem);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
}
