package com.solidextend.sys.role.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.role.vo.Role;

/**
 *  角色管理
 * @author 王聚金
 * @date 2013-01-03
 */
public interface RoleService {

	/**
	 * 保存角色信息
	 * @param organ
	 * @return int
	 */
	public int save(Role role);	
	
	/**
	 * 查询角色列表
	 * @return List<Role>
	 */
	public List<Role> select();
	
	/**
	 * 查询角色列表（分页）
	 * @param pageParam
	 * @param orgId
	 * @return JsonData
	 */
	public JsonData select( String orgId, String roleName);
	
	/**
	 * 查询角色列表（分页）
	 * @param pageParam
	 * @param orgId
	 * @return JsonData
	 */
	public JsonData selectPage( String orgId, String roleName);
	
	/**
	 * 删除角色信息
	 * @param roleId
	 * @return int
	 */
	public int remove(String[] roleId);
	
	/**
     * 根据用户id得到用户的角色列表
     * @param userId
     * @return
     */
    public List<Role> getRolesByUser(String userId);

    /**
     * 根据角色id查询角色的基本信息
     * @param roleId
     * @return Role
     */
	public Role getRoleById(String roleId);

	/**
	 * 通过机构id查询角色
	 * @param organId
	 * @return List<Role>
	 */
	public List<Role> getRolesByOrgId(String organId);
	
	/**
	 * 根据角色名称和密码查询出角色。参数可以不指定。只按照指定的参数查询
	 * @param roleName
	 * @param organId
	 * @return
	 */
	public List<Role> findRoleByNameAndOrganId(@Param("roleName")String roleName, @Param("organId")String organId);
	
	/**
	 * 根据机构编号查询出机构和角色拼接成树所需的数据。只按照指定的参数查询
	 * @param organId
	 * @return
	 */
	public List<Map> findRoleTreeByOrginId(String organId);
	/**
	 * 根据模块id和功能查询出已授权角色
	 * @param moduleId
	 * @param funForm
	 * @return
	 */
	public List<Role> getRoleListByModule(String moduleId,String funForm);
	
}
