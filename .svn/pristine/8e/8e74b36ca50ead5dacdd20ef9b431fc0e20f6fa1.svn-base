/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2012-11-22     审计日志操作实现类
 */
package com.solidextend.sys.log.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.solidextend.core.util.Identities;
import com.solidextend.core.util.MessageUtil;
import com.solidextend.core.util.ReflectUtil;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.log.LogContext;
import com.solidextend.sys.log.dao.AuditLogMapper;
import com.solidextend.sys.log.thread.LogQueue;
import com.solidextend.sys.log.vo.AuditLogInfo;
import com.solidextend.sys.log.vo.AuditLogInfoExt;
import com.solidextend.sys.log.vo.LogConfigInfo;
import com.solidextend.sys.security.UserDetails;

/**
 * 审计日志操作实现类
 * 
 * @author lilin
 * @version [版本号, 2012-11-22]
 */
@Service("btpLog")
public class AuditLogServiceImpl implements BtpLog, AuditLogService {
	/**
	 * 定义log4j
	 */
	private static Logger log = Logger.getLogger(AuditLogServiceImpl.class);

	/**
	 * 操作数据库的mapper对象
	 */
	@Resource
	private AuditLogMapper auditLogMapper;

	/**
	 * 日志队列
	 */
	@Resource
	private LogQueue logQueue;

	/**
	 * 审计日志初始化上下文
	 */
	@Resource
	private LogContext logContext;

	/**
	 * 根据条件分页查询审计日志
	 * 
	 * @param rowBounds
	 *            分页信息
	 * @param auditLogInfo
	 *            查询条件
	 * @return page
	 */
	public JsonData searchLog(RowBounds rowBounds, AuditLogInfo auditLogInfo) {
		JsonData jsonData = new JsonData();
		Date endTime = auditLogInfo.getEndTime();
		if(endTime!=null){
			Calendar cal = Calendar.getInstance();
			cal.setTime(endTime);
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			auditLogInfo.setEndTime(cal.getTime());
		}
		List<AuditLogInfo> auditLogInfoList = auditLogMapper.searchLog(rowBounds,
				auditLogInfo);
		Integer total = auditLogMapper.getTotalCount(auditLogInfo);
		jsonData.setRows(auditLogInfoList);
		jsonData.setTotal(total);
		return jsonData;
	}
	
	/**
	 * 符合查询条件的审计日志的记录数
	 * @param auditLogInfo
	 * @return
	 */
	public int auditLogCount(AuditLogInfo auditLogInfo){
		Date endTime = auditLogInfo.getEndTime();
		if(endTime!=null){
			Calendar cal = Calendar.getInstance();
			cal.setTime(endTime);
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			auditLogInfo.setEndTime(cal.getTime());
		}
		Integer total = auditLogMapper.getTotalCount(auditLogInfo);
		return total;
	}

	/**
	 * 删除审计日志主表数据
	 * 
	 * @param logIds
	 *            日志id集合
	 */
	public void deleteLog(String... logIds) {
		if (logIds != null) {
			for (String logId : logIds) {
				// 先删从表再删主表
				auditLogMapper.deleteLogExt(logId);
				auditLogMapper.deleteLogById(logId);
			}
		}
	}

	/**
	 * 根据日志id查询某条日志的详细信息
	 * 
	 * @param logId
	 *            日志id
	 * @return 日志信息
	 */
	public AuditLogInfo findLogById(String logId) {
		return auditLogMapper.findLogById(logId);
	}

	/**
	 * 记录操作日志(修改的情况)
	 * 
	 * @param id
	 *            一种操作的唯一标识，在常量中定义
	 * @param serviceId
	 *            业务id
	 * @param newObj
	 *            存放新值的对象
	 * @param oldObj
	 *            存放旧值的对象
	 */
	@Override
	public void log(String id, String serviceId, Object newObj, Object oldObj) {
		saveLog(id, serviceId, newObj, oldObj);
	}

