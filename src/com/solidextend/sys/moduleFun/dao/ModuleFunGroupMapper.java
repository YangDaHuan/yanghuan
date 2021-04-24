package com.solidextend.sys.moduleFun.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.moduleFun.vo.ModuleFunGroup;

/**
 * 模块Dao
 * @author changxiaoxue
 * @version 2015-1-19 下午16:11
 */
@Mapper
public interface ModuleFunGroupMapper {
	
	/**
	 * 得到所有的模块类型，不管是否禁用
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupList();
	
	/**
	 * 得到所有的模块类型的code和name，不要禁用和公共的
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupOptions();
	
	
	/**
	 * 得到指定code的模块类型，忽略指定id的
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupByCode(@Param("id")String id,@Param("code")String code);
	
	/**
	 * 得到指定name的模块类型，忽略指定id的
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupByName(@Param("id")String id,@Param("name")String name);
	
	/**
	 * 插入一个新功能组
	 * @return
	 */
	int insertModuleFunGroup(ModuleFunGroup funGroup);
	
	/**
	 * 更新一个功能组
	 * @return
	 */
	int updateModuleFunGroup(ModuleFunGroup funGroup);
	
	/**
	 * 删除一个功能组
	 * @return
	 */
	int deleteModuleFunGroupByCode(String groupCode);

    
}