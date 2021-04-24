package com.solidextend.sys.quartz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.quartz.vo.JobType;

/**
 * 任务类型Dao
 * @author 常小雪
 * @version 2014-1-2 上午11:12:15
 */
@Mapper
public interface JobTypeMapper {
	
	

	/**
	 * 添加任务类型
	 * @return
	 */
	int insertJobType(JobType jobType);
	
	/**
	 * 删除任务类型
	 * @return
	 */
	int deleteJobType(String jobTypeId);
	
	/**
	 * 更新任务类型
	 * @return
	 */
	int updateJobType(JobType jobType);
	
	/**
	 * 根据状态得到所有任务类型
	 * @return
	 */
	List<JobType> getJobTypeList(@Param("state")Integer state);
	

	/**
	 * 根据ID得到任务类型
	 * @return
	 */
	JobType getJobTypeById(@Param("jobTypeId")String jobTypeId);
	
	
	
	
	
    
}