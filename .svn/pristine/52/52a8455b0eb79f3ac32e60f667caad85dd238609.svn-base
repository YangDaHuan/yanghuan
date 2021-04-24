package com.solidextend.sys.quartz.job;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.raqsoft.report.model.ReportDefine;
import com.raqsoft.report.usermodel.Context;
import com.raqsoft.report.usermodel.Engine;
import com.raqsoft.report.usermodel.INormalCell;
import com.raqsoft.report.usermodel.IReport;
import com.raqsoft.report.usermodel.Param;
import com.raqsoft.report.usermodel.ParamMetaData;
import com.raqsoft.report.util.ReportUtils;
import com.raqsoft.report.view.ReportExporter;
import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.util.DateUtil;
import com.solidextend.sys.log.service.JobLogService;
import com.solidextend.sys.log.vo.SysJobLog;
import com.solidextend.sys.quartz.service.JobService;

public class SendEmail implements Job {

	private static final Log log = LogFactory.getLog(SendEmail.class);
	private String to;
	private String subject;
	private String body;
	private String reports;
	private String reportParams;
	
	private String fileType;
	private String savePath;
	private String sendEmail;
	
	private String logInfo="";
	private String state;

	public String getTo() {
		return to;
	}
 
	public void setTo(String to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getReports() {
		return reports;
	}

	public void setReports(String reports) {
		this.reports = reports;
	}
	public String getReportParams() {
		return reportParams;
	}

	public void setReportParams(String reportParams) {
		this.reportParams = reportParams;
	}
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	
	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getSendEmail() {
		return sendEmail;
	}

	public void setSendEmail(String sendEmail) {
		this.sendEmail = sendEmail;
	}

	public void sendEmail() {
		try {
			Context cxt = new Context();
			Map paramMap=this.getParamMap(this.reportParams);
			String reportFileHome = cxt.getMainDir();
			//String webRoot = this.getClass().getClassLoader().getResource("/").getPath();
			//webRoot = webRoot.substring(0, webRoot.length() - 16);
			//reportFileHome=webRoot+reportFileHome;  

			List<String> files = new ArrayList<String>();
			for (String report : reports.split(";")) {
				String[] reportPro=report.split(",");
				String reportName=reportPro[0];
				String fileName;
				if ((reportName.lastIndexOf(".rpx")) <= 0) {
					reportName = reportName + ".rpx";
				}
				if (reportName.startsWith("\\")||reportName.startsWith("/")) {
					reportName = reportFileHome + reportName;
				}
				
				//如果有配置名称就直接使用，否则取报表名称
				if(reportPro.length>1){
					fileName=reportPro[1];
				}else{
					int beginIndex = reportName.lastIndexOf("/");
					if(beginIndex < reportName.lastIndexOf("\\")){
						beginIndex = reportName.lastIndexOf("\\");
					}
					int endIndex=reportName.lastIndexOf(".");
					fileName=reportName.substring(beginIndex+1, endIndex);
				}
				cxt = new Context();
				cxt.setParamMap(paramMap);
				ReportDefine rd = (ReportDefine) ReportUtils.read(reportName);
				Engine engine = new Engine(rd, cxt);

				IReport iReport = engine.calc();
				String fileDir="";
				if(savePath==null){
					fileDir = System.getProperty("java.io.tmpdir");
				}else{
					if(savePath.startsWith("/")||savePath.startsWith("\\")){
						fileDir=reportFileHome+savePath;
					}else{
						fileDir=savePath;
					}
						
				}
				File file =new File(fileDir);  
				//如果文件夹不存在则创建  
				if  (!file .exists()  && !file .isDirectory())    
				{     
				    file .mkdir();  
				} 
				
				if ("PDF".equals(this.fileType)) {
					fileName=fileDir + "/" + fileName + ".pdf";
					ReportUtils.exportToPDF(fileName, iReport);
					
				}else
				if ("WORD".equals(this.fileType)) {
					fileName=fileDir + "/" + fileName + ".docx";
					ReportUtils.exportToDOCX(fileName, iReport);
				}else{
					fileName=fileDir + "/" + fileName + ".xls";
					ReportUtils.exportToExcel(fileName, iReport,false);
					
				}
				files.add(fileName);
				this.logInfo+="导出文件："+fileName+"<br>";
			}
			if("true".equals(sendEmail)){
				ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
				JavaMailSenderImpl sender = appContext.getBean("mailSender",JavaMailSenderImpl.class);
				MimeMessage msg = sender.createMimeMessage();
			    MimeMessageHelper helper = new MimeMessageHelper(msg, true);  
			    //夹带附件  
		        for(String fileName : files){
		        	FileSystemResource file = new FileSystemResource(new File(fileName));  
		        	helper.addAttachment(MimeUtility.encodeWord(file.getFilename()), file);  
		        }
		        helper.setFrom(sender.getUsername());
		        helper.setText(this.body);    
		        helper.setSubject(this.subject);  
		        helper.setSentDate(new Date());  
				String email[] = this.to.split(";");   
			    for(int i=0;i<email.length;i++) {   
			        helper.setTo(email[i]);  
			        sender.send(msg);  
			        this.logInfo+="发邮件给："+email[i]+"<br>";
			    }
			}

			this.state="成功";
	        
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.state="失败";
			this.logInfo+=e.getMessage();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.state="失败";
			this.logInfo+=e.getMessage();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.state="失败";
			this.logInfo+=e.getMessage();
		}
		

	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
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
        this.setTo(dataMap.getString("to"));
        this.setBody(dataMap.getString("body"));
        this.setSubject(dataMap.getString("subject"));
        this.setReports(parseParamValue(dataMap.getString("reports")));
        this.setReportParams(parseParamValue(dataMap.getString("reportParams")));
        this.setFileType(dataMap.getString("fileType"));
        this.setSavePath(parseParamValue(dataMap.getString("savePath")));
        this.setSendEmail(dataMap.getString("sendEmail"));
        
        SysJobLog jobLog=new SysJobLog();
        jobLog.setJobId(jobId);
        this.sendEmail();
        jobLog.setLogInfo(logInfo);
        jobLog.setFireState(state);
        jobLog.setFireTime(jobStartTime);
		jobLog.setTimeLength((int) ((new Date().getTime() -jobStartTime.getTime())/1000) );
		JobLogService jobLogService = appContext.getBean("jobLogService",JobLogService.class);
		jobLogService.saveJobLog(jobLog);
		
	}
	private String parseParamValue(String paramExpression){
		if(paramExpression==null)return "";
		String dateTimeStr=DateUtil.getCurrentDate("yyyyMMddHHmmss");
		String dateStr=DateUtil.getCurrentDate("yyyyMMdd");
		return paramExpression.replace("${dateTime}", dateTimeStr).replace("${date}",dateStr);
	}
	private Map<String,String> getParamMap(String url){
		Map<String,String> paramMap=new HashMap<String,String>();
		String [] params=url.split(";");
		for(String param:params){
			String [] paramPart=param.split("=");
			if(paramPart.length==2){
				paramMap.put(paramPart[0],paramPart[1]);
			}
		}
		return paramMap;
	}
}
