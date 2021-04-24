package com.solidextend.sys.form.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.form.vo.SysFormItem;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface SysFormItemMapper{   
    /**
     * 根据主键查询
     */
    public SysFormItem getSysFormItemById(@Param("inputId")String inputId); 

    /**
     * 查询出所有记录
     */
    public List<SysFormItem> findAllSysFormItem();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<SysFormItem> findByAttrSysFormItem(SysFormItem sysFormItem);    
    
    /**
     * 保存
     */
    public int saveSysFormItem(SysFormItem sysFormItem);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateSysFormItem(SysFormItem sysFormItem);
    
    /**
     * 根据主键删除
     */
    public int deleteSysFormItem(@Param("inputId")String inputId);
    /**
     * 根据表单编号删除
     */
    public int deleteSysFormItemByFormId(@Param("formId")String formId);
}

