package com.solidextend.sys.quartz.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronTrigger;
import org.quartz.JobDataMap;
import org.quartz.Trigger;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.lic.SolidBILicense;
import com.solidextend.core.util.DateUtil;
import com.solidextend.core.util.Identities;
import com.solidextend.core.util.SysConfigUtil;
import com.solidextend.sys.log.dao.SysJobLogMapper;
import com.solidextend.sys.log.vo.SysJobLog;
import com.solidextend.sys.quartz.controller.JobController;
import com.solidextend.sys.quartz.dao.JobGroupMapper;
import com.solidextend.sys.quartz.dao.JobMapper;
import com.solidextend.sys.quartz.dao.JobParamMapper;
import com.solidextend.sys.quartz.dao.JobTypeMapper;
import com.solidextend.sys.quartz.dao.JobTypeParamMapper;
import com.solidextend.sys.quartz.vo.Job;
import com.solidextend.sys.quartz.vo.JobGroup;
import com.solidextend.sys.quartz.vo.JobParam;
import com.solidextend.sys.quartz.vo.JobType;
import com.solidextend.sys.quartz.vo.JobTypeParam;
@Service("jobService")
public class JobServiceImpl implements JobService {
	private static final Log log = LogFactory.getLog(JobServiceImpl.class);
	@Resource
	private JobGroupMapper jobGroupMapper;
	@Resource
	private JobMapper jobMapper;
	@Resource
	private JobTypeMapper jobTypeMapper;
	
	@Resource
	private JobTypeParamMapper jobTypeParamMapper;
	@Resource
	private JobParamMapper jobParamMapper;
	
	
	@Override
	public int insertJobType(JobType jobType) {
		// TODO Auto-generated method stub
		String id = Identities.uuid();
		jobType.setJobTypeId(id);
		return jobTypeMapper.insertJobType(jobType);
	}

	@Override
	public int deleteJobType(String jobTypeId) {
		// TODO Auto-generated method stub
		jobTypeParamMapper.deleteJobTypeParamByTypeId(jobTypeId);
		return jobTypeMapper.deleteJobType(jobTypeId);
	}

	@Override
	public int updateJobType(JobType jobType) {
		// TODO Auto-generated method stub
		return jobTypeMapper.updateJobType(jobType);
	}

	@Override
	public int insertJobTypeParam(JobTypeParam param) {
		// TODO Auto-generated method stub
		String id = Identities.uuid();
		param.setParamId(id);
		return jobTypeParamMapper.insertJobTypeParam(param);
	}

	@Override
	public int deleteJobTypeParam(String jobTypeParamId) {
		// TODO Auto-generated method stub
		return jobTypeParamMapper.deleteJobTypeParam(jobTypeParamId);
	}

	@Override
	public int deleteJobTypeParamByTypeId(String jobTypeId) {
		// TODO Auto-generated method stub
		return jobTypeParamMapper.deleteJobTypeParamByTypeId(jobTypeId);
	}

	@Override
	public int updateJobTypeParam(JobTypeParam jobTypeParam) {
		// TODO Auto-generated method stub
		return jobTypeParamMapper.updateJobTypeParam(jobTypeParam);
	}

	

	@Override
	public List<JobType> selectJobTypeList(Integer state) {
		// TODO Auto-generated method stub
		List<JobType> list=jobTypeMapper.getJobTypeList(state);
		return list;
	}

	@Override
	public List<JobTypeParam> selectJobTypeParamList(Integer state, String jobTypeId) {
		// TODO Auto-generated method stub
		List<JobTypeParam> list = jobTypeParamMapper.getJobTypeParamList(state, jobTypeId);
		return list;
	}

	@Override
	public int saveJobGroup(JobGroup jobGroup) {
		// TODO Auto-generated method stub
		if(StringUtils.isEmpty(jobGroup.getJobGroupId())){
	    	String id = Identities.uuid();
	    	jobGroup.setJobGroupId(id);
    	}
    	if(StringUtils.isBlank(jobGroup.getParentId())){
    		jobGroup.setParentId("0");
    	}
    	return this.jobGroupMapper.saveJobGroup(jobGroup);
		
	}

	@Override
	public int deleteJobGroup(String jobGroupId) {
		// TODO Auto-generated method stub
		List<JobGroup> list=this.jobGroupMapper.getJobGroupByPId(jobGroupId);
		List<Job> list1=this.jobMapper.findJobByGroupId(null, jobGroupId);
		if(list.size()>0 || list1.size()>0){
		return 0;
		}else{
			return this.jobGroupMapper.deleteJobGroup(jobGroupId);
		}
	}

	@Override
	public int updateJobGroup(JobGroup jobGroup) {
		// TODO Auto-generated method stub
		int i=jobGroupMapper.updateJobGroup(jobGroup);
		return i;
	}

	@Override
	public List<JobGroup> selectJobGroupList(Integer state) {
		// TODO Auto-generated method stub
		List<JobGroup> list =jobGroupMapper.findAllJobGroup(state);
		return list;
	}

