package com.solidextend.sys.df.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.df.dao.DFMapper;
import com.solidextend.sys.df.vo.ConfigInfo;
import com.solidextend.sys.df.vo.FieldInfo;
import com.solidextend.sys.df.vo.FormInfo;
import com.solidextend.sys.module.vo.Module;

@Service
public class DFServiceImpl implements DFService {

	@Resource
	private DFMapper dFMapper;
	
	
	@Override
	public FormInfo getFormInfo(String id) {
		return dFMapper.getFormById(id);
	}
	
	@Override
	public FieldInfo getFieldInfo(String id) {
		return dFMapper.getFieldById(id);
	}
	
	public List<FieldInfo> getFieldList(Map<String, Object> map){
		return dFMapper.getFieldList(map);
	}

	@Override
	public JsonData select(PageParam pageParam, Map<String, Object> map) {
		JsonData jsonData = new JsonData();
		jsonData.setRows(dFMapper.select(pageParam.getRowBounds(), map));
		jsonData.setTotal(dFMapper.count(map));
		return jsonData;
	}
	
	public List<Map<String, Object>> selectAll(Map<String, Object> map){
		return dFMapper.selectAll(map);
	}

	@Override
	public Map<String, Object> get(Map<String, Object> map) {		
		return dFMapper.get(map);
	}

	@Override
	public int delete(Map<String, Object> map) {
		return dFMapper.delete(map);
	}

	@Override
	public int save(Map<String, Object> map) {
		if(map.get("operation").equals("insert")){
			return dFMapper.insert(map);
		}else{
			return dFMapper.update(map);
		}
	}

	@Override
	public int check(Map<String, Object> map) {
		return dFMapper.check(map);
	}

	@Override
	public int saveForm(FormInfo formInfo) {
		dFMapper.saveForm(formInfo);
		for(FieldInfo fieldInfo : formInfo.getFields())
			dFMapper.saveField(fieldInfo);
		return 1;
	}
	@Override
	public int updateForm(FormInfo formInfo){
		dFMapper.updateForm(formInfo);
		for(FieldInfo fieldInfo : formInfo.getFields())
			dFMapper.saveField(fieldInfo);
		return 1;
	}
	@Override
	public int publishForm(FormInfo formInfo){
		return dFMapper.publishForm(formInfo);
	}

	@Override
	public int createTable(String tableSql) {
		return dFMapper.createTable(tableSql);
	}
	@Override
	public int existsTable(String table){
		return dFMapper.existsTable(table);
	}

	@Override
	public List<FormInfo> getFormList(int publish) {
		FormInfo formInfo = new FormInfo();
		formInfo.setPublish(publish);
		return dFMapper.getFormList(formInfo);
	}

	@Override
	public List<FormInfo> getFormListForCopy(String id) {
		FormInfo formInfo = new FormInfo();
		formInfo.setId(id);
		return dFMapper.getFormListForCopy(formInfo);
	}

	@Override
	public int deleteForm(String id, String path) {
		FormInfo formInfo = dFMapper.getFormById(id);
		dFMapper.deleteForm(id);
		dFMapper.deleteFields(id);
		FileUtils.deleteQuietly(new File(path+formInfo.getNo()+".jsp"));
		try{if(formInfo.getPublish()==1) dFMapper.createTable("DROP TABLE "+formInfo.getTable());}catch(Exception e){}
		return 1;
	}

	@Override
	public List<Module> getModules(String parentId) {
		return dFMapper.getModules(parentId);
	}

	@Override
	public int verifyFormNo(FormInfo formInfo) {
		formInfo.setNo(formInfo.getNo().toUpperCase());
		return dFMapper.verifyFormNo(formInfo);
	}

	@Override
	public List<FormInfo> getFormListNotId(String id) {
		FormInfo formInfo = new FormInfo();
		formInfo.setId(id);
		return dFMapper.getFormListForCopy(formInfo);		
	}

	@Override
	public List<Map<String, Object>> getDsValues(Map<String, Object> map) {
		return dFMapper.selectDs(map);
	}

	@Override
	public ConfigInfo getConfigById(String id) {
		return dFMapper.getConfigById(id);
	}

	@Override
	public int updateConfig(ConfigInfo configInfo) {
		return dFMapper.updateConfig(configInfo);
	}
}
