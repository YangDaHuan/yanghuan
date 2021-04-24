package com.solidextend.sys.ticket.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
import java.util.List;
 
public class BizTicketOut{
    /**
     * 出库单编号
     */
    private String outId;
    /**
     * 出库单编号
     */
    private String outCode;
    
    /**
     * 调配单号
     */
    private String deployCode;
    /**
     * 出库类型
     */
    private Integer outType;
    /**
     * 出库部门
     */
    private String outOrg;
    /**
     * 目标部门
     */
    private String toOrg;
    /**
     * 出库日期
     */
    private Date outDate;
    /**
     * 备注
     */
    private String description;
    /**
     * 操作员
     */
    private String operator;
    /**
     * 详细信息
     * 田
     */
    private List<BizTicketOutDetail> details;

    /**
     * 出库单编号
     */
    public String getOutId(){
        return this.outId;
    }

    /**
     * 出库单编号
     */
    public void setOutId(String outId){
        this.outId = outId;
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
     * 出库类型
     */
    public Integer getOutType(){
        return this.outType;
    }

    /**
     * 出库类型
     */
    public void setOutType(Integer outType){
        this.outType = outType;
    }    
    /**
     * 出库部门
     */
    public String getOutOrg(){
        return this.outOrg;
    }

    /**
     * 出库部门
     */
    public void setOutOrg(String outOrg){
        this.outOrg = outOrg;
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
     * 出库日期
     */
    public Date getOutDate(){
        return this.outDate;
    }

    /**
     * 出库日期
     */
    public void setOutDate(Date outDate){
        this.outDate = outDate;
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
    public String getOutCode() {
		return outCode;
	}

	public void setOutCode(String outCode) {
		this.outCode = outCode;
	}

	/**
     * 详细信息
     * 田
     */
	public List<BizTicketOutDetail> getDetails() {
		return details;
	}
	 /**
     * 详细信息
     * 田
     */
	public void setDetails(List<BizTicketOutDetail> details) {
		this.details = details;
	}


}