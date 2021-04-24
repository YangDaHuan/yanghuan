package com.solidextend.sys.ticket.vo;
import java.sql.Timestamp;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizTicketType{
    /**
     * 
     */
    private String ticketTypeId;
    /**
     * 
     */
    private String ticketTypeName;
    /**
     * 
     */
    private Integer isHaveMoney;
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
     * 票卡分组
     */
    private String groupName;
    /**
     * 
     */
    private Timestamp updateTime;

    /**
     * 
     */
    
    public String getTicketTypeId(){
        return this.ticketTypeId;
    }

    public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
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
    public String getTicketTypeName(){
        return this.ticketTypeName;
    }

    /**
     * 
     */
    public void setTicketTypeName(String ticketTypeName){
        this.ticketTypeName = ticketTypeName;
    }    
    /**
     * 
     */
    public Integer getIsHaveMoney(){
        return this.isHaveMoney;
    }

    /**
     * 
     */
    public void setIsHaveMoney(Integer isHaveMoney){
        this.isHaveMoney = isHaveMoney;
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