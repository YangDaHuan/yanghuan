package com.solidextend.sys.ticket.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizTicketApplyDetail{
    /**
     * 
     */
    private String applyDetailId;
    /**
     * 
     */
    private String applyId;
    /**
     * 
     */
    private String ticketTypeId;
    /**
     * 
     */
    private String ticketStateId;
    /**
     * 
     */
    private Integer ticketNumber;
    /**
     * 
     */
    private Float ticketMoney;

    /**
     * 
     */
    public String getApplyDetailId(){
        return this.applyDetailId;
    }

    /**
     * 
     */
    public void setApplyDetailId(String applyDetailId){
        this.applyDetailId = applyDetailId;
    }    
    /**
     * 
     */
    public String getApplyId(){
        return this.applyId;
    }

    /**
     * 
     */
    public void setApplyId(String applyId){
        this.applyId = applyId;
    }    
    /**
     * 
     */
    public String getTicketTypeId(){
        return this.ticketTypeId;
    }

    /**
     * 
     */
    public void setTicketTypeId(String ticketTypeId){
        this.ticketTypeId = ticketTypeId;
    }    
    /**
     * 
     */
    public String getTicketStateId(){
        return this.ticketStateId;
    }

    /**
     * 
     */
    public void setTicketStateId(String ticketStateId){
        this.ticketStateId = ticketStateId;
    }    
    /**
     * 
     */
    public Integer getTicketNumber(){
        return this.ticketNumber;
    }

    /**
     * 
     */
    public void setTicketNumber(Integer ticketNumber){
        this.ticketNumber = ticketNumber;
    }    
    /**
     * 
     */
    public Float getTicketMoney(){
        return this.ticketMoney;
    }

    /**
     * 
     */
    public void setTicketMoney(Float ticketMoney){
        this.ticketMoney = ticketMoney;
    }    
}