package com.solidextend.sys.quartz.job;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import com.raqsoft.report.model.ReportDefine;
import com.raqsoft.report.usermodel.Context;
import com.raqsoft.report.usermodel.Engine;
import com.raqsoft.report.usermodel.INormalCell;
import com.raqsoft.report.usermodel.IReport;
import com.raqsoft.report.util.ReportUtils;
import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.sys.quartz.service.JobService;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

public class SendMessage implements Job {
	
	private static final Log log = LogFactory.getLog(SendMessage.class);
	private String sn="";
	private String pwd="";
	private String mobile="";
	private String report="";
	private int row=1;
	private int col=1;
	
	public String getSn() {
		return sn;
	}


	public void setSn(String sn) {
		this.sn = sn;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getMobile() {
		return mobile;
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public String getReport() {
		return report;
	}


	public void setReport(String report) {
		this.report = report;
	}

	
	public int getRow() {
		return row;
	}


	public void setRow(int row) {
		this.row = row;
	}


	public int getCol() {
		return col;
	}


	public void setCol(int col) {
		this.col = col;
	}


	public void execut(){
		
		try {
			Context cxt = new Context();
			if( (report.lastIndexOf(".rpx")) <= 0 ){
				report = report + ".rpx";
			}
			if(report.startsWith("\\")){
				String reportFileHome=cxt.getMainDir();
				report=reportFileHome+report;
				String webRoot=this.getClass().getClassLoader().getResource("/").getPath();
				webRoot=webRoot.substring(0,webRoot.length()-16);
				report=webRoot+report;
				
			}  
			
			ReportDefine rd = (ReportDefine)ReportUtils.read(report);
			Engine engine = new Engine(rd, cxt);  
			
			IReport iReport = engine.calc();
			INormalCell cell=iReport.getCell(row,col);
			String cellText=(String)cell.getValue();
			
			//短信发送	
		    String content=URLEncoder.encode(cellText, "utf8");
		    //Client client = new Client(sn,pwd);
			
		    //String result_mt = client.mdsmssend(mobile, content, "", "", "", "");
			//System.out.println(result_mt);
		    /*String url="https://eco.taobao.com/router/rest";
		    String appkey="23299206";
		    String secret="a7fdc47565b1a048ff4fed13f4fae8c9";
		    TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		    AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		    req.setExtend("123456");
		    req.setSmsType("normal");
		    req.setSmsFreeSignName("阿里大鱼");
		    req.setSmsParamString("");
		    req.setRecNum(mobile);
		    req.setSmsTemplateCode("SMS_585014");
		    AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		    System.out.println(rsp.getBody());*/
		    
			System.out.println(cellText);
			System.out.println(mobile);
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
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
        this.setReport(dataMap.getString("report"));
        this.setSn(dataMap.getString("sn"));
        this.setPwd(dataMap.getString("pwd"));
        this.setRow(Integer.parseInt(dataMap.getString("row")));
        this.setCol(Integer.parseInt(dataMap.getString("col")));
        this.setMobile(dataMap.getString("mobile"));
        this.execut();
        
	}
	
	
}