	@Override
	public int saveJob(Job job) {
		// TODO Auto-generated method stub
		
		try {
			CronTrigger trigger = new CronTrigger();
			trigger.setCronExpression(job.getCronexp());
			Date nextFireTime = trigger.getNextFireTime();
			job.setNextFireTime(nextFireTime);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(StringUtils.isEmpty(job.getJobId())){
	    	String id = Identities.uuid();
	    	job.setJobId(id);
    	}
    	if(StringUtils.isBlank(job.getJobGroupId())){
    		job.setJobGroupId("0");
    	}
    	if(job.getState()==1){
    		try {
	    		JobType jt=this.jobTypeMapper.getJobTypeById(job.getJobTypeId());
				Class jobClass = Class.forName(jt.getJobClass());
				JobDataMap jobDataMap=getJobDataMap(job);
				QuartzService.addJob(job.getJobId(), job.getJobGroupId(), jobClass, job.getCronexp(),jobDataMap);
    		} catch (ClassNotFoundException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    			return 0;
    		}
    	}
	
    	saveJobParams(job);
    	return this.jobMapper.saveJob(job);
	
    	
    	
	}

	private void saveJobParams(Job job){
		List<JobParam> list=job.getParams();
		if(list!=null){
			this.jobParamMapper.deleteJobParam(job.getJobId());
			for(JobParam p : list){
				String id = Identities.uuid();
				p.setParamId(id);
	    		p.setJobId(job.getJobId());
	    		this.jobParamMapper.saveJobParam(p);
	    	}
		}
	}
	@Override
	public int deleteJob(String jobId) {
		// TODO Auto-generated method stub
		String[] ids = jobId.split(",");
    	for(String id : ids){
    		Job job = this.selectJobById(id);

			QuartzService.removeJob(job.getJobId(), job.getJobGroupId());
    		this.jobParamMapper.deleteJobParam(id);
    		jobMapper.deleteJob(id);
    		
    	}
		return 1;
	}

	@Override
	public int updateJob(Job job) {
		// TODO Auto-generated method stub
		
		try {
			if(job.getState()!=null){
				if(1==job.getState()){
					JobDataMap jobDataMap=getJobDataMap(job);
					JobType jt=this.jobTypeMapper.getJobTypeById(job.getJobTypeId());
					Class jobClass;
					jobClass = Class.forName(jt.getJobClass());
					QuartzService.removeJob(job.getJobId(),job.getJobGroupId());
					QuartzService.addJob(job.getJobId(), job.getJobGroupId(), jobClass, job.getCronexp(),jobDataMap);
			    	
				}else{
					QuartzService.removeJob(job.getJobId(),job.getJobGroupId());
				}
			}
	    	saveJobParams(job);
			return jobMapper.updateJob(job);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public List<Job> selectJobListByGroupId(Integer state, String jobGroupId) {
		// TODO Auto-generated method stub
		List<Job> list = jobMapper.findJobByGroupId(state, jobGroupId);
		return list;
	}

	@Override
	public Job selectJobById( String jobId) {
		// TODO Auto-generated method stub
		return jobMapper.getJobById(jobId);
	}

	@Override
	public JobGroup selectJobGroupById(String jobGroupId) {
		// TODO Auto-generated method stub
		JobGroup jg = jobGroupMapper.getJobGroupById(jobGroupId);
		return jg;
	}

	@Override
	public List<Job> selectJobListByTypeId(Integer state,String jobTypeId) {
		// TODO Auto-generated method stub
		return this.jobMapper.findAllJobByTypeId(state,jobTypeId);
		
	}

    @PostConstruct
	public void initAndStartJobs(){
		try {
			initJobList();
			//startJobs();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			log.error(e);
		}
		
	}

	@Override
	public void initJobList() throws ClassNotFoundException {
		
		// TODO Auto-generated method stub
			List<JobType> jobTypes=this.selectJobTypeList(null);
		for(JobType jt : jobTypes){
			String jobTypeId=jt.getJobTypeId();
			
				Class jobClass=Class.forName(jt.getJobClass());
			
			List<Job> jobs=this.selectJobListByTypeId(1,jobTypeId);
			for(Job job:jobs){
				JobDataMap jobDataMap=getJobDataMap(job);
				QuartzService.removeJob(job.getJobId(), job.getJobGroupId());
				QuartzService.addJob(job.getJobId(), job.getJobGroupId(), jobClass, job.getCronexp(),jobDataMap);
				log.info("已经从数据库将任务恢复到Quartz中");
			}
			
		}
		
	}
	private JobDataMap getJobDataMap(Job job){
		JobDataMap jobDataMap=new JobDataMap();
		List<JobParam> jobParams=job.getParams();
		jobDataMap.put("jobId", job.getJobId());
		jobDataMap.put("jobName", job.getJobName());
		jobDataMap.put("jobGroupId", job.getJobGroupId());
		jobDataMap.put("jobTimeout", job.getTimeout());
		jobDataMap.put("jobRetryCount", job.getRetryCount());
		for(JobParam jobP:jobParams){
			jobDataMap.put(jobP.getParamName(), jobP.getParamValue());
		}
		return jobDataMap;
	}
	

	@Override
	public void startJobs() {
		// TODO Auto-generated method stub
		SysConfigUtil lic=SysConfigUtil.getInstance();
		if(!lic.checkRegModule("2")){
			log.error("没有发现调度器的合法授权");
			return;
		}
		QuartzService.startJobs();
		log.info("Quartz已经启动》》》》》》》》");
	}

	@Override
	public void shutdownJobs() {
		// TODO Auto-generated method stub
		QuartzService.shutdownJobs();
		log.info("Quartz已经停止！！！！！！！！！！！！");
	}

	@Override
	public int updateNextFireTime(String jobId,Date nextFireTime) {
		// TODO Auto-generated method stub
		if(nextFireTime==null)return 0;
		return this.jobMapper.updateNextFireTime(jobId,nextFireTime);
		
	}

	@Override
	public List<Job> selectJobList(Integer state) {
		// TODO Auto-generated method stub
		return this.jobMapper.findAllJob(state);
	}

	@Override
	public void triggerJob(String jobName, String jobGroupName) {
		// TODO Auto-generated method stub
		QuartzService.triggerJob(jobName, jobGroupName);
	}

	
	
	

}
