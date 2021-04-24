package com.solidextend.sys.quartz.service;

import java.util.Date;
import java.util.List;

import com.solidextend.sys.log.vo.SysJobLog;
import com.solidextend.sys.quartz.vo.Job;
import com.solidextend.sys.quartz.vo.JobGroup;
import com.solidextend.sys.quartz.vo.JobParam;
import com.solidextend.sys.quartz.vo.JobType;
import com.solidextend.sys.quartz.vo.JobTypeParam;

public interface JobService {
/*
 * 任务服务
 */
	
	/*
	 * 添加任务类型
	 */
	public int insertJobType(JobType jobType);
	/*
	 * 删除任务类型
	 */
	public int deleteJobType(String jobTypeId);
	/*
	 * 更新任务类型
	 */
	public int updateJobType(JobType jobType);
	/*
	 * 查询任务类型
	 */
	public List<JobType> selectJobTypeList(Integer state);
	
	/*
	 * 添加任务类型参数
	 */
	public int insertJobTypeParam(JobTypeParam param);
	/*
	 * 删除任务类型参数
	 */
	public int deleteJobTypeParam(String jobTypeParamId);
	/*
	 * 删除任务类型参数
	 */
	public int deleteJobTypeParamByTypeId(String jobTypeId);
	/*
	 * 更新任务类型参数
	 */
	public int updateJobTypeParam(JobTypeParam jobTypeParam);
	/*
	 * 查询任务类型参数
	 */
	public List<JobTypeParam> selectJobTypeParamList(Integer state,String jobTypeId);

	/*
	 * 添加任务组
	 */
	public int saveJobGroup(JobGroup jobGroup);
	/*
	 * 删除任务组
	 */
	public int deleteJobGroup(String jobGroupId);
	/*
	 * 更新任务组
	 */
	public int updateJobGroup(JobGroup jobGroup);
	/*
	 * 查询任务组
	 */
	public List<JobGroup> selectJobGroupList(Integer state);
	/*
	 * 查询任务组
	 */
	public JobGroup selectJobGroupById(String jobGroupId);
	/*
	 * 添加任务
	 */
	public int saveJob(Job job);
	/*
	 * 删除任务
	 */
	public int deleteJob(String jobId);
	/*
	 * 更新任务
	 */
	public int updateJob(Job job);
	/*
	 * 更新任务下次执行时间
	 */
	public int updateNextFireTime(String jobId,Date nextFireTime);
	/*
	 * 查询任务
	 */
	public List<Job> selectJobListByGroupId(Integer state,String groupId);
	
	/*
	 * 根据id查询任务
	 */
	public Job selectJobById(String jobId);
	
	/*
	 * 查询任务
	 */
	public List<Job> selectJobListByTypeId(Integer state,String jobTypeId);
	
	/*
	 * 查询所有任务
	 */
	public List<Job> selectJobList(Integer state);
	
	/*
	 * 初始化所有任务
	 */
	public void initJobList() throws ClassNotFoundException;
	/*
	 * 执行指定任务
	 */
	public void triggerJob(String jobName, String jobGroupName);
	/*
	 * 初始化所有任务
	 */
	public void startJobs();
	
	/*
	 * 初始化所有任务
	 */
	public void shutdownJobs();
	

}
