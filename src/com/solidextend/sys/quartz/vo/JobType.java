package com.solidextend.sys.quartz.vo;

import java.util.Date;

/**
 *
 * @author 
 */
public class JobType{
    /**
     * 
     */
    private String jobTypeId;
    /**
     * 
     */
    private String jobTypeName;
    /**
     * 
     */
    private String discription;
    /**
     * 
     */
    private String jobClass;
    /**
     * 
     */
    private Integer state;
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
    public String getJobTypeId(){
        return this.jobTypeId;
    }

    /**
     * 
     */
    public void setJobTypeId(String jobTypeId){
        this.jobTypeId = jobTypeId;
    }    
    /**
     * 
     */
    public String getJobTypeName(){
        return this.jobTypeName;
    }

    /**
     * 
     */
    public void setJobTypeName(String jobTypeName){
        this.jobTypeName = jobTypeName;
    }    
    /**
     * 
     */
    public String getDiscription(){
        return this.discription;
    }

    /**
     * 
     */
    public void setDiscription(String discription){
        this.discription = discription;
    }    
    /**
     * 
     */
    public String getJobClass(){
        return this.jobClass;
    }

    /**
     * 
     */
    public void setJobClass(String jobClass){
        this.jobClass = jobClass;
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