package com.solidextend.sys.quartz.job;

import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.util.Date;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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

import org.apache.commons.lang3.StringUtils; 

public class RunTimeUtils implements Job {
	
	//private static final Log log = LogFactory.getLog(RunTimeUtils.class);
	 /**  
     *   
    * @Title: exec  
    * @Description: 简化执行命令行  
    * @param  command 命令行  
    * @param  envp 环境变量  
    * @param  dir  路径  
    * @return Process    返回类型  
    * @throws IOException    
     */  
    public Process exec(String command, String envp, String dir)  
            throws IOException {  
        String regex = "\\s+";  
        String args[] = null;  
        String envps[] = null;  
        if (!StringUtils.isEmpty(command)) {  
            args = command.split(regex);  
        }  
  
        if (!StringUtils.isEmpty(envp)) {  
            envps = envp.split(regex);  
        }  
  
        return Runtime.getRuntime().exec(args, envps, new File(dir));  
  
    }  

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
        jobService.updateNextFireTime(jobName,nextFireTime);
        // Log the time the job started       
		//log.info(jobName + " fired at " + new Date());//记录任务开始执行的时间       
        // The directory to scan is stored in the job map       
        JobDataMap dataMap = jobDetail.getJobDataMap();//任务所配置的数据映射表   
        String jobId=dataMap.getString("jobId");
        int jobTimeout = dataMap.getInt("jobTimeout");
        int jobRetryCount = dataMap.getInt("jobRetryCount");
        
        String command=dataMap.getString("command");
        String envp=dataMap.getString("envp");
        String dir=dataMap.getString("dir");
        Process process;
        SysJobLog jobLog=new SysJobLog();
        jobLog.setJobId(jobId);
		String logInfo="";
		try {
			process = this.exec(command,envp,dir);
			DataInputStream ls_in = new DataInputStream(process.getInputStream());
			String lsLine="";
			while ((lsLine = ls_in.readLine()) != null) {
				logInfo=logInfo+lsLine+"<br>";
			}
			int i = process.waitFor();  
			logInfo=logInfo +"<br>状态编号："+i;
			jobLog.setFireState("成功");
			
	        //System.exit(i);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//log.error(e);
			logInfo +=e.getMessage();
			jobLog.setFireState("失败");
			
		} 
		jobLog.setLogInfo(logInfo);
		jobLog.setFireTime(jobStartTime);
		jobLog.setTimeLength((int) ((new Date().getTime() -jobStartTime.getTime())/1000) );
		jobLog.setRetryCount(retryCount);
		JobLogService jobLogService = appContext.getBean("jobLogService",JobLogService.class);
		jobLogService.saveJobLog(jobLog);
		
		//判断是否重试
		JobExecutionException j = new JobExecutionException();
		boolean refire=jobRetryCount<=retryCount&&"失败".equals(jobLog.getFireState());
		j.setRefireImmediately(refire);
		throw j;
		
	}
	
	
}
