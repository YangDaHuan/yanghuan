package com.solidextend.sys.ticket.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
import java.util.List;
 
public class BizTicketIn{
	/*
	 * 入库单编号code
	 */
	private String inCode;
    /**
     * 入库单id
     */
    private String inId;
    /**
     * 调配单号
     */
    private String deployCode;
    /**
     * 入库类型
     */
    private Integer inType;
    /**
     * 入库部门
     */
    private String inOrg;
    /**
     * 来源部门
     */
    private String fromOrg;
    /**
     * 入库日期
     */
    private Date inDate;
    /**
     * 备注
     */
    private String description;
    /**
     * 操作员
     */
    private String operator;
    
    private List<BizTicketInDetail> details;

    
    
    public String getInCode() {
		return inCode;
	}

	public void setInCode(String inCode) {
		this.inCode = inCode;
	}

	public List<BizTicketInDetail> getDetails() {
		return details;
	}

	public void setDetails(List<BizTicketInDetail> details) {
		this.details = details;
	}

	/**
     * 入库单编号
     */
    public String getInId(){
        return this.inId;
    }

    /**
     * 入库单编号
     */
    public void setInId(String inId){
        this.inId = inId;
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
     * 入库类型
     */
    public Integer getInType(){
        return this.inType;
    }

    /**
     * 入库类型
     */
    public void setInType(Integer inType){
        this.inType = inType;
    }    
    /**
     * 入库部门
     */
    public String getInOrg(){
        return this.inOrg;
    }

    /**
     * 入库部门
     */
    public void setInOrg(String inOrg){
        this.inOrg = inOrg;
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
     * 入库日期
     */
    public Date getInDate(){
        return this.inDate;
    }

    /**
     * 入库日期
     */
    public void setInDate(Date inDate){
        this.inDate = inDate;
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
    /**
     * 操作员
     */
    public String getOperator(){
        return this.operator;
    }

    /**
     * 操作员
     */
    public void setOperator(String operator){
        this.operator = operator;
    }    
}