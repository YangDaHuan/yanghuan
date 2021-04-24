package com.solidextend.sys.dataset.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.dataset.vo.Params;
/**
 * 模块Dao
 * @author changxiaoxue
 * @version 2015-1-19 下午16:11
 */
@Mapper
public interface DataSetMapper {
	
	/**
	 * 根据参数查询
	 * @return
	 */
	List select(Params params);
	
    
}