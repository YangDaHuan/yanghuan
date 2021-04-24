package com.solidextend.sys.ticket.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizTicketInDetail{
	
	
    /**
     * 入库单明细Id
     */
    private String inDetailId;
    
    /*
     * 入库单明细编号
     */
    private String inDetailCode;
    /**
     * 入库单编号
     */
    private String inId;
    /**
     * 票卡类型
     */
    private String ticketTypeId;
    /**
     * 票卡状态
     */
    private String ticketStateId;
    /**
     * 数量
     */
    private Integer ticketNumber;
    /**
     * 金额
     */
    private Float ticketMoney;

    /**
     * 入库单明细编号
     */
    public String getInDetailId(){
        return this.inDetailId;
    }

    /**
     * 入库单明细编号
     */
    public void setInDetailId(String inDetailId){
        this.inDetailId = inDetailId;
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
     * 票卡类型
     */
    public String getTicketTypeId(){
        return this.ticketTypeId;
    }

    /**
     * 票卡类型
     */
    public void setTicketTypeId(String ticketTypeId){
        this.ticketTypeId = ticketTypeId;
    }    
    /**
     * 票卡状态
     */
    public String getTicketStateId(){
        return this.ticketStateId;
    }

    /**
     * 票卡状态
     */
    public void setTicketStateId(String ticketStateId){
        this.ticketStateId = ticketStateId;
    }    
    /**
     * 数量
     */
    public Integer getTicketNumber(){
        return this.ticketNumber;
    }

    /**
     * 数量
     */
    public void setTicketNumber(Integer ticketNumber){
        this.ticketNumber = ticketNumber;
    }    
    /**
     * 金额
     */
    public Float getTicketMoney(){
        return this.ticketMoney;
    }

    /**
     * 金额
     */
    public void setTicketMoney(Float ticketMoney){
        this.ticketMoney = ticketMoney;
    }

	public String getInDetailCode() {
		return inDetailCode;
	}

	public void setInDetailCode(String inDetailCode) {
		this.inDetailCode = inDetailCode;
	}    
}