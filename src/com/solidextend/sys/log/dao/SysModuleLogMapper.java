package com.solidextend.sys.log.dao;

import java.util.Date;
import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.log.vo.SysModuleLog;
import com.solidextend.sys.log.vo.SysModuleLogCount;

import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface SysModuleLogMapper{   
    /**
     * 根据主键查询
     */
    public SysModuleLog getSysModuleLogById(); 

    /**
     * 查询出所有记录
     */
    public List<SysModuleLog> findAllSysModuleLog();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<SysModuleLog> findByAttrSysModuleLog(SysModuleLog sysModuleLog);    
    
    /**
     * 保存
     */
    public int saveSysModuleLog(SysModuleLog sysModuleLog);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateSysModuleLog(SysModuleLog sysModuleLog);
    
    /**
     * 根据主键删除
     */
    public int deleteSysModuleLog(String id);
    
    /**
     * 根据条件统计访问次数
     */
    public List<SysModuleLogCount> countBySysModuleLog(@Param("startDate") Date startDate,@Param("endDate")Date endDate,@Param("userId")String userId);
}

