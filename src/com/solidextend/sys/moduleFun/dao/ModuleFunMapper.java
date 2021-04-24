package com.solidextend.sys.moduleFun.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.moduleFun.vo.ModuleFun;
import com.solidextend.sys.moduleFun.vo.ModuleFunGroup;

/**
 * 模块Dao
 * @author changxiaoxue
 * @version 2015-1-19 下午16:11
 */
@Mapper
public interface ModuleFunMapper {
	
	/**
	 * 根据功能组编号得到的模块功能参数
	 * @return
	 */
	List<ModuleFun> selectModuleFunListByGroupCode(String funGroupCode);
	
	/**
	 * 得到指定code的模块类型，忽略指定id的
	 * @return
	 */
	List<ModuleFun> selectModuleFunByCode(@Param("id")String id,@Param("code")String code);
	
	/**
	 * 得到指定name的模块类型，忽略指定id的
	 * @return
	 */
	List<ModuleFun> selectModuleFunByName(@Param("id")String id,@Param("name")String name);
	
	/**
	 * 插入一个新功能
	 * @return
	 */
	int insertModuleFun(ModuleFun fun);
	
	/**
	 * 更新一个功能
	 * @return
	 */
	int updateModuleFun(ModuleFun fun);
	
	/**
	 * 删除一个功能根据功能编号
	 * @return
	 */
	int deleteModuleFunByCode(String funCode);
	
	/**
	 * 删除一个功能根据功能组编号
	 * @return
	 */
	int deleteModuleFunByGroupCode(String groupCode);
	
	

    
}