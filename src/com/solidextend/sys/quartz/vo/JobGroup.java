package com.solidextend.sys.quartz.vo;

import java.util.Date;

/**
 *
 * @author 
 */
public class JobGroup{
    /**
     * 
     */
    private String jobGroupId;
    /**
     * 
     */
    private String jobGroupName;
    /**
     * 
     */
    private Integer state;
    /**
     * 
     */
    private String parentId;
    /**
     * 
     */
    private Date createTime;
    /**
     * 
     */
    private Date lastUpTime;
    /**
     * 
     */
    private String userId;
    /**
     * 
     */
    private Integer sortNo;

    /**
     * 
     */
    public String getJobGroupId(){
        return this.jobGroupId;
    }

    /**
     * 
     */
    public void setJobGroupId(String jobGroupId){
        this.jobGroupId = jobGroupId;
    }    
    /**
     * 
     */
    public String getJobGroupName(){
        return this.jobGroupName;
    }

    /**
     * 
     */
    public void setJobGroupName(String jobGroupName){
        this.jobGroupName = jobGroupName;
    }    
    /**
     * 
     */
    public Integer getState(){
        return this.state;
    }

    /**
     * 
     */
    public void setState(Integer state){
        this.state = state;
    }    
    /**
     * 
     */
    public String getParentId(){
        return this.parentId;
    }

    /**
     * 
     */
    public void setParentId(String parentId){
        this.parentId = parentId;
    }    
    /**
     * 
     */
    public Date getCreateTime(){
        return this.createTime;
    }

    /**
     * 
     */
    public void setCreateTime(Date createTime){
        this.createTime = createTime;
    }    
    /**
     * 
     */
    public Date getLastUpTime(){
        return this.lastUpTime;
    }

    /**
     * 
     */
    public void setLastUpTime(Date lastUpTime){
        this.lastUpTime = lastUpTime;
    }    
    /**
     * 
     */
    public String getUserId(){
        return this.userId;
    }

    /**
     * 
     */
    public void setUserId(String userId){
        this.userId = userId;
    }    
    /**
     * 
     */
    public Integer getSortNo(){
        return this.sortNo;
    }

    /**
     * 
     */
    public void setSortNo(Integer sortNo){
        this.sortNo = sortNo;
    }    
}