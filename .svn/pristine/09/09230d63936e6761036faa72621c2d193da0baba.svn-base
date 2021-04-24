package com.solidextend.sys.quartz.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.quartz.vo.JobGroup;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface JobGroupMapper{   
    /**
     * 根据主键查询
     */
    public JobGroup getJobGroupById(@Param("jobGroupId")String jobGroupId); 
    
    /**
     * 根据parentId查询
     */
    public List<JobGroup> getJobGroupByPId(@Param("parentId")String parentId); 

    /**
     * 查询出所有记录
     */
    public List<JobGroup> findAllJobGroup(Integer state);    
    
    /**
     * 保存
     */
    public int saveJobGroup(JobGroup jobGroup);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateJobGroup(JobGroup jobGroup);
    
    /**
     * 根据主键删除
     */
    public int deleteJobGroup(@Param("jobGroupId")String jobGroupId);
}

