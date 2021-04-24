/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2012-11-27     审计日志管理控制层
 */
package com.solidextend.sys.log.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wsepr.easypoi.excel.Excel;
import wsepr.easypoi.excel.style.Align;
import wsepr.easypoi.excel.style.Color;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.log.service.AuditLogService;
import com.solidextend.sys.log.service.JobLogService;
import com.solidextend.sys.log.service.LoginLogService;
import com.solidextend.sys.log.service.SysModuleLogService;
import com.solidextend.sys.log.vo.AuditLogInfo;
import com.solidextend.sys.log.vo.LoginLog;
import com.solidextend.sys.log.vo.SysJobLog;
import com.solidextend.sys.log.vo.SysModuleLog;
import com.solidextend.sys.log.vo.SysModuleLogCount;

/**
 * 审计日志管理控制层
 * 
 * @author lilin
 * @version [版本号, 2012-11-27]
 */
@Controller
@RequestMapping("log")
public class AuditLogController {
	private static final Log log = LogFactory.getLog(AuditLogController.class);
	/**
	 * 审计日志业务接口
	 */
	@Autowired
	@Qualifier(value = "btpLog")
	private AuditLogService auditLogService;
	
	@Resource
	private LoginLogService loginLogService;

	@Resource
	private JobLogService jobLogService;

	@Resource
	private SysModuleLogService sysModuleLogService;
	/**
	 * 日志主页面
	 * @return url
	 */
	@RequestMapping("/logIndex")
	public String logIndex(){
		return "log/logIndex";
	}
	/**
	 * 审计日志列表页面
	 * 
	 * @return url
	 */
	@RequestMapping("/auditLogIndex")
	public String auditLogIndex() {
		return "log/auditLogIndex";
	}
	
	/**
	 * 登录日志列表页面
	 * @return url
	 */
	@RequestMapping("/loginLogIndex")
	public String loginLogIndex(){
		return "log/loginLogIndex";
	}
	
	/**
	 * 任务日志列表页面
	 * @return url
	 */
	@RequestMapping("/jobLogIndex")
	public String jobLogIndex(){
		return "log/jobLogIndex";
	}
	/**
	 * 访问日志列表页面
	 * @return url
	 */
	@RequestMapping("/moduleLogIndex")
	public String moduleLogIndex(){
		return "log/moduleLogIndex";
	}
	/**
	 * 查询一条日志的完整信息
	 * 
	 * @param logId
	 *            logId
	 * @param modelMap
	 *            modelMap
	 * @return url
	 */
	@RequestMapping("/findAuditLogById")
	public String findLogById(String logId, ModelMap modelMap) {
		AuditLogInfo auditLogInfo = auditLogService.findLogById(logId);
		modelMap.addAttribute("auditLogInfo", auditLogInfo);
		return "log/auditLogDetail";
	}

	/**
	 * 分页查询日志信息
	 * 
	 * @param auditLogInfo
	 *            查询条件集合
	 * @param page
	 *            分页对象
	 * @return list
	 */
	@RequestMapping("/searchAuditLog")
	@ResponseBody
	public JsonData searchLog(AuditLogInfo auditLogInfo, PageParam pageParam) {
		JsonData jsonData = new JsonData();
		try {
			
			jsonData = auditLogService.searchLog(pageParam.getRowBounds(),
					auditLogInfo);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			jsonData.setSuccess(false);
			log.error("", e);
		}
		return jsonData;
	}
	
	/**
	 * 分页查询登录日志信息
	 * @param loginLog
	 * @param pageParam
	 * @return JsonData
	 */
	@RequestMapping("/searchLoginLog")
	@ResponseBody
	public JsonData searchLog(LoginLog loginLog, PageParam pageParam) {
		JsonData jsonData = new JsonData();
		try {
			jsonData = loginLogService.searchLog(pageParam.getRowBounds(),
					loginLog);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			jsonData.setSuccess(false);
			log.error("", e);
		}
		return jsonData;
	}
	/**
	 * 分页查询登录日志信息
	 * @param loginLog
	 * @param pageParam
	 * @return JsonData
	 */
	@RequestMapping("/searchJobLog")
	@ResponseBody
	public JsonData searchLog(SysJobLog jobLog, PageParam pageParam) {
		JsonData jsonData = new JsonData();
		Date end=jobLog.getSearchEndTime();
		int dayMis=1000*60*60*24-1;
		if(end != null){
			jobLog.setSearchEndTime(new Date(end.getTime()+dayMis));
		}
		try {
			jsonData.setRows(jobLogService.searchLog(pageParam.getRowBounds(),
					jobLog));
			jsonData.setSuccess(true);
		} catch (Exception e) {
			jsonData.setSuccess(false);
			log.error("", e);
		}
		return jsonData;
	}
	/**
	 * 根据日志编号查询任务日志信息
	 * @param loginLog
	 * @param pageParam
	 * @return JsonData
	 */
	@RequestMapping("/searchJobLogById")
	@ResponseBody
	public SysJobLog searchLog(String logId) {
			return jobLogService.getSysJobLogById(logId);
	}

