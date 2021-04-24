package com.solidextend.sys.quartz.job;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.sys.log.service.JobLogService;
import com.solidextend.sys.log.vo.SysJobLog;
import com.solidextend.sys.quartz.service.JobService; 

public class ClearJobLog implements Job {
	
	

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
		Integer retryCount= (Integer)context.get("retryCount");
		if(retryCount==null)retryCount=0;
		context.put("retryCount",retryCount+1);
		Date jobStartTime=new Date();
		JobDetail jobDetail = context.getJobDetail(); 
		String jobName = jobDetail.getName();//任务名称      
		Date nextFireTime=context.getNextFireTime();
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		JobService jobService = appContext.getBean("jobService",JobService.class);
		JobLogService jobLogService = appContext.getBean("jobLogService",JobLogService.class);
		jobService.updateNextFireTime(jobName,nextFireTime);
        List<com.solidextend.sys.quartz.vo.Job> jobs=jobService.selectJobList(null);
        // Log the time the job started       
		//log.info(jobName + " fired at " + new Date());//记录任务开始执行的时间       
        // The directory to scan is stored in the job map       
        JobDataMap dataMap = jobDetail.getJobDataMap();//任务所配置的数据映射表   
        String jobId=dataMap.getString("jobId");
        int jobTimeout = dataMap.getInt("jobTimeout");
        int jobRetryCount = dataMap.getInt("jobRetryCount");
        
        SysJobLog jobLog=new SysJobLog();
        jobLog.setJobId(jobId);
		String logInfo="";
		try {
			for(com.solidextend.sys.quartz.vo.Job job : jobs){
				String id=job.getJobId();
				logInfo=logInfo+"任务："+job.getJobName();
				int logDays=job.getLogDays();
				if(logDays<0)continue;
				Calendar   calendar   =   new   GregorianCalendar(); 
			     calendar.setTime(jobStartTime); 
			     calendar.add(calendar.DATE,0-logDays);//把日期往后增加一天.整数往后推,负数往前移动 
			     Date logDate=calendar.getTime();
			     int deleteRow=jobLogService.deleteLogByJobIdAndDate(id, logDate);
			     logInfo=logInfo+",删除日志："+deleteRow+"条;<br>";
			}
			jobLog.setFireState("成功");
			
	        //System.exit(i);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//log.error(e);
			logInfo +=e.getMessage();
			jobLog.setFireState("失败");
			
		} 
		jobLog.setLogInfo(logInfo);
		jobLog.setFireTime(new Date());
		jobLog.setTimeLength((int) ((new Date().getTime() -jobStartTime.getTime())/1000) );
		jobLog.setRetryCount(retryCount);
		jobLogService.saveJobLog(jobLog);
		
		//判断是否重试
		JobExecutionException j = new JobExecutionException();
		boolean refire=jobRetryCount<=retryCount&&"失败".equals(jobLog.getFireState());
		j.setRefireImmediately(refire);
		throw j;
		
	}
	
	
}
