package com.solidextend.sys.input.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.input.vo.SysInputTaskInstance;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface SysInputTaskInstanceMapper{   
    /**
     * 根据主键查询
     */
    public SysInputTaskInstance getSysInputTaskInstanceById(@Param("taskInstanceId")String taskInstanceId); 

    /**
     * 查询出所有记录
     */
    public List<SysInputTaskInstance> findAllSysInputTaskInstance();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<SysInputTaskInstance> findByAttrSysInputTaskInstance(SysInputTaskInstance sysInputTaskInstance);    
    
    /**
     * 保存
     */
    public int saveSysInputTaskInstance(SysInputTaskInstance sysInputTaskInstance);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateSysInputTaskInstance(SysInputTaskInstance sysInputTaskInstance);
    
    /**
     * 根据主键删除
     */
    public int deleteSysInputTaskInstance(@Param("taskInstanceId")String taskInstanceId);
}

