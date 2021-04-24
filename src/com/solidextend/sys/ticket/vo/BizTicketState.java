package com.solidextend.sys.ticket.vo;
import java.sql.Timestamp;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizTicketState{
    /**
     * 
     */
    private String ticketStateId;
    /**
     * 
     */
    private String ticketStateName;
    /**
     * 
     */
    private String designUser;
    /**
     * 
     */
    private Integer sortno;
    /**
     * 
     */
    private String description;
    /**
     * 
     */
    private String isenabled;
    /**
     * 
     */
    private Timestamp createTime;
    /**
     * 
     */
    private Timestamp updateTime;

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
    public String getTicketStateName(){
        return this.ticketStateName;
    }

    /**
     * 
     */
    public void setTicketStateName(String ticketStateName){
        this.ticketStateName = ticketStateName;
    }    
    /**
     * 
     */
    public String getDesignUser(){
        return this.designUser;
    }

    /**
     * 
     */
    public void setDesignUser(String designUser){
        this.designUser = designUser;
    }    
    /**
     * 
     */
    public Integer getSortno(){
        return this.sortno;
    }

    /**
     * 
     */
    public void setSortno(Integer sortno){
        this.sortno = sortno;
    }    
    /**
     * 
     */
    public String getDescription(){
        return this.description;
    }

    /**
     * 
     */
    public void setDescription(String description){
        this.description = description;
    }    
    /**
     * 
     */
    public String getIsenabled(){
        return this.isenabled;
    }

    /**
     * 
     */
    public void setIsenabled(String isenabled){
        this.isenabled = isenabled;
    }    
    /**
     * 
     */
    public Timestamp getCreateTime(){
        return this.createTime;
    }

    /**
     * 
     */
    public void setCreateTime(Timestamp createTime){
        this.createTime = createTime;
    }    
    /**
     * 
     */
    public Timestamp getUpdateTime(){
        return this.updateTime;
    }

    /**
     * 
     */
    public void setUpdateTime(Timestamp updateTime){
        this.updateTime = updateTime;
    }    
}