package com.solidextend.sys.quartz.controller;

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
@RequestMapping("/job")
public class JobController {
	private static final Log log = LogFactory.getLog(JobController.class);

	@Resource
	private JobService jobService;
	
	
	@RequestMapping("/jobIndex")
	public String index(){
		return "job/jobIndex";
	}
	@RequestMapping("/jobTypeIndex")
	public String indexType(){
		return "job/jobTypeIndex";
	}
	
	@RequestMapping("/saveJobGroup")
	@ResponseBody
	public JsonData addJobGroup(JobGroup jobGroup){
		JsonData jsonData = new JsonData();
		try {
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			jobGroup.setUserId(userDetails.getLoginName());
			Date today=new Date();
			jobGroup.setLastUpTime(today);
			
			// ID不为空，说明是修改
			if (StringUtils.isNotBlank(jobGroup.getJobGroupId())) {
				this.jobService.updateJobGroup(jobGroup);
			} else {
				jobGroup.setCreateTime(today);
				this.jobService.saveJobGroup(jobGroup);
			}
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	@RequestMapping("/deleteJobGroup")
	@ResponseBody
	public JsonData deleteJobGroup(String jobGroupId){
		JsonData jsonData = new JsonData();
		try {
			if(jobService.deleteJobGroup(jobGroupId)==0){
				jsonData.setSuccess(false);
				jsonData.setMsg("不能删除有子目录或任务的目录");
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
	
	
	@RequestMapping("/selectJobGroup")
	@ResponseBody
	public List<JobGroup> selectJobGroup(Integer state){
		
		return jobService.selectJobGroupList(state);
	}
	
	
	@RequestMapping("/selectJobByGroupId")
	@ResponseBody
	public List<Job> selectJobByGroupId(Integer state,String jobGroupId){
		
		return jobService.selectJobListByGroupId(state, jobGroupId);
	}
	
	@RequestMapping("/saveJob")
	@ResponseBody
	public JsonData addJob(Job job,HttpServletRequest req){
		JsonData jsonData = new JsonData();
		String jobTypeId=job.getJobTypeId();
		List<JobTypeParam> list1=this.jobService.selectJobTypeParamList(null, jobTypeId);
		List<JobParam> list2=new ArrayList<JobParam>();
		for(JobTypeParam jtp: list1){
			JobParam jp=new JobParam();
			String paramName=jtp.getParamName();
			String paramValue=req.getParameter(paramName);
			jp.setParamName(paramName);
			jp.setParamValue(paramValue);
			list2.add(jp);
		}
		job.setParams(list2);
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		job.setUserId(userDetails.getLoginName());
		Date today=new Date();
		job.setLastUpTime(today);
		try {
			
			// ID不为空，说明是修改
			if (StringUtils.isNotBlank(job.getJobId())) {
				this.jobService.updateJob(job);
				
			} else {
		    	job.setCreateTime(today);
				this.jobService.saveJob(job);
			}
			
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("/getJobById")
	@ResponseBody
	public JsonData getJobById(String jobId){
		JsonData jsonData = new JsonData();
		try {
			Job job = this.jobService.selectJobById(jobId);
			jsonData.setSuccess(true);
			jsonData.setExtData(job);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("/deleteJob")
	@ResponseBody
	public JsonData deleteJob(String jobId){
		JsonData jsonData = new JsonData();
		try {
			this.jobService.deleteJob(jobId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	
	@RequestMapping("/getJobGroupById")
	@ResponseBody
	public JsonData getJobGroupById(String jobGroupId){
		JsonData jsonData = new JsonData();
		try {
			JobGroup jobGroup = this.jobService.selectJobGroupById(jobGroupId);
			jsonData.setSuccess(true);
			jsonData.setExtData(jobGroup);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	
	@RequestMapping("/getJobTypeList")
	@ResponseBody
	public List<JobType> getJobTypeList(Integer state){
		
		return this.jobService.selectJobTypeList(state);
	}
	
	@RequestMapping("/saveJobType")
	@ResponseBody
	public JsonData saveJobType(JobType jobType){
		JsonData jsonData = new JsonData();
		try {
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			jobType.setUserId(userDetails.getLoginName());
			Date today=new Date();
			jobType.setLastUpTime(today);
			// ID不为空，说明是修改
			if (StringUtils.isNotBlank(jobType.getJobTypeId())) {
				this.jobService.updateJobType(jobType);
			} else {
				jobType.setCreateTime(today);
				this.jobService.insertJobType(jobType);
			}
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("/deleteJobTypeById")
	@ResponseBody
	public JsonData deleteJobTypeById(String jobTypeId){
		JsonData jsonData = new JsonData();
		try {
				List<Job> list=this.jobService.selectJobListByTypeId(null,jobTypeId);
				if(list.size()>0){
					jsonData.setSuccess(false);
					jsonData.setMsg("系统包含该任务类型的任务，不能删除该任务类型");
					return jsonData;
				}
				this.jobService.deleteJobType(jobTypeId);
				jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	
	@RequestMapping("/getJobTypeParamListByTypeId")
	@ResponseBody
	public List<JobTypeParam> getJobTypeParamListByTypeId(Integer state,String jobTypeId){
		
		return this.jobService.selectJobTypeParamList(state, jobTypeId);
	}
	
	@RequestMapping("/deleteJobTypeParamById")
	@ResponseBody
	public JsonData deleteJobTypeParamById(String paramId){
		JsonData jsonData = new JsonData();
		try {
				this.jobService.deleteJobTypeParam(paramId);
				jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("/saveJobTypeParam")
	@ResponseBody
	public JsonData saveJobTypeParam(JobTypeParam jobTypeParam){
		JsonData jsonData = new JsonData();
		try {
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			jobTypeParam.setUserId(userDetails.getLoginName());
			Date today=new Date();
			jobTypeParam.setLastUpTime(today);
			// ID不为空，说明是修改
			if (StringUtils.isNotBlank(jobTypeParam.getParamId())) {
				this.jobService.updateJobTypeParam(jobTypeParam);
			} else {
				jobTypeParam.setCreateTime(today);
				this.jobService.insertJobTypeParam(jobTypeParam);
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
	 * 排序模块功能
	 * 
	 * @return
	 */
	@RequestMapping("/sortJobTypes")
	@ResponseBody
	public JsonData sortJobTypes(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				JobType jt = new JobType();
				jt.setJobTypeId(idList[i]);
				jt.setSortNo(i);
				this.jobService.updateJobType(jt);
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
	@RequestMapping("/sortJobTypeParams")
	@ResponseBody
	public JsonData sortJobTypeParams(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				JobTypeParam param = new JobTypeParam();
				param.setParamId(idList[i]);
				param.setSortNo(i);
				this.jobService.updateJobTypeParam(param);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	/**
	 * 排序任务
	 * 
	 * @return
	 */
	@RequestMapping("/sortJobs")
	@ResponseBody
	public JsonData sortJobs(String id){
		JsonData jsonData = new JsonData();
		
		try {
			String[] idList=id.split(",");
			for(int i=0;i<idList.length;i++){
				Job job = new Job();
				job.setJobId(idList[i]);
				job.setSortNo(i);
				this.jobService.updateJob(job);
			}
			
			jsonData.setSuccess(true);
			
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	@RequestMapping("/triggerJob")
	@ResponseBody
	public JsonData triggerJob(String jobId,String jobGroupId){
		JsonData jsonData = new JsonData();
		try {
			this.jobService.triggerJob(jobId, jobGroupId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("任务执行失败");
		}
		return jsonData;
	}
	@RequestMapping("/startJobs")
	@ResponseBody
	public JsonData startJobs(){
		JsonData jsonData = new JsonData();
		SysConfigUtil lic=SysConfigUtil.getInstance();
		if(!lic.checkRegModule("2")){
			jsonData.setSuccess(false);
			jsonData.setMsg("调度器启动失败,未发现授权");
			return jsonData;
		}
		try {
			this.jobService.startJobs();
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("调度器启动失败");
		}
		return jsonData;
	}
	@RequestMapping("/stopJobs")
	@ResponseBody
	public JsonData stopJobs(){
		JsonData jsonData = new JsonData();
		try {
			this.jobService.shutdownJobs();
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("调度器启动失败");
		}
		return jsonData;
	}
	@RequestMapping("/initJobs")
	@ResponseBody
	public JsonData initJobs(){
		JsonData jsonData = new JsonData();
		try {
			this.jobService.initJobList();
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("调度器启动失败");
		}
		return jsonData;
	}
}
