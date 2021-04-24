package com.solidextend.sys.ticket.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
import java.util.List;

 
public class BizTicketDeploy{
    /**
     * 调配单ID
     */
    private String deployId;
    /**
     * 调配单号
     */
    private String deployCode;
    /**
     * 申请单号
     */
    private String applyCode;
    /**
     * 调配单状态
     */
    private Integer depolyState;
    /**
     * 调配部门
     */
    private String depolyOrg;
    /**
     * 调配部门联系人
     */
    private String depolyContacts;
    /**
     * 调配部门联系电话
     */
    private String depolyPhone;
    /**
     * 来源部门
     */
    private String fromOrg;
    /**
     * 来源部门联系人
     */
    private String fromContacts;
    /**
     * 来源部门联系电话
     */
    private String fromPhone;
    /**
     * 目标部门
     */
    private String toOrg;
    /**
     * 目标部门联系人
     */
    private String toContacts;
    /**
     * 目标部门联系电话
     */
    private String toPhone;
    /**
     * 调配日期
     */
    private Date depolyDate;
    /**
     * 填表人
     */
    private String designUser;
    /**
     * 备注
     */
    private String description;
    
    private List<BizTicketDeployDetail> details;
    /**
     * 创建日期
     */
    private Date createTime;
    /**
     * 更新日期
     */
    private Date updateTime;

    /**
     * 调配单ID
     */
    public String getDeployId(){
        return this.deployId;
    }

    /**
     * 调配单ID
     */
    public void setDeployId(String deployId){
        this.deployId = deployId;
    }    
    /**
     * 调配单号
     */
    public String getDeployCode(){
        return this.deployCode;
    }

    /**
     * 调配单号
     */
    public void setDeployCode(String deployCode){
        this.deployCode = deployCode;
    }    
    /**
     * 申请单号
     */
    public String getApplyCode(){
        return this.applyCode;
    }

    /**
     * 申请单号
     */
    public void setApplyCode(String applyCode){
        this.applyCode = applyCode;
    }    
    /**
     * 调配单状态
     */
    public Integer getDepolyState(){
        return this.depolyState;
    }

    /**
     * 调配单状态
     */
    public void setDepolyState(Integer depolyState){
        this.depolyState = depolyState;
    }    
    /**
     * 调配部门
     */
    public String getDepolyOrg(){
        return this.depolyOrg;
    }

    /**
     * 调配部门
     */
    public void setDepolyOrg(String depolyOrg){
        this.depolyOrg = depolyOrg;
    }    
    /**
     * 调配部门联系人
     */
    public String getDepolyContacts(){
        return this.depolyContacts;
    }

    /**
     * 调配部门联系人
     */
    public void setDepolyContacts(String depolyContacts){
        this.depolyContacts = depolyContacts;
    }    
    /**
     * 调配部门联系电话
     */
    public String getDepolyPhone(){
        return this.depolyPhone;
    }

    /**
     * 调配部门联系电话
     */
    public void setDepolyPhone(String depolyPhone){
        this.depolyPhone = depolyPhone;
    }    
    /**
     * 来源部门
     */
    public String getFromOrg(){
        return this.fromOrg;
    }

    /**
     * 来源部门
     */
    public void setFromOrg(String fromOrg){
        this.fromOrg = fromOrg;
    }    
    /**
     * 来源部门联系人
     */
    public String getFromContacts(){
        return this.fromContacts;
    }

    /**
     * 来源部门联系人
     */
    public void setFromContacts(String fromContacts){
        this.fromContacts = fromContacts;
    }    
    /**
     * 来源部门联系电话
     */
    public String getFromPhone(){
        return this.fromPhone;
    }

    /**
     * 来源部门联系电话
     */
    public void setFromPhone(String fromPhone){
        this.fromPhone = fromPhone;
    }    
    /**
     * 目标部门
     */
    public String getToOrg(){
        return this.toOrg;
    }

    /**
     * 目标部门
     */
    public void setToOrg(String toOrg){
        this.toOrg = toOrg;
    }    
    /**
     * 目标部门联系人
     */
    public String getToContacts(){
        return this.toContacts;
    }

    /**
     * 目标部门联系人
     */
    public void setToContacts(String toContacts){
        this.toContacts = toContacts;
    }    
    /**
     * 目标部门联系电话
     */
    public String getToPhone(){
        return this.toPhone;
    }

    /**
     * 目标部门联系电话
     */
    public void setToPhone(String toPhone){
        this.toPhone = toPhone;
    }    
    /**
     * 调配日期
     */
    public Date getDepolyDate(){
        return this.depolyDate;
    }

    /**
     * 调配日期
     */
    public void setDepolyDate(Date depolyDate){
        this.depolyDate = depolyDate;
    }    
    /**
     * 填表人
     */
    public String getDesignUser(){
        return this.designUser;
    }

    /**
     * 填表人
     */
    public void setDesignUser(String designUser){
        this.designUser = designUser;
    }    
    /**
     * 备注
     */
    public String getDescription(){
        return this.description;
    }

    /**
     * 备注
     */
    public void setDescription(String description){
        this.description = description;
    }    
    
    
    public List<BizTicketDeployDetail> getDetails() {
		return details;
	}

	public void setDetails(List<BizTicketDeployDetail> details) {
		this.details = details;
	}

	/**
     * 创建日期
     */
    public Date getCreateTime(){
        return this.createTime;
    }

    /**
     * 创建日期
     */
    public void setCreateTime(Date createTime){
        this.createTime = createTime;
    }    
    /**
     * 更新日期
     */
    public Date getUpdateTime(){
        return this.updateTime;
    }

    /**
     * 更新日期
     */
    public void setUpdateTime(Date updateTime){
        this.updateTime = updateTime;
    }    
}