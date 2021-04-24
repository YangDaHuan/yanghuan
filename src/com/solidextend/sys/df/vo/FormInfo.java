package com.solidextend.sys.df.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FormInfo {

	private String id;
	private String no;
	private String name;
	private String table;
	private String primary;
	private String primaryField;
	private String remark;
	private int publish = 0;
	private Map<String, String> uniques = new HashMap<String, String>();
	private List<FieldInfo> fields = new ArrayList<FieldInfo>();
	private String tempType;
	private String moduleId;
	private int fileUpload = 0; //是否需要文件上传
	private int actionAdd = 1;//新增按钮
	private int actionUpdate = 1;//修改按钮
	private int actionDel = 1; //删除按钮
	private int actionImp = 1;//导入按钮
	private int actionExp = 1;//导出按钮
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public List<FieldInfo> getFields() {
		return fields;
	}
	public void setFields(List<FieldInfo> fields) {
		this.fields = fields;
	}
	public String getPrimary() {
		return primary;
	}
	public void setPrimary(String primary) {
		this.primary = primary;
	}
	public Map<String, String> getUniques() {
		return uniques;
	}
	public void setUniques(Map<String, String> uniques) {
		this.uniques = uniques;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getPrimaryField() {
		return primaryField;
	}
	public void setPrimaryField(String primaryField) {
		this.primaryField = primaryField;
	}
	public int getPublish() {
		return publish;
	}
	public void setPublish(int publish) {
		this.publish = publish;
	}
	public String getTempType() {
		return tempType;
	}
	public void setTempType(String tempType) {
		this.tempType = tempType;
	}
	public String getModuleId() {
		return moduleId;
	}
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}
	public int getFileUpload() {
		return fileUpload;
	}
	public void setFileUpload(int fileUpload) {
		this.fileUpload = fileUpload;
	}
	public int getActionAdd() {
		return actionAdd;
	}
	public void setActionAdd(int actionAdd) {
		this.actionAdd = actionAdd;
	}
	public int getActionUpdate() {
		return actionUpdate;
	}
	public void setActionUpdate(int actionUpdate) {
		this.actionUpdate = actionUpdate;
	}
	public int getActionDel() {
		return actionDel;
	}
	public void setActionDel(int actionDel) {
		this.actionDel = actionDel;
	}
	public int getActionImp() {
		return actionImp;
	}
	public void setActionImp(int actionImp) {
		this.actionImp = actionImp;
	}
	public int getActionExp() {
		return actionExp;
	}
	public void setActionExp(int actionExp) {
		this.actionExp = actionExp;
	}
	
}
