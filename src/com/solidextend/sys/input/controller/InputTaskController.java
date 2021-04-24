package com.solidextend.sys.input.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.bson.Document;
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
import com.solidextend.sys.input.service.InputTaskService;
import com.solidextend.sys.input.vo.SysInputTask;
import com.solidextend.sys.input.vo.SysInputTaskInstance;
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
@RequestMapping("/inputTask")
public class InputTaskController {
	private static final Log log = LogFactory.getLog(InputTaskController.class);

	@Resource
	private InputTaskService inputTaskService;
	@Resource
	private FormService formService;
	
	@RequestMapping("/inputTaskIndex")
	public String index(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "inputTask/inputTaskIndex";
	}
	@RequestMapping("/myInputTask")
	public String myInputTask(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String userId = userDetails.getId();
		request.setAttribute("userId", userId);
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "inputTask/myInputTask";
	}
	@RequestMapping("/myInput")
	public String myInput(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String userId = userDetails.getId();
		request.setAttribute("userId", userId);
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "inputTask/myInput";
	}
	@RequestMapping("/myAudit")
	public String myAudit(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String userId = userDetails.getId();
		request.setAttribute("userId", userId);
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "inputTask/myAudit";
	}
	@RequestMapping("/runInputTask")
	public String runInputTask(HttpServletRequest request,String taskId,String formId,String taskInstanceId,String inputType){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String userId = userDetails.getId();
		request.setAttribute("userId", userId);
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		request.setAttribute("taskId", taskId);
		request.setAttribute("inputType", inputType);
		request.setAttribute("taskInstanceId", taskInstanceId);
		request.setAttribute("formId", formId);
		return "inputTask/runInputTask";
	}
	
	@RequestMapping("/saveInputTask")
	@ResponseBody
	public JsonData saveInputTask(SysInputTask inputTask){
		JsonData jsonData = new JsonData();
		try {
			this.inputTaskService.saveInputTask(inputTask);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	@RequestMapping("/deleteInputTask")
	@ResponseBody
	public JsonData deleteInputTask(String taskId){
		JsonData jsonData = new JsonData();
		try {
			if(this.inputTaskService.deleteInputTask(taskId)==0){
				jsonData.setSuccess(false);
				jsonData.setMsg("没有数据被删除");
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
	
	
	@RequestMapping("/selectInputTask")
	@ResponseBody
	public List<SysInputTask> selectInputTask(SysInputTask inputTask){
		
		return this.inputTaskService.getInputTaskList(inputTask);
	}
	
	
	@RequestMapping("/sortInputTask")
	@ResponseBody
	public JsonData sortForm(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				SysInputTask inputTask = new SysInputTask();
				inputTask.setTaskId(idList[i]);
				inputTask.setSortno(i);
				this.inputTaskService.saveInputTask(inputTask);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	@RequestMapping("/saveInputTaskInstance")
	@ResponseBody
	public JsonData saveInputTaskInstance(SysInputTaskInstance inputTaskInstance,HttpServletRequest request,int inputType){
		JsonData jsonData = new JsonData();
		
		try {
			Document doc = new Document();
			if(inputType!=2){
				String formId=inputTaskInstance.getFormId();
				List<SysFormItem> formItems=this.formService.getFormItemList("1", formId);
				for(SysFormItem item : formItems){
					String paramName =item.getInputName();
					String paramValue = request.getParameter(paramName);
					if(paramValue!=null){
						String paramType=item.getDataType();
						if("number".equals(paramType)){
							double   value   =   Double.parseDouble(paramValue); 
							doc.append(paramName, value);
						}else
							if("date".equals(paramType)){
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
							    Date value = sdf.parse(paramValue);
							    doc.append(paramName, value);
							}else
								if("timestamp".equals(paramType)){
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
								    Date value = sdf.parse(paramValue);
								    doc.append(paramName, value);
								}else
								{
									doc.append(paramName, paramValue);
								}
									
						
					}else{
						doc.append(paramName, null);
					}
				}
			}
			this.inputTaskService.saveInputTaskInstance(inputTaskInstance,doc,inputType);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		
		return jsonData;
	}
	@RequestMapping("/selectInputTaskInstance")
	@ResponseBody
	public List<SysInputTaskInstance> selectInputTaskInstance(SysInputTaskInstance inputTaskInstance){
		
		return this.inputTaskService.getInputTaskInstanceList(inputTaskInstance);
	}
	@RequestMapping("/selectInputTaskInstanceData")
	@ResponseBody
	public Document selectInputTaskInstanceData(String taskId,String taskInstanceId){
		
		return this.inputTaskService.getInputTaskInstanceData(taskId,taskInstanceId);
	}
	
}
