package com.solidextend.sys.log.dao;

import java.util.Date;
import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.log.vo.SysJobLog;

import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface SysJobLogMapper{   
    /**
     * 根据主键查询
     */
    public SysJobLog getSysJobLogById(@Param("logId")String logId); 

    /**
     * 查询出所有记录
     */
    public List<SysJobLog> findAllSysJobLogByJobId(@Param("jobId")String jobId);    
    
    /**
     * 查询出所有匹配记录
     */
    public List<SysJobLog> searchLog(SysJobLog sysJobLog);    
    
    /**
     * 保存
     */
    public int saveSysJobLog(SysJobLog sysJobLog);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateSysJobLog(SysJobLog sysJobLog);
    
    /**
     * 根据主键删除
     */
    public int deleteSysJobLog(@Param("logId")String logId);
    /**
     * 根据任务编号和日期删除
     */
    public int deleteSysJobLogByJobIdAndDate(@Param("jobId")String jobId,@Param("fireTime")Date fireTime);
}

