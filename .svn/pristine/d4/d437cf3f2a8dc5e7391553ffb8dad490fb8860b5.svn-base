package com.solidextend.sys.quartz.dao;

import java.util.Date;
import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.quartz.vo.Job;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface JobMapper{   
    /**
     * 根据主键查询
     */
    public Job getJobById(@Param("jobId")String jobId); 

    /**
     * 查询出所有记录
     */
    public List<Job> findAllJob(@Param("state") Integer state);    
    /**
     * 查询出所有记录
     */
    public List<Job> findJobByGroupId(@Param("state") Integer state,@Param("jobGroupId") String jobGroupId);    
    
    /**
     * 查询出所有记录
     */
    public List<Job> findAllJobByTypeId(@Param("state")Integer state,@Param("jobTypeId") String jobTypeId);    
    
    /**
     * 保存
     */
    public int saveJob(Job job);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateJob(Job job);
    /**
     * 根据主键更新下次执行时间（参数对象中的主键将作为更新条件）
     */
    public int updateNextFireTime(@Param("jobId")String jobId,@Param("nextFireTime")Date nextFireTime);
    /**
     * 根据主键删除
     */
    public int deleteJob(@Param("jobId")String jobId);
}

