package com.solidextend.sys.authorize.dao;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;

/**
 * 授权管理	
 * @author 王聚金
 * @date 2013-01-06
 */
@Mapper
public interface AuthorizeMapper {

    /**
     * 可用模块授权
     * @param roleId 角色ID
     * @param modules 模块ID集合
     * @return int
     */
    int insertUse(@Param("roleId") String roleId, @Param("moduleId") String module, @Param("funCode") String funCode, @Param("funValue") String funValue);
    
    /**
     * 可分配模块授权
     * @param roleId 角色ID
     * @param modules 模块ID集合
     * @return int
     */
    int insertAssign(@Param("roleId") String roleId, @Param("moduleId") String module);
    
    /**
     * 删除可用模块授权
     * @param roleId
     * @return int
     */
    int deleteUse(String roleId);
    
    /**
     * 删除可分配模块授权
     * @param roleId
     * @return int
     */
    int deleteAssign(String roleId);
    
    /**
     * 获取可用模块授权
     * @param roleId
     * @return String
     */
    String selectUse(String roleId);
    /**
     * 获取可分配模块授权
     * @param roleId
     * @return String
     */
    String selectAssign(String roleId);
    
    /**
     * 删除分配模块功能授权根据功能编号
     * @param funCode
     * @return String
     */
    int deleteFun(String funCode);
    /**
     * 删除分配模块功能授权根据功能组编号
     * @param groupCode
     * @return String
     */
    int deleteFunByGroup(String groupCode);
    
    int deleteModuleAuthorize(@Param("moduleId")String moduleId,@Param("roleId")String roleId);
}