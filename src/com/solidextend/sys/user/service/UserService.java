package com.solidextend.sys.user.service;

import java.util.List;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.user.vo.PartTimeInfo;
import com.solidextend.sys.user.vo.User;

/**
 * 用户信息服务
 * @author songjunjie
 * @version 2013-12-25 下午4:23:53
 */
public interface UserService {
	void deleteUserById(String id);

	void save(User user , List<PartTimeInfo> partTimeList, String roleType);

	User getUserById(String id);

	void updateUserById(User user  , List<PartTimeInfo> partTimeList,String roleType);
	
	/**
	 * 根据登录名得到用户信息（只查询出删除状态为0的及ENABLE=1的。）
	 * @see com.solidextend.sys.user.service.UserService#getUserByLoginname(java.lang.String)
	 */
	User getUserByLoginname(String loginname);
	
	/**
	 * 查询用户信息。只查询出未删除的
	 * @param pageParm 查询条件。密码，启用时间、停用时间、排序号不作为查询条件
	 * @param user 
	 * @return
	 */
	JsonData findUser(PageParam pageParam , User user);
	
	/**
	 * 保存兼职信息
	 * @param partTimeInfo
	 * @return
	 */
	void savePartTime(PartTimeInfo partTimeInfo);
	
	/**
	 * 根据机构ID查询出用户，包括兼职的
	 * @param organId
	 * @return
	 */
	JsonData findUserByOranAndName(PageParam pageParam ,String organId,String name,String tel);

	/**
	 * 根据用户ID，得到用户角色id
	 * @param id
	 * @return String
	 */
	String getUserRolesById(String userId);

	/**
	 * 修改用户密码
	 * @param userId
	 * @param password
	 * @return
	 */
	int savePassWord(String userId, String password);
	
	/**
	 * 通过角色查询用户
	 * @param roleId
	 * @return List<User>
	 */
	List<User> getUsersByRoleId(String roleId);

	/**
	 * 密码初始化
	 * @param userId
	 * @return
	 */
	int initpswById(String userId);
	
	/**
	 * 根据机构id查询出机构下面的人员，包括兼职的。
	 * @param organId
	 * @return
	 * @author songjunjie
	 */
	List<User> findUserByOrganId(String organId);

	/**
	 * 通过用户查询兼职机构
	 * @param userId
	 * @return List<PartTimeInfo>
	 */
	List<PartTimeInfo> getPartTimeInfosById(String userId);
	
	/**
	 * 通过用户查询兼职角色
	 * @param userId
	 * @return List<PartTimeInfo>
	 */
	List<PartTimeInfo> getPartTimeRolesById(String userId);

	JsonData findUserByOranAndNameFirst(PageParam pageParam, String organId,String name, String mobile);

	void updateCurrentUser(User user);
}
