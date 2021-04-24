package com.solidextend.sys.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.user.vo.PartTimeInfo;
import com.solidextend.sys.user.vo.User;

/**
 * @author songjunjie
 * @version 2013-12-25 下午4:12:15
 */
@Mapper
public interface UserMapper {

	int deleteById(String id);

	int insert(User user);

	User getById(String id);

	int updateById(User user);
	
	/**
	 * 根据登录名得到用户信息
	 * @param loginname
	 * @return
	 */
	User getByLoginname(String loginname);
	
	/**
	 * 查询用户信息。只查询出未删除的
	 * @param rowBounds
	 * @param user
	 * @return
	 */
	List<User> findUser(RowBounds rowBounds,User user);
	Integer findUserCount(User user);
	
	
	/**
	 * 根据机构id查询出机构下面的人员，包括兼职的。
	 * @param organId
	 * @return
	 */
	List<User> findByOrganId(String organId);
	
	/**
	 * 保存兼职信息
	 * @param partTimeInfo
	 * @return
	 */
	int insertPartTime(PartTimeInfo partTimeInfo);
	
	/**
	 * 删除用户兼职信息
	 * @param userId
	 * @return
	 */
	int deletePartTime(@Param("userId") String userId);
	
	/**
	 * 根据机构ID查询出用户，包括兼职的
	 * @param organId
	 * @return
	 */
	List<User> findByOrganAndName(RowBounds  rowBounds, @Param("organId")String organId,@Param("name")String name,@Param("mobile")String mobile);
	Integer findByOrganAndNameCount(@Param("organId")String organId,@Param("name")String name,@Param("mobile")String mobile);

	/**
	 * 删除用户角色
	 * @param id
	 */
	int deleteUserRoles(String id);

	/**
	 * 新建用户和角色关系
	 * @param userId
	 * @param roleId
	 * @return
	 */
	int insertUserRole(@Param("userId") String userId, @Param("roleId") String roleId);

	/**
	 * 根据用户ID，得到用户角色id
	 * @param userId
	 * @return
	 */
	List<String> getUserRoleIdByUserId(String userId);

	int deleteUserById(User user);

	/**
	 * 修改用户密码
	 * @param originPwd
	 * @param password
	 * @return int
	 */
	int updatePassWord(@Param("userId") String userId,@Param("password")  String password);

	/**
	 * 通过角色查询用户
	 * @param roleId
	 * @return List<User>
	 */
	List<User> getUsersByRoleId(String roleId);

	/**
	 * 删除兼职角色
	 * @param userId
	 * @return
	 */
	int deletePartTimeRole(String userId);

	int insertPartTimeRoles(@Param("userId") String id, @Param("roleId") String role, @Param("organId") String organId);

	/**
	 * 通过用户查询兼职机构
	 * @param userId
	 * @return List<PartTimeInfo>
	 */
	List<PartTimeInfo> getPartTimeInfosById(String userId);

	List<PartTimeInfo> getPartTimeInfoRolesById(@Param("userId") String userId, @Param("organId") String organId);

	List<PartTimeInfo> getPartTimeRolesById(String userId);

	List<User> findByOrganAndNameFirst(RowBounds  rowBounds, @Param("tierCode")String tierCode,@Param("name")String name,@Param("mobile")String mobile);

	Integer findByOrganAndNameCountFirst(@Param("tierCode")String tierCode,@Param("name")String name,@Param("mobile")String mobile);

	List<User> findByOrganAndName( @Param("organId")String organId,@Param("name")String name,@Param("mobile")String mobile);

	List<User> findByOrganAndNameFirst(@Param("tierCode")String tierCode,@Param("name")String name,@Param("mobile")String mobile);

	List<User> findUser(User user);
	
}