package com.solidextend.sys.log.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.log.dao.SysJobLogMapper;
import com.solidextend.sys.log.vo.SysJobLog;
@Service("jobLogService")
public class JobLogServiceImpl implements JobLogService {

	private static final Log log = LogFactory.getLog(JobLogServiceImpl.class);
	@Resource
	private SysJobLogMapper jobLogMapper;
	
	@Override
	public int saveJobLog(SysJobLog jobLog) {
		// TODO Auto-generated method stub
		String id = Identities.uuid();
		jobLog.setLogId(id);
		int result=this.jobLogMapper.saveSysJobLog(jobLog);
		return result;
	}

	@Override
	public List<SysJobLog> searchLog(RowBounds rowBounds, SysJobLog jobLog) {
		// TODO Auto-generated method stub
		return this.jobLogMapper.searchLog(jobLog);
	}

	@Override
	public int deleteLog(String [] jobLogIds) {
		// TODO Auto-generated method stub
		for(String id : jobLogIds){
			this.jobLogMapper.deleteSysJobLog(id);
		}
		return 0;
	}

	@Override
	public int deleteLogByJobIdAndDate(String jobId, Date fireTime) {
		// TODO Auto-generated method stub
		return this.jobLogMapper.deleteSysJobLogByJobIdAndDate(jobId, fireTime);
	}

	@Override
	public SysJobLog getSysJobLogById(String logId) {
		// TODO Auto-generated method stub
		return this.jobLogMapper.getSysJobLogById(logId);
	}

}
