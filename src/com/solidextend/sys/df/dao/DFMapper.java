package com.solidextend.sys.df.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.df.vo.ConfigInfo;
import com.solidextend.sys.df.vo.FieldInfo;
import com.solidextend.sys.df.vo.FormInfo;
import com.solidextend.sys.module.vo.Module;


/**
 * DF Mapper
 * @author 王聚金
 * @version 2014-3-04 09:47
 */
@Mapper
public interface DFMapper {
	
	public FormInfo getFormById(String id);
	
	public FieldInfo getFieldById(String id);
	
	public List<FormInfo> getFormList(FormInfo formInfo);
	
	public List<FormInfo> getFormListForCopy(FormInfo formInfo);
	
	public int verifyFormNo(FormInfo formInfo);
	
	public int saveField(FieldInfo fieldInfo);
	
	public List<FieldInfo> getFieldList(Map<String, Object> map);
	
	public List<Map<String, Object>> select(RowBounds rowBounds, Map<String, Object> map);
	
	public List<Map<String, Object>> selectAll(Map<String, Object> map);
	
	public int count(Map<String, Object> map);
	
	public Map<String, Object> get(Map<String, Object> map);
	
	public int delete(Map<String, Object> map);
	
	public int insert(Map<String, Object> map);

	public int update(Map<String, Object> map);
	
	public int check(Map<String, Object> map);
	
	public int saveForm(FormInfo formInfo);
	
	public int updateForm(FormInfo formInfo);
	
	public int publishForm(FormInfo formInfo);
	
	public int deleteForm(String id);
	
	public int deleteFields(String formId);
	
	public int createTable(@Param("tableSql")String tableSql);
	
	public int existsTable(@Param("table")String table);
	
	public List<Module> getModules(String parentId);
	
	public List<Map<String, Object>> selectDs(Map<String, Object> map);
	
	public ConfigInfo getConfigById(String id);
	
	public int updateConfig(ConfigInfo configInfo);
}