	/**
	 * 删除审计日志
	 * 
	 * @param id
	 *            日志id
	 * @return 结果
	 */
	@RequestMapping("/removeAuditLog")
	@ResponseBody
	public Map<String, Object> removeLog(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		auditLogService.deleteLog(id.split(","));
		map.put("success", true);
		return map;
	}
	
	/**
	 * 删除登录日志
	 * @param id
	 * @return Map<String, Object>
	 */
	@RequestMapping("/removeLoginLog")
	@ResponseBody
	public Map<String, Object> removeLoginLog(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		loginLogService.deleteLog(id.split(","));
		map.put("success", true);
		return map;
	}
	/**
	 * 删除任务日志
	 * @param id
	 * @return Map<String, Object>
	 */
	@RequestMapping("/removeJobLog")
	@ResponseBody
	public Map<String, Object> removeJobLog(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		jobLogService.deleteLog(id.split(","));
		map.put("success", true);
		return map;
	}
	/**
	 * 导出登录日志
	 * @param id
	 * @return JsonData
	 */
	@RequestMapping("/exportLoginLog")
	public void exportLoginLog(LoginLog loginLog, HttpServletResponse response,HttpServletRequest request) {
		try {
			int count = loginLogService.loginLogCount(loginLog);
			PageParam pageParam = new PageParam();
			pageParam.setPage(1);
			pageParam.setRows(count);
			JsonData jsonData = loginLogService.searchLog(pageParam.getRowBounds(), loginLog);
 			List<LoginLog> list = jsonData.getRows();
 			Excel excel = new Excel();
 			int sheetIndex = 0;//当前sheet的索引
 			excel.setWorkingSheet(sheetIndex);
 			setLoginLogExcelHeader(excel);
 			int rowNum = 1;
 			for(LoginLog log : list){
 				if(rowNum>65535){//超过65535行后，新建一个sheet。 
 					excel.setWorkingSheet(++sheetIndex);
 					setLoginLogExcelHeader(excel);
 					rowNum = 1;
 				}
 				
 				excel.cell(rowNum, 0).value(log.getUserName()).align(Align.CENTER);
 				excel.cell(rowNum, 1).value(log.getLoginTime()).align(Align.CENTER);
 				excel.cell(rowNum, 2).value(log.getIp()).align(Align.CENTER);
 				excel.cell(rowNum, 3).value(log.getLogoutTime()).align(Align.CENTER);
 				excel.cell(rowNum, 4).value(log.getOrganName()).align(Align.CENTER);
 				rowNum ++;
 			}
 			response.setContentType("application/vnd.ms-excel");
 			response.addHeader("Content-Disposition", "attachment;filename=" + new String("登录日志.xls".getBytes("gbk"),"iso8859-1"));
 			OutputStream out =  response.getOutputStream();
 			excel.saveExcel(out);
		} catch (Exception e) {
			log.error("", e);
		}
	}
	
