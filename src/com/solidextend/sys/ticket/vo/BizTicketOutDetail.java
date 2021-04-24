package com.solidextend.sys.ticket.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizTicketOutDetail{
    /**
     * 出库单明细编号
     */
    private String outDetailId;
    /**
     * 出库单编号
     */
    private String outId;
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
     * 出库单明细编号
     */
    public String getOutDetailId(){
        return this.outDetailId;
    }

    /**
     * 出库单明细编号
     */
    public void setOutDetailId(String outDetailId){
        this.outDetailId = outDetailId;
    }    
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
}