package com.solidextend.sys.log.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.solidextend.sys.log.vo.SysJobLog;

public interface JobLogService {
	/*
	 * 添加任务日志
	 */
	public int saveJobLog(SysJobLog jobLog);
	
	
	/*
	 * 查询任务日志
	 */
	public SysJobLog getSysJobLogById(String logId);
	/*
	 * 查询任务日志
	 */
	public List<SysJobLog> searchLog(RowBounds rowBounds, SysJobLog jobLog);
	/*
	 * 删除任务日志
	 */
	public int deleteLog(String[] jobLogIds);
	/*
	 * 删除任务日志
	 */
	public int deleteLogByJobIdAndDate(String jobId,Date fireTime);
}
