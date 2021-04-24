package com.solidextend.sys.module.vo;

import java.util.List;
import java.util.Map;

/**
 * 模块值对象
 * @author songjunjie
 * @version 2014-1-6 上午10:37:52
 */
public class Module {
    private String id;
    private String moduleCode;
    private String moduleName;
    private String url;
    private String iconCls;
    private Short orderNo;
    private String remark;
    private String moduleType;
    private String parentId;
    private String isPublic;
    private String isFolder;
    private String disabled;
    private String funGroupCode;
    private List<Map> funs;
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getModuleCode() {
        return moduleCode;
    }

    public void setModuleCode(String moduleCode) {
        this.moduleCode = moduleCode == null ? null : moduleCode.trim();
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName == null ? null : moduleName.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls == null ? null : iconCls.trim();
    }

    public Short getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Short orderNo) {
        this.orderNo = orderNo;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getModuleType() {
        return moduleType;
    }

    public void setModuleType(String moduleType) {
        this.moduleType = moduleType == null ? null : moduleType.trim();
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId == null ? null : parentId.trim();
    }

    public String getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(String isPublic) {
        this.isPublic = isPublic == null ? null : isPublic.trim();
    }

    public String getDisabled() {
        return disabled;
    }

    public void setDisabled(String disabled) {
        this.disabled = disabled == null ? null : disabled.trim();
    }
	public String getFunGroupCode() {
		return funGroupCode;
	}
	public void setFunGroupCode(String funGroupCode) {
		this.funGroupCode = funGroupCode;
	}
	public List<Map> getFuns() {
		return funs;
	}
	public void setFuns(List<Map> funs) {
		this.funs = funs;
	}
	public String getIsFolder() {
		return isFolder;
	}
	public void setIsFolder(String isFolder) {
		this.isFolder = isFolder;
	}
    
}