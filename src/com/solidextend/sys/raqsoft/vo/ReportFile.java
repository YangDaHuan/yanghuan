package com.solidextend.sys.raqsoft.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ReportFile {
	private String name;
	private boolean isParent;
	private String id;
	private String parentId;
	private Date lastModified;
	private String type;
	private String size;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean getIsParent () {
		return isParent ;
	}
	public void setIsParent (boolean isParent) {
		this.isParent  = isParent ;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public Date getLastModified() {
		return lastModified;
	}
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	
	
	
}
