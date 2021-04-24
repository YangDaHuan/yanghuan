package com.solidextend.sys.module.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.module.vo.Module;

/**
 * 模块Dao
 * @author songjunjie
 * @version 2014-1-2 上午11:12:15
 */
@Mapper
public interface ModuleMapper {
	
	/**
	 * 得到所有的模块，不管是否禁用
	 * @return
	 */
	List<Module> getModuleList();
	
	/**
	 * 得到所有的模块或文件夹，不管是否禁用
	 * @return
	 */
	List<Module> getModuleInfoList(@Param("onlyFolder")String onlyFolder);
	
	/**
	 * 根据角色得到所有的模块或文件夹，不查询禁用的
	 * @return
	 */
	List<Module> getModuleInfoListByRole(@Param("onlyFolder")String onlyFolder,@Param("roleId")List<String> roleId);
	
	
	
	/**
	 * 返回给定父模块下面的的所有子模块，不管是否为禁用.如果没有指定父级id将返回
	 * 所有的顶级模块
	 * @param pid
	 * @return
	 */
	List<Module> getModuleByPid(@Param("pid")String pid);
    
    /**
     * 根据ID删除
     * @param id
     * @return
     */
    int deleteModuleById(String id);

    /**
     * 保存模块
     * @param record
     * @return
     */
    int insertModule(Module module);

    /**
     * 根据ID查询出模块信息
     * @param id
     * @return
     */
    Module getModuleById(String id);
    /**
     * 根据ID和角色编号查询出模块信息
     * @param id
     * @return
     */
    Module getModuleByIdAndRole(@Param("moduleId")String moduleId,@Param("roleId")List<String> roleId);
    /**
     * 根据ID更新模块信息
     * @param record
     * @return
     */
    int updateModuleById(Module module);
    
    /**
  	 * 根据得到当前角色可使用的正常模块
  	 * @roleId 角色ID
  	 * @return
  	 */
  	public List<Module> getModuleListForRole(String roleId);
  	
  	/**
  	 * 根据角色得到可以分配的所有模块列表
  	 * @param roleId
  	 * @return
  	 */
  	public List<Module> getAssignModule(String roleId);
  	
  	/**
  	 * 根据角色得到可以使用的所有模块列表
  	 * @param roleId
  	 * @return
  	 */
  	public List<Module> getUseModule(@Param("roleId")String roleId);
  	
  	/**
  	 * 根据角色ID，得到顶级模块
  	 * @param roleId
  	 * @return
  	 */
  	public List<Module> getTopModuleForRole(@Param("roleId")List<String> roleId);
  	
  	/**
  	 * 得到所有的顶级模块
  	 * @return
  	 */
  	public List<Module> getTopModule();
  	
  	/**
  	 * 查询子模块
  	 * @param roleId 角色ID
  	 * @param parentId 上级模块ID
  	 * @return
  	 */
  	public List<Module> getSubModuleForRole(@Param("roleId")List<String> roleId,@Param("parentId")String parentId);

  	/**
  	 * 用户自主设置的快捷模块
  	 * @param id
  	 * @return List<Module>
  	 */
	List<Module> getQuickModulesByUserId(String id);

	/**
	 * 查询该角色拥有的正常模块
	 * @param roleId
	 * @return List<Module>
	 */
	List<Module> getNormalModuleListByRole(@Param("roleId")List<String> roleId);

	/**
	 * 保存用户的快捷模块
	 * @param id
	 * @return int
	 */
	int saveQuickModule(@Param("moduleId")String moduleId, @Param("userId")String userId);

	/**
	 * 删除原有的快捷模块
	 * @param id
	 * @return int
	 */
	int deleteQuickModuleByUserId(String id);
	
	/**
	 * 解除角色和模块关系
	 * @param roleId
	 */
	int deleteRoleModuleByModuleId(String roleId);

	int deleteAdminRoleModuleByModuleId(String roleId);

	/**
	 * 校验模块名称是否存在
	 * @param name
	 * @param id
	 * @return
	 */
	List<Module> selectModuleByName(String name);
	
	/**
	 * 查询出名字否重复的记录。如果指定了id参数，那么排除此id所表示的记录
	 * @param name
	 * @param id
	 * @return
	 */
	List<Module> findNameDuplicate(@Param("moduleName") String name, @Param("moduleId") String id);
	
	/**
	 * 查询出编码否重复的记录。如果指定了id参数，那么排除此id所表示的记录
	 * @param name
	 * @param id
	 * @return
	 */
	List<Module> findCodeDuplicate(@Param("moduleCode") String name, @Param("moduleId") String id);
    
}