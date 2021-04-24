package com.solidextend.sys.dataset.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.core.mybatis.dynamic.MapperDynamicLoader;
import com.solidextend.sys.dataset.dao.DataSetMapper;
import com.solidextend.sys.dataset.vo.Params;

/**
 * 数据查询
 * @author changxiaoxue
 * @version 2015-2-8 上午12:27:25
 */
@Service
public class DataSetServiceImpl implements DataSetService {

	@Resource
	private DataSetMapper dataSetMapper;

	@Override
	public List select(String dsId,Params params) {
		// TODO Auto-generated method stub
		String statement="com.zebone.sys.dataset.dao.DataSetMapper."+dsId;
		
		return MapperDynamicLoader.selectList(statement, params);
		 
	}
	

}
