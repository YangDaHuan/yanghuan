package com.solidextend.sys.quartz.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.quartz.vo.JobParam;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface JobParamMapper{   
    /**
     * 根据主键查询
     */
    public JobParam getJobParamById(@Param("jobId")String jobId,@Param("paramId")String paramId); 

    /**
     * 查询出所有记录
     */
    public List<JobParam> findAllJobParam();    
    
    /**
     * 保存
     */
    public int saveJobParam(JobParam jobParam);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateJobParam(JobParam jobParam);
    
    /**
     * 根据主键删除
     */
    public int deleteJobParam(@Param("jobId")String jobId);
}

