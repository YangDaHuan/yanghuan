package com.solidextend.sys.quartz.vo;

import java.util.Date;
import java.util.List;

/**
 *
 * @author 
 */
public class Job{
    /**
     * 
     */
    private String jobId;
    /**
     * 
     */
    private String jobGroupId;
    /**
     * 
     */
    private String jobTypeId;
    /**
     * 
     */
    private String jobName;
    /**
     * 
     */
    private String discription;
    /**
     * 
     */
    private String cronexp;
    
    /**
     * 
     */
    private Date nextFireTime;
    
    /**
     * 
     */
    private Integer timeout;
    /**
     * 
     */
    private Integer retryCount;
    /**
     * 
     */
    private Integer logDays;
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
    private List<JobParam> params;
    
    /**
     * 
     */
    public String getJobId(){
        return this.jobId;
    }

    /**
     * 
     */
    public void setJobId(String jobId){
        this.jobId = jobId;
    }    
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
    public String getJobName(){
        return this.jobName;
    }

    /**
     * 
     */
    public void setJobName(String jobName){
        this.jobName = jobName;
    }
    
    public String getDiscription() {
		return discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

	/**
     * 
     */
    public String getCronexp(){
        return this.cronexp;
    }

    /**
     * 
     */
    public void setCronexp(String cronexp){
        this.cronexp = cronexp;
    }  
    
    
    public Date getNextFireTime() {
		return nextFireTime;
	}

	public void setNextFireTime(Date nextFireTime) {
		this.nextFireTime = nextFireTime;
	}

	/**
     * 
     */
    public Integer getTimeout(){
        return this.timeout;
    }

    /**
     * 
     */
    public void setTimeout(Integer timeout){
        this.timeout = timeout;
    }    
    /**
     * 
     */
    public Integer getRetryCount(){
        return this.retryCount;
    }

    /**
     * 
     */
    public void setRetryCount(Integer retryCount){
        this.retryCount = retryCount;
    }
    
    
    public Integer getLogDays() {
		return logDays;
	}

	public void setLogDays(Integer logDays) {
		this.logDays = logDays;
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
    /**
     * 
     */

	public List<JobParam> getParams() {
		return params;
	}

	public void setParams(List<JobParam> params) {
		this.params = params;
	}
    
}