	/**
	 * 导出审计日志
	 * @param auditLogInfo
	 * @param response
	 */
	@RequestMapping("/exportAuditLog")
	public void exportAuditLog(AuditLogInfo auditLogInfo,HttpServletResponse response){
		try {
			
			
			int count = this.auditLogService.auditLogCount(auditLogInfo);
			PageParam pageParam = new PageParam();
			pageParam.setPage(1);
			pageParam.setRows(count);
			JsonData jsonData = this.auditLogService.searchLog(pageParam.getRowBounds(), auditLogInfo);
			List<AuditLogInfo> list = jsonData.getRows();
			Excel excel = new Excel();
			int sheetIndex = 0;//当前sheet的索引
			excel.setWorkingSheet(sheetIndex);
			setAuditLogExcelHeader(excel);
			int rowNum = 1;
				for(AuditLogInfo log : list){
					if(rowNum>65535){//超过65535行后，新建一个sheet。 
						excel.setWorkingSheet(++sheetIndex);
						setAuditLogExcelHeader(excel);
						rowNum = 1;
					}
					excel.cell(rowNum, 0).value(log.getFullName()).align(Align.CENTER);
					excel.cell(rowNum, 1).value(log.getCreateTime()).align(Align.CENTER);
					excel.cell(rowNum, 2).value(log.getIpAddress()).align(Align.CENTER);
					excel.cell(rowNum, 3).value(log.getModuleName()).align(Align.CENTER);
					excel.cell(rowNum, 4).value(log.getServiceId()).align(Align.CENTER);
					String opt = log.getOpFlag();
					if(opt.equals("1")){
						opt = "新增";
					}else if(opt.equals("2")){
						opt = "修改";
					}else if(opt.equals("3")){
						opt = "删除";
					}else if(opt.equals("4")){
						opt = "查询";
					}
					excel.cell(rowNum, 5).value(opt).align(Align.CENTER);
					excel.cell(rowNum, 6).value(log.getDescription()).align(Align.CENTER);
					rowNum ++;
				}
				response.setContentType("application/vnd.ms-excel");
				response.addHeader("Content-Disposition", "attachment;filename=" + new String("审计日志.xls".getBytes("gbk"),"iso8859-1"));
				OutputStream out =  response.getOutputStream();
				excel.saveExcel(out);
		}catch (Exception e) {
			log.error("", e);
		}
	}
	
	/**
	 * 登录日志excel文件的标题行设置
	 * @param excel
	 */
	private void setLoginLogExcelHeader(Excel excel){
		//width方法的参数中 ，1表示一个字符宽度的1/256 
		excel.cell(0 ,0).value("操作人").align(Align.CENTER).width(11*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 1).value("登录时间").align(Align.CENTER).width(21*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 2).value("IP地址").align(Align.CENTER).width(18*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 3).value("注销时间").align(Align.CENTER).width(21*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 4).value("所属机构").align(Align.CENTER).width(15*256).bold().bgColor(Color.GREY_40_PERCENT);
		
	}
	/**
	 * 登录日志excel文件的标题行设置
	 * @param excel
	 */
	private void setAuditLogExcelHeader(Excel excel){
		//width方法的参数中 ，1表示一个字符宽度的1/256 
		excel.cell(0, 0).value("操作人").align(Align.CENTER).width(11*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0 ,1).value("操作时间").align(Align.CENTER).width(21*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 2).value("IP地址").align(Align.CENTER).width(18*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 3).value("模块").align(Align.CENTER).width(15*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 4).value("业务ID").align(Align.CENTER).width(35*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 5).value("操作标识").align(Align.CENTER).width(10*256).bold().bgColor(Color.GREY_40_PERCENT);
		excel.cell(0, 6).value("描述").align(Align.CENTER).width(21*256).bold().bgColor(Color.GREY_40_PERCENT);
	}
	
	/**
	 * 保存模块访问日志信息
	 * 
	 * @param auditLogInfo
	 *            查询条件集合
	 * @param page
	 *            分页对象
	 * @return list
	 */
	@RequestMapping("/saveSysModuleLog")
	@ResponseBody
	public JsonData saveSysModuleLog(SysModuleLog sysModuleLog) {
		
		JsonData jsonData = new JsonData();
		try {
			
			if(this.sysModuleLogService.insertSysModuleLog(sysModuleLog)>0){
			jsonData.setSuccess(true);
			}else{
				jsonData.setSuccess(false);
			}
		} catch (Exception e) {
			jsonData.setSuccess(false);
			log.error("", e);
		}
		return jsonData;
	}
	
	/**
	 * 统计模块访问日志信息
	 * 
	 * @param startDate
	 *            开始日期 
	 * @param endDate
	 *            结束日期 
	 * @param userId
	 *            用户
	 * @return list
	 */
	@RequestMapping("/getModuleAccessCount")
	@ResponseBody
	public JsonData  getModuleAccessCount(Date startDate,Date endDate,String userId){
		
		JsonData jsonData = new JsonData();
		try {
			
			List<SysModuleLogCount> list=this.sysModuleLogService.getModuleAccessCount(startDate,endDate,userId);
			jsonData.setSuccess(true);
			jsonData.setRows(list);
			
		} catch (Exception e) {
			jsonData.setSuccess(false);
			log.error("", e);
		}
		return jsonData;
	}
	
}
