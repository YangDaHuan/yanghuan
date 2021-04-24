package com.solidextend.sys.quartz.vo;
/**
 *
 * @author 
 */
public class JobParam{
    /**
     * 
     */
    private String jobId;
    /**
     * 
     */
    private String paramId;
    /**
     * 
     */
    private String paramName;
    /**
     * 
     */
    private String paramValue;
    /**
     * 
     */
    private Integer sortNo;

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
    public String getParamId(){
        return this.paramId;
    }

    /**
     * 
     */
    public void setParamId(String paramId){
        this.paramId = paramId;
    }    
    /**
     * 
     */
    public String getParamName(){
        return this.paramName;
    }

    /**
     * 
     */
    public void setParamName(String paramName){
        this.paramName = paramName;
    }    
    /**
     * 
     */
    public String getParamValue(){
        return this.paramValue;
    }

    /**
     * 
     */
    public void setParamValue(String paramValue){
        this.paramValue = paramValue;
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