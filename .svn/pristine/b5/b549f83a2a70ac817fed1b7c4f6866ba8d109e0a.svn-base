package com.solidextend.sys.log.vo;

import java.util.Date;

/**
 *
 * @author 
 */
public class SysJobLog{
    /**
     * 
     */
    private String logId;
    /**
     * 
     */
    private String jobId;
    /**
     * 
     */
    private Date fireTime;
    /**
     * 
     */
    private Date searchStartTime;
    /**
     * 
     */
    private Date searchEndTime;
    /**
     * 
     */
    private String fireState;
    /**
     * 
     */
    private String logInfo;
    /**
     * 
     */
    private Integer timeLength;
    /**
     * 
     */
    private Integer retryCount;

    /**
     * 
     */
    public String getLogId(){
        return this.logId;
    }

    /**
     * 
     */
    public void setLogId(String logId){
        this.logId = logId;
    }    
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
    public Date getFireTime(){
        return this.fireTime;
    }

    /**
     * 
     */
    public void setFireTime(Date fireTime){
        this.fireTime = fireTime;
    }    
    /**
     * 
     */
    public String getFireState(){
        return this.fireState;
    }

    /**
     * 
     */
    public void setFireState(String fireState){
        this.fireState = fireState;
    }    
    /**
     * 
     */
    public String getLogInfo(){
        return this.logInfo;
    }

    /**
     * 
     */
    public void setLogInfo(String logInfo){
    	if(logInfo!=null&&logInfo.length()>200){
    		this.logInfo=logInfo.substring(0,200);
    	}else{
    		this.logInfo = logInfo;
    	}
    }    
    /**
     * 
     */
    public Integer getTimeLength(){
        return this.timeLength;
    }

    /**
     * 
     */
    public void setTimeLength(Integer timeLength){
        this.timeLength = timeLength;
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

	public Date getSearchStartTime() {
		return searchStartTime;
	}

	public void setSearchStartTime(Date searchStartTime) {
		this.searchStartTime = searchStartTime;
	}

	public Date getSearchEndTime() {
		return searchEndTime;
	}

	public void setSearchEndTime(Date searchEndTime) {
		this.searchEndTime = searchEndTime;
	}    
    
    
}