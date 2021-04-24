package com.solidextend.sys.quartz.job;

import java.sql.Timestamp;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.sys.quartz.service.JobService;
import com.solidextend.sys.ticket.service.BizTicketOutService;
import com.solidextend.sys.ticket.service.BizTicketSaleService;
import com.solidextend.sys.ticket.vo.BizTicketOut;
import com.solidextend.sys.ticket.vo.BizTicketOutDetail;
import com.solidextend.sys.ticket.vo.BizTicketSale;

public class BizTicketSaleJob implements Job {
	private static final Log log = LogFactory.getLog(BizTicketSaleJob.class);
	/*@Resource
	private BizTicketStockService bizTicketStockService;
	@Resource
	private BizTicketStockHistoryService bizTicketStockHistoryService;
	@Resource
	private BizTicketStockMapper bizTicketStockMapper;
	@Resource
	private BizTicketStockHistoryMapper BizTicketStockHistoryMapper;*/
	private BizTicketOut bizTicketOut;
	private BizTicketSale bizTicketSale;
	private BizTicketOutDetail bizTicketOutDetail;
	private List<BizTicketOutDetail> Details;
	
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		
		JobDetail jobDetail = context.getJobDetail(); 
		String jobName = jobDetail.getName();//任务名称
		Date nextFireTime=context.getNextFireTime();
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		JobService jobService = appContext.getBean("jobService",JobService.class);
		BizTicketSaleService bizTicketSaleService = appContext.getBean("bizTicketSaleService",BizTicketSaleService.class);
		BizTicketOutService bizTicketOutServce = appContext.getBean("bizTicketOutService",BizTicketOutService.class);
        jobService.updateNextFireTime(jobName,nextFireTime);
        // Log the time the job started       
		log.info(jobName + " fired at " + new Date());//记录任务开始执行的时间 
		
		try {
			bizTicketSale = new BizTicketSale();
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String dateString = sdf.format(date);
			date = sdf.parse(dateString);
			bizTicketSale.setDate(date);
			List<BizTicketSale> list = bizTicketSaleService.findByAttrBizTicketSale(bizTicketSale);
		 
		for(int i=0;i<list.size();i++) {
			bizTicketOut = new BizTicketOut();
		    bizTicketOutDetail = new BizTicketOutDetail();
		    Details = new ArrayList<BizTicketOutDetail>();
			bizTicketOutDetail.setTicketNumber(list.get(i).getSaleNumber());
			bizTicketOutDetail.setTicketTypeId(list.get(i).getTicketTypeId());
			bizTicketOutDetail.setTicketStateId("1035433b623642cea57b602233e96594");
			bizTicketOut.setOutOrg(list.get(i).getChezhan());
			
			bizTicketOut.setOutType(4);//销售出库
			Details.add(bizTicketOutDetail);
			bizTicketOut.setDetails(Details);
			bizTicketOutServce.saveBizTicketOut(bizTicketOut, true);
			
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	}
	

