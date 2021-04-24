package com.solidextend.sys.df.service;

import java.util.List;
import java.util.Map;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.df.vo.ConfigInfo;
import com.solidextend.sys.df.vo.FieldInfo;
import com.solidextend.sys.df.vo.FormInfo;
import com.solidextend.sys.module.vo.Module;

public interface DFService {

	public int saveForm(FormInfo formInfo);
	
	public int updateForm(FormInfo formInfo);
	
	public int publishForm(FormInfo formInfo);
	
	public int deleteForm(String id, String path);
	
	public int verifyFormNo(FormInfo formInfo);
	
	public List<FormInfo> getFormList(int publish);
	
	public List<FormInfo> getFormListNotId(String id);
	
	public List<FormInfo> getFormListForCopy(String id);
	
	public FormInfo getFormInfo(String id);
	
	public FieldInfo getFieldInfo(String id);
	
	public List<FieldInfo> getFieldList(Map<String, Object> map);
	
	public JsonData select(PageParam pageParam, Map<String, Object> map);
	
	public List<Map<String, Object>> selectAll(Map<String, Object> map);
	
	public Map<String, Object> get(Map<String, Object> map);
	
	public int delete(Map<String, Object> map);
	
	public int save(Map<String, Object> map);
	
	public int check(Map<String, Object> map);
	
	public int createTable(String tableSql);	
	
	public int existsTable(String table);
	
	public List<Module> getModules(String parentId);
	
	public List<Map<String, Object>> getDsValues(Map<String, Object> map);
	
	public ConfigInfo getConfigById(String id);
	
	public int updateConfig(ConfigInfo configInfo);
}
