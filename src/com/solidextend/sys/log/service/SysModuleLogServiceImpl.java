package com.solidextend.sys.log.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.log.dao.SysModuleLogMapper;
import com.solidextend.sys.log.vo.AuditLogInfo;
import com.solidextend.sys.log.vo.SysModuleLog;
import com.solidextend.sys.log.vo.SysModuleLogCount;
import com.solidextend.sys.security.UserDetails;
@Service("SysModuleLogService")
public class SysModuleLogServiceImpl implements SysModuleLogService {
	private static final Log log = LogFactory.getLog(JobLogServiceImpl.class);
	@Resource
	private SysModuleLogMapper sysModuleLogMapper;
	@Override
	public int insertSysModuleLog(SysModuleLog sysModuleLog) {
		// TODO Auto-generated method stub
		// 获取用户登录信息
				UserDetails userDetails = (UserDetails) SecurityUtils.getSubject()
						.getPrincipal();

				// 生成主键
				String logId = Identities.uuid();
				sysModuleLog.setId(logId);
				sysModuleLog.setUserId(userDetails.getId());
				sysModuleLog.setOrganId(userDetails.getOrganId());
				sysModuleLog.setAccessTime(new Date());
				sysModuleLog.setIp(userDetails.getIp());
				
		return sysModuleLogMapper.saveSysModuleLog(sysModuleLog);
	}
	@Override
	public List<SysModuleLogCount> getModuleAccessCount(Date startDate, Date endDate, String userId) {
		// TODO Auto-generated method stub
		if(endDate!=null){
			endDate.setHours(23);
			endDate.setSeconds(59);
			endDate.setMinutes(59);
		}
		
		return this.sysModuleLogMapper.countBySysModuleLog(startDate, endDate, userId);
	}

}
