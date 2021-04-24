package com.solidextend.sys.quartz.job;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.*;   
import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.hsqldb.lib.StringUtil;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import javax.mail.*;   
import javax.mail.internet.*;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.util.FileUtils;
import com.solidextend.sys.log.service.JobLogService;
import com.solidextend.sys.log.vo.SysJobLog;
import com.solidextend.sys.quartz.service.JobService;   
  

public class ReciveMail implements Job  {   
	private static final Log log = LogFactory.getLog(ReciveMail.class);
	private String logInfo="";
	private String state="成功";;

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		Date jobStartTime=new Date();
		JobDetail jobDetail = context.getJobDetail(); 
		String jobName = jobDetail.getName();//任务名称      
		Date nextFireTime=context.getNextFireTime();
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		JobService jobService = appContext.getBean("jobService",JobService.class);
        jobService.updateNextFireTime(jobName,nextFireTime);
        // Log the time the job started       
		log.info(jobName + " fired at " + new Date());//记录任务开始执行的时间       
        // The directory to scan is stored in the job map       
        JobDataMap dataMap = jobDetail.getJobDataMap();//任务所配置的数据映射表  
        String jobId=dataMap.getString("jobId");
        int jobTimeout = dataMap.getInt("jobTimeout");
        int jobRetryCount = dataMap.getInt("jobRetryCount");
        
        String mailSmtpHost=dataMap.getString("mailSmtpHost");
        String mailPopHost=dataMap.getString("mailPopHost");
        int mailPopPort = dataMap.getInt("mailPopPort");
        String mailUser=dataMap.getString("mailUser");
        String mailPassword=dataMap.getString("mailPassword");
        String mailSubject=dataMap.getString("mailSubject");
        SysJobLog jobLog=new SysJobLog();
        jobLog.setJobId(jobId);
        
		try {
			// TODO Auto-generated method stub
			Date yesterday=new Date(new Date().getTime()-24*60*60*1000);
	    	SimpleDateFormat matter1 = new SimpleDateFormat("yyyy-M-d");
	    	String yesterdayStr1 = matter1.format(yesterday);
	    	System.out.println(yesterdayStr1);
	        SimpleDateFormat matter2 = new SimpleDateFormat("yyyy年M月d日");
	    	String yesterdayStr2 = matter2.format(yesterday);
	    	System.out.println(yesterdayStr2);
	    	if(yesterdayStr1==null||yesterdayStr2==null)return;
	    	//String subject="市地铁运营公司"+yesterdayStr2+"客流数据报表";
	    	String subject=mailSubject.replaceAll("yyyy-M-d", yesterdayStr1).replaceAll("yyyy年M月d日", yesterdayStr2);
	        Properties props = System.getProperties();  
	        props.put("mail.smtp.host",mailSmtpHost );  
	        //props.put("mail.smtp.host", "smtp.126.com");  
	        props.put("mail.smtp.auth", "true");  
	        Session session = Session.getDefaultInstance(props, null);  
	        //URLName urln = new URLName("pop3", "pop.126.com", 110, null, "afc_mlcsj@126.com", "mlcsj84666003");  
	        URLName urln = new URLName("pop3", mailPopHost, mailPopPort, null, mailUser,mailPassword);  
	        Store store = session.getStore(urln);  
	        
				store.connect();
				this.logInfo+="邮件服务器连接成功<br>";
	        Folder folder = store.getFolder("INBOX");  
	        folder.open(Folder.READ_ONLY);  
	        Message message[] = folder.getMessages();  
	        
	        ReciveOneMail pmm = null;  
	        
	        for (int i = 0; i < message.length; i++) {  
	            pmm = new ReciveOneMail((MimeMessage) message[i]);  
	            //System.out.println("邮件标题："+pmm.getSubject());
	            String[] subjects=subject.split(";");
	            if(Arrays.asList(subjects).contains(pmm.getSubject())){
	            	this.logInfo+="查找到符合条件的邮件<br>";
	            	String path=dataMap.getString("savePath");
	            	if(path!=null&&!StringUtil.isEmpty(path)){
	            		pmm.setAttachPath(path);
	            	}
	                String[] filenames=pmm.saveAttachMent(message[i]);
	                path=pmm.getAttachPath();
	                for(int j=0;j<filenames.length;j++){
	                	if(filenames[j].endsWith(".zip")){
	                		this.logInfo+="解压"+path+"/"+filenames[j]+" 到 "+path+"目录<br>";
	    	            	FileUtils.decompress(path+"/"+filenames[j],path);
	                		String filePath1=path+"/市地铁运营公司"+yesterdayStr1+"/换乘车站分时客流量统计表("+yesterdayStr1+")-北京地铁.xls";
	                		String filePath2=path+"/市地铁运营公司"+yesterdayStr1+"/线路分时断面客流量统计表("+yesterdayStr1+")-北京地铁.xls";
	                		// 建立连接
	    	    			Class.forName("com.esproc.jdbc.InternalDriver");
	
	    	    			Connection con = DriverManager.getConnection("jdbc:esproc:local://");
	    	    			
	    	    			// 调用存储过程，其中createTable1是dfx的文件名
	    	    			String call="call subway/transfor(?)";
	    	    			
	    	    			com.esproc.jdbc.InternalCStatement st = (com.esproc.jdbc.InternalCStatement) con.prepareCall(call);
	    	    			st.setObject(1, filePath1);
	    	    			// 执行存储过程
	
	    	    			st.execute();
	    	    			this.logInfo+="导入"+filePath1+"成功<br>";
	    	            	
	    	    			// 调用存储过程，其中createTable1是dfx的文件名
	    	    			call="call subway/section(?)";
	    	    			
	    	    			st = (com.esproc.jdbc.InternalCStatement) con.prepareCall(call);
	    	    			st.setObject(1, filePath2);
	    	    			// 执行存储过程
	
	    	    			st.execute();
	    	    			this.logInfo+="导入"+filePath2+"成功<br>";
	    	            	con.close();
	                	}
	                	
	                }
	                
	            }
	            
	               
	        }
        
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.state="失败";
			this.logInfo+=e.getMessage();
		}
		jobLog.setLogInfo(logInfo);
        jobLog.setFireState(state);
        jobLog.setFireTime(jobStartTime);
		jobLog.setTimeLength((int) ((new Date().getTime() -jobStartTime.getTime())/1000) );
		JobLogService jobLogService = appContext.getBean("jobLogService",JobLogService.class);
		jobLogService.saveJobLog(jobLog);
	}
	
}  