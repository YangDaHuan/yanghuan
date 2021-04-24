package com.solidextend.sys.input.vo;

import java.util.Date;

/**
 *
 * @author 
 */
public class SysInputTask{
    /**
     * 
     */
    private String taskId;
    /**
     * 
     */
    private String taskName;
    /**
     * 
     */
    private String taskDescribe;
    /**
     * 
     */
    private String disabled;
    /**
     * 
     */
    private Integer formType;
    /**
     * 
     */
    private String formId;
    /**
     * 
     */
    private String inputRole;
    /**
     * 
     */
    private String auditRole;
    /**
     * 
     */
    private Date taskStartTime;
    /**
     * 
     */
    private Date taskEndTime;
    /**
     * 
     */
    private Integer sortno;
    /**
     * 
     */
    private String taskAuthor;
    /**
     * 
     */
    private Date createTime;
    /**
     * 
     */
    private Date lastUpdateTime;

    /**
     * 
     */
    public String getTaskId(){
        return this.taskId;
    }

    /**
     * 
     */
    public void setTaskId(String taskId){
        this.taskId = taskId;
    }    
    /**
     * 
     */
    public String getTaskName(){
        return this.taskName;
    }

    /**
     * 
     */
    public void setTaskName(String taskName){
        this.taskName = taskName;
    }    
    /**
     * 
     */
    public String getTaskDescribe(){
        return this.taskDescribe;
    }

    /**
     * 
     */
    public void setTaskDescribe(String taskDescribe){
        this.taskDescribe = taskDescribe;
    }    
    /**
     * 
     */
    public String getDisabled(){
        return this.disabled;
    }

    /**
     * 
     */
    public void setDisabled(String disabled){
        this.disabled = disabled;
    }    
    /**
     * 
     */
    public Integer getFormType(){
        return this.formType;
    }

    /**
     * 
     */
    public void setFormType(Integer formType){
        this.formType = formType;
    }    
    /**
     * 
     */
    public String getFormId(){
        return this.formId;
    }

    /**
     * 
     */
    public void setFormId(String formId){
        this.formId = formId;
    }    
    /**
     * 
     */
    public String getInputRole(){
        return this.inputRole;
    }

    /**
     * 
     */
    public void setInputRole(String inputRole){
        this.inputRole = inputRole;
    }    
    /**
     * 
     */
    public String getAuditRole(){
        return this.auditRole;
    }

    /**
     * 
     */
    public void setAuditRole(String auditRole){
        this.auditRole = auditRole;
    }    
    /**
     * 
     */
    public Date getTaskStartTime(){
        return this.taskStartTime;
    }

    /**
     * 
     */
    public void setTaskStartTime(Date taskStartTime){
        this.taskStartTime = taskStartTime;
    }    
    /**
     * 
     */
    public Date getTaskEndTime(){
        return this.taskEndTime;
    }

    /**
     * 
     */
    public void setTaskEndTime(Date taskEndTime){
        this.taskEndTime = taskEndTime;
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
    public String getTaskAuthor(){
        return this.taskAuthor;
    }

    /**
     * 
     */
    public void setTaskAuthor(String taskAuthor){
        this.taskAuthor = taskAuthor;
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
    public Date getLastUpdateTime(){
        return this.lastUpdateTime;
    }

    /**
     * 
     */
    public void setLastUpdateTime(Date lastUpdateTime){
        this.lastUpdateTime = lastUpdateTime;
    }    
}