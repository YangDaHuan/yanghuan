package com.solidextend.sys.quartz.job;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.sys.quartz.service.JobService;
import com.solidextend.sys.ticket.dao.BizTicketStockHistoryMapper;
import com.solidextend.sys.ticket.dao.BizTicketStockMapper;
import com.solidextend.sys.ticket.service.BizTicketStockHistoryService;
import com.solidextend.sys.ticket.service.BizTicketStockService;
import com.solidextend.sys.ticket.vo.BizTicketStock;
import com.solidextend.sys.ticket.vo.BizTicketStockHistory;

public class HistoryStockUpdate implements Job {
	private static final Log log = LogFactory.getLog(HistoryStockUpdate.class);
	/*@Resource
	private BizTicketStockService bizTicketStockService;
	@Resource
	private BizTicketStockHistoryService bizTicketStockHistoryService;
	@Resource
	private BizTicketStockMapper bizTicketStockMapper;
	@Resource
	private BizTicketStockHistoryMapper BizTicketStockHistoryMapper;*/
	private BizTicketStockHistory bizTicketStockHistory;
	
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		
		JobDetail jobDetail = context.getJobDetail(); 
		String jobName = jobDetail.getName();//任务名称      
		Date nextFireTime=context.getNextFireTime();
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		JobService jobService = appContext.getBean("jobService",JobService.class);
		BizTicketStockService bizTicketStockService = appContext.getBean("bizTicketStockService",BizTicketStockService.class);
		BizTicketStockHistoryService bizTicketStockHistoryService = appContext.getBean("bizTicketStockHistoryService",BizTicketStockHistoryService.class);
        jobService.updateNextFireTime(jobName,nextFireTime);
        // Log the time the job started       
		log.info(jobName + " fired at " + new Date());//记录任务开始执行的时间 
		
		try {
			List<BizTicketStock> list = bizTicketStockService.findAllBizTicketStock();
			Date date = new Date();
			bizTicketStockHistory = new BizTicketStockHistory();
		for(int i=0;i<list.size();i++) {
			bizTicketStockHistory.setStockId(null);
			bizTicketStockHistory.setStockDate(date);
			bizTicketStockHistory.setStockOrg(list.get(i).getStockOrg());
			bizTicketStockHistory.setTicketMoney(list.get(i).getTicketMoney());
			bizTicketStockHistory.setTicketNumber(list.get(i).getTicketNumber());
			bizTicketStockHistory.setTicketStateId(list.get(i).getTicketStateId());
			bizTicketStockHistory.setTicketTypeId(list.get(i).getTicketTypeId());
			bizTicketStockHistoryService.saveBizTicketStockHistory(bizTicketStockHistory);
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	}
	

