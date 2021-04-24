package com.solidextend.sys.input.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.input.vo.SysInputTask;

import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface SysInputTaskMapper{   
    /**
     * 根据主键查询
     */
    public SysInputTask getSysInputTaskById(@Param("taskId")String taskId); 

    /**
     * 查询出所有记录
     */
    public List<SysInputTask> findAllSysInputTask();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<SysInputTask> findByAttrSysInputTask(SysInputTask sysInputTask);    
    
    /**
     * 保存
     */
    public int saveSysInputTask(SysInputTask sysInputTask);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateSysInputTask(SysInputTask sysInputTask);
    
    /**
     * 根据主键删除
     */
    public int deleteSysInputTask(@Param("taskId")String taskId);
}

