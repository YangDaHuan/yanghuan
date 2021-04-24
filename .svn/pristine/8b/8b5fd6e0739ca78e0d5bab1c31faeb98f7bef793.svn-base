package com.solidextend.sys.moduleFun.service;

import java.util.List;





import com.solidextend.sys.moduleFun.vo.ModuleFun;
import com.solidextend.sys.moduleFun.vo.ModuleFunGroup;

/**
 * 模块业务接口
 * @author songjunjie
 * @version 2014-1-2 上午11:20:14
 */
public interface ModuleFunService {
	
	/**
	 * 得到所有的模块功能组，不管是否禁用
	 * @return
	 */
	List<ModuleFunGroup> getModuleFunGroupList();
	/**
	 * 得到所有的模块类型的code和name，不要禁用和公共的
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupOptions();
	
	/**
	 * 根据组编号得到所有忽略该id的模块功能组
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupByCode(String id,String code);
	
	/**
	 * 根据组名称得到所有忽略该id的模块功能组
	 * @return
	 */
	List<ModuleFunGroup> selectModuleFunGroupByName(String id,String name);
	
	/**
	 * 保存模块功能组
	 * @return
	 */
	int saveFunGroup(ModuleFunGroup funGroup);
	
	/**
	 * 更新模块功能组
	 * @return
	 */
	int updateModuleFunGroup(ModuleFunGroup funGroup);
	
	/**
	 * 根据组编号得到所有的模块功能参数
	 * @return
	 */
	List<ModuleFun> getModuleFunListByGroupCode(String funGroupCode);
	
	/**
	 * 根据组编号得到所有忽略该id的模块功能组
	 * @return
	 */
	List<ModuleFun> selectModuleFunByCode(String id,String code);
	
	/**
	 * 根据组名称得到所有忽略该id的模块功能组
	 * @return
	 */
	List<ModuleFun> selectModuleFunByName(String id,String name);
	
	/**
	 * 保存模块功能组
	 * @return
	 */
	int saveModuleFun(ModuleFun fun);
	
	/**
	 * 更新模块功能组
	 * @return
	 */
	int updateModuleFun(ModuleFun fun);
	
	/**
	 * 删除一个功能根据功能编号
	 * @return
	 */
	int deleteModuleFunByCode(String funCode);
	
	/**
	 * 删除一个功能组根据功能组编号
	 * @return
	 */
	int deleteModuleFunGroupByCode(String groupCode);
}
