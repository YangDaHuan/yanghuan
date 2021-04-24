package com.solidextend.sys.moduleFun.vo;
/**
 * 模块类型对象
 * @author changxiaoxue
 * @version 2015-1-19 下午16:11
 */
public class ModuleFunGroup {
	private String id;
	private String funGroupCode;
    private String funGroupName;
    private String disabled;
    private String isPublic;
    private int orderNo;
	public String getFunGroupCode() {
		return funGroupCode;
	}
	public void setFunGroupCode(String funGroupCode) {
		this.funGroupCode = funGroupCode;
	}
	public String getFunGroupName() {
		return funGroupName;
	}
	public void setFunGroupName(String funGroupName) {
		this.funGroupName = funGroupName;
	}
	public String getDisabled() {
		return disabled;
	}
	public void setDisabled(String disabled) {
		this.disabled = disabled;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	
    
}