	/**
	 * 记录操作日志(新增、删除的情况)
	 * 
	 * @param id
	 *            一种操作的唯一标识，在常量中定义
	 * @param serviceId
	 *            业务id
	 * @param newObj
	 *            存放新值的对象
	 */
	@Override
	public void log(String id, String serviceId, Object newObj) {
		saveLog(id, serviceId, newObj, null);
	}

	/**
	 * 记录操作日志(只需记录是什么操作的情况)
	 * 
	 * @param id
	 *            一种操作的唯一标识，在常量中定义
	 */
	@Override
	public void log(String id) {
		saveLog(id, null, null, null);
	}

	private void saveLog(String id, String serviceId, Object newObj,
			Object oldObj) {
		LogConfigInfo logConfigInfo = getLogConfigInfo(id);
		if (logConfigInfo == null) {
			return;
		}

		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		
		AuditLogInfo auditLogInfo = getAuditLogInfo(logConfigInfo, newObj,
				oldObj);
		auditLogInfo.setServiceId(serviceId);
		auditLogInfo.setOrganId(userDetails.getOrganId());

		// 这里只负责将日志存放到缓存队列中，由另一个线程负责将日志信息入库
		logQueue.putLog(auditLogInfo);

		// // 保存主表
		// mapper.saveLog(auditLogInfo);
		//
		// if (!CollectionUtils.isEmpty(auditLogInfo.getAuditLogInfoExtList()))
		// {
		// for (AuditLogInfoExt auditLogInfoExt :
		// auditLogInfo.getAuditLogInfoExtList())
		// {
		// // 保存从表
		// mapper.saveLogExt(auditLogInfoExt);
		// }
		// }
	}

	private AuditLogInfo getAuditLogInfo(LogConfigInfo logConfigInfo,
			Object newObj, Object oldObj) {
		// 获取用户登录信息
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
				.getPrincipal();

		AuditLogInfo auditLogInfo = new AuditLogInfo();

		// 生成主键
		String logId = Identities.uuid();
		auditLogInfo.setLogId(logId);
		auditLogInfo.setActorId(userDetails.getId());
		auditLogInfo.setCreateTime(new Date());
		auditLogInfo.setIpAddress(userDetails.getIp());
		// auditLogInfo.setLevelCode(userDetails.getLevelCode());
		auditLogInfo.setModelId(logConfigInfo.getModelId());
		auditLogInfo.setOpFlag(logConfigInfo.getOpFlag());
		// 获取描述信息
		auditLogInfo.setDescription(MessageUtil.getMessage("log."
				+ logConfigInfo.getId()));

		if (!CollectionUtils.isEmpty(logConfigInfo.getFieldList())) {
			// 日志模块不影响其他业务模块功能，捕获所有异常，防止程序崩溃
			try {
				auditLogInfo
						.setAuditLogInfoExtList(new ArrayList<AuditLogInfoExt>());
				if(!logConfigInfo.getOpFlag().equals("3")){
					for (String field : logConfigInfo.getFieldList()) {
						AuditLogInfoExt auditLogInfoExt = new AuditLogInfoExt();
						// 设置外键
						auditLogInfoExt.setLogId(logId);
						// 字段名称
						auditLogInfoExt.setName(field);
						if (newObj != null) {
							Object filedValue = ReflectUtil.getFieldValue(newObj,
									field);
							auditLogInfoExt.setValue(String.valueOf(filedValue));
						}

						if (oldObj != null) {
							Object filedValue = ReflectUtil.getFieldValue(oldObj,
									field);
							auditLogInfoExt.setOldValue(String.valueOf(filedValue));
						}

						auditLogInfo.getAuditLogInfoExtList().add(auditLogInfoExt);
					}
				}
				
			} catch (Exception e) {
				// 吃异常，只记录日志
				log.error(e);
			}
		}

		return auditLogInfo;
	}

	private LogConfigInfo getLogConfigInfo(String id) {
		LogConfigInfo logConfigInfo = logContext.getLogConfigInfo(id);
		if (logConfigInfo == null) {
			log.warn("This log id is not been defined in the xml, id is " + id);
		}

		return logConfigInfo;
	}
}
