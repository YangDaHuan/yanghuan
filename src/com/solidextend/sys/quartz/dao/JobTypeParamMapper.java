package com.solidextend.sys.quartz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.quartz.vo.JobTypeParam;

/**
 * 任务类型Dao
 * @author 常小雪
 * @version 2014-1-2 上午11:12:15
 */
@Mapper
public interface JobTypeParamMapper {
	
	

	
	/**
	 * 添加任务类型参数
	 * @return
	 */
	int insertJobTypeParam(JobTypeParam jobTypeParam);
	
	/**
	 * 删除任务类型参数
	 * @return
	 */
	int deleteJobTypeParam(String paramId);
	
	/**
	 * 删除任务类型参数
	 * @return
	 */
	int deleteJobTypeParamByTypeId(String jobTypeId);
	
	/**
	 * 更新任务类型
	 * @return
	 */
	int updateJobTypeParam(JobTypeParam jobTypeParam);
	
	/**
	 * 根据任务类型编号得到所有任务类型参数
	 * @return
	 */
	List<JobTypeParam> getJobTypeParamList(@Param("state")Integer state,@Param("jobTypeId")String jobTypeId);
	
	
	
    
}