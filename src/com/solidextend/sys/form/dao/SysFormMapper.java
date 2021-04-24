package com.solidextend.sys.form.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.form.vo.SysForm;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */

@Mapper
public interface SysFormMapper{   
    /**
     * 根据主键查询
     */
    public SysForm getSysFormById(@Param("formId")String formId); 

    /**
     * 查询出所有记录
     */
    public List<SysForm> findAllSysForm();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<SysForm> findByAttrSysForm(SysForm sysForm);    
    
    /**
     * 保存
     */
    public int saveSysForm(SysForm sysForm);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateSysForm(SysForm sysForm);
    
    /**
     * 根据主键删除
     */
    public int deleteSysForm(@Param("formId")String formId);
}

