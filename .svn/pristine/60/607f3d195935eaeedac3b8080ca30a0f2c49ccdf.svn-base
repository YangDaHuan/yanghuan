package com.solidextend.sys.user.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.organ.dao.OrganMapper;
import com.solidextend.sys.organ.vo.Organ;
import com.solidextend.sys.user.dao.UserMapper;
import com.solidextend.sys.user.vo.PartTimeInfo;
import com.solidextend.sys.user.vo.User;

/**
 * 用户信息服务
 * @author songjunjie
 * @version 2013-12-25 下午4:25:04
 */
@Service
public class UserServiceImpl implements UserService {
	@Resource
	private UserMapper userMapper;
	@Resource
	private OrganMapper organMapper;
	
	@Transactional
	@Override
	public void deleteUserById(String ids) {
		if(StringUtils.isBlank(ids)){
			return;
		}
		String[] idarry = ids.split(",");
		for(String id : idarry){
			User user = new User();	
			user.setId(id);
			user.setDeleted("1");
			this.userMapper.deleteUserRoles(id);
			this.userMapper.deletePartTimeRole(user.getId());
			this.userMapper.deletePartTime(user.getId());
			this.userMapper.deleteUserById(user);
		}
	}

	/**
	 * 保存用户信息
	 * @see com.solidextend.sys.user.service.UserService#save(com.solidextend.sys.user.vo.User, java.util.List)
	 */
	@Transactional(rollbackFor=Exception.class)
	@Override
	public void save(User user , List<PartTimeInfo> partTimeList, String roleType) {
		String id = Identities.uuid();
		user.setId(id);
		this.userMapper.insert(user);
		//兼职机构
		if(partTimeList!=null){
			//兼职机构
			for(PartTimeInfo partTimeInfo : partTimeList){
				partTimeInfo.setUserId(user.getId());
				this.userMapper.insertPartTime(partTimeInfo);
				if(partTimeInfo.getJzRoles()!=null&&!partTimeInfo.getJzRoles().equals("")){
					String[] roles = partTimeInfo.getJzRoles().split(",");
					for(String role : roles){
						this.userMapper.insertPartTimeRoles(user.getId(),role,partTimeInfo.getOrganId());
					}
				}
			}
		}
		//角色
		if(roleType!=null&&roleType.length()>0){
			String[] roles = roleType.split(",");
			for(String roleId : roles){
				this.userMapper.insertUserRole(id,roleId);
			}
		}
	}

	@Override
	public User getUserById(String id) {
		return this.userMapper.getById(id);
	}

	@Override
	public void updateCurrentUser(User user) {
		this.userMapper.updateById(user);
	}
	
	/**
	 * 更新用户信息
	 * @see com.solidextend.sys.user.service.UserService#updateUserById(com.solidextend.sys.user.vo.User, java.util.List)
	 */
	@Transactional(rollbackFor=Exception.class)
	@Override
	public void updateUserById(User user , List<PartTimeInfo> partTimeList,String roleType) {
		if(StringUtils.isBlank(user.getId())){
			return;
		}
		this.userMapper.updateById(user);
		//兼职机构，先删除，在插入
		this.userMapper.deletePartTimeRole(user.getId());
		this.userMapper.deletePartTime(user.getId());
		if(partTimeList!=null){
			//兼职机构
			for(PartTimeInfo partTimeInfo : partTimeList){
				partTimeInfo.setUserId(user.getId());
				this.userMapper.insertPartTime(partTimeInfo);
				if(partTimeInfo.getJzRoles()!=null&&!partTimeInfo.getJzRoles().equals("")){
					String[] roles = partTimeInfo.getJzRoles().split(",");
					for(String role : roles){
						this.userMapper.insertPartTimeRoles(user.getId(),role,partTimeInfo.getOrganId());
					}
				}
			}
		}
		//角色
		this.userMapper.deleteUserRoles(user.getId());
		if(StringUtils.isNotBlank(roleType)){
			String[] roles = roleType.split(",");
			for(String roleId : roles){
				this.userMapper.insertUserRole(user.getId(),roleId);
			}
		}
	}
	
	/**
	 * 根据登录名得到用户信息（只查询出删除状态为0的及ENABLE=1的。）
	 * @see com.solidextend.sys.user.service.UserService#getUserByLoginname(java.lang.String)
	 */
	public User getUserByLoginname(String loginname){
		return this.userMapper.getByLoginname(loginname);
	}
	
	/**
	 * 查询用户信息。只查询出未删除的
	 * @param pageParm
	 * @param user  查询条件。密码，启用时间、停用时间、排序号不作为查询条件
	 * @return
	 */
	public JsonData findUser(PageParam pageParm , User user){
		String loginName=user.getLoginName();
		String fullName=user.getFullname();
		if(loginName!=null&&StringUtils.isEmpty(loginName)){
			loginName="%"+loginName+"%";
			user.setLoginName(loginName);
		}
		if(fullName!=null&&StringUtils.isEmpty(fullName)){
			fullName="%"+fullName+"%";
			user.setFullname(fullName);
		}
		List<User> list = this.userMapper.findUser(user);
		Integer total = this.userMapper.findUserCount(user);
		JsonData jsonData = new JsonData();
		jsonData.setRows(list);
		jsonData.setTotal(total);
		return jsonData;
	}
	
	/**
	 * 保存兼职信息
	 * @param partTimeInfo
	 * @return
	 */
	public void savePartTime(PartTimeInfo partTimeInfo){
		this.userMapper.insertPartTime(partTimeInfo);
	}
	
	/**
	 * 根据机构ID查询出用户，包括兼职的
	 * @param organId
	 * @return
	 */
	public JsonData findUserByOranAndName(PageParam pageParam ,String organId,String name,String mobile){
		JsonData jsonData = new JsonData();
		if(name!=null&&!StringUtils.isEmpty(name)){
			name="%"+name+"%";
		}
		if(mobile!=null&&!StringUtils.isEmpty(mobile)){
			mobile="%"+mobile+"%";
		}
		List<User> rows = this.userMapper.findByOrganAndName(organId,name,mobile);
		Integer total = this.userMapper.findByOrganAndNameCount(organId,name,mobile);
		jsonData.setTotal(total);
		jsonData.setRows(rows);
		return jsonData;
	}

	/**
	 * 根据用户ID，得到用户角色id
	 * @param id
	 * @return String
	 */
	@Override
	public String getUserRolesById(String userId) {
		String role = "";
		List<String> rows = this.userMapper.getUserRoleIdByUserId(userId);
		if(rows!=null&&rows.size()>0){
			for(String roleId : rows){
				role+=roleId+",";
			}
		}
		if(role.length()>1){
			role = role.substring(0, role.length()-1);
		}
		return role;
	}

	/**
	 * 修改用户密码
	 * @param originPwd
	 * @param password
	 * @return int
	 */
	@Override
	public int savePassWord(String userId, String password) {
		return this.userMapper.updatePassWord(userId,password);
	}

	/**
	 * 通过角色查询用户
	 * @param roleId
	 * @return List<User>
	 */
	@Override
	public List<User> getUsersByRoleId(String roleId) {
		return this.userMapper.getUsersByRoleId(roleId);
	}

	/**
	 * 密码初始化
	 * @param userId
	 * @return
	 */
	@Override
	public int initpswById(String ids) {
		if(StringUtils.isBlank(ids)){
			return 1;
		}
		String[] idarry = ids.split(",");
		String passWord = DigestUtils.md5Hex("000000");
		for(String id : idarry){
			this.userMapper.updatePassWord(id,passWord);
		}
		return 0;
	}
	
	/**
	 * 根据机构id查询出机构下面的人员，包括兼职的。
	 * @param organId
	 * @return
	 * @author songjunjie
	 */
	public List<User> findUserByOrganId(String organId){
		return this.userMapper.findByOrganId(organId);
	}

	/**
	 * 通过用户查询兼职机构
	 * @param userId
	 * @return List<PartTimeInfo>
	 */
	@Override
	public List<PartTimeInfo> getPartTimeInfosById(String userId) {
		List<PartTimeInfo> list = this.userMapper.getPartTimeInfosById(userId);
		if(list!=null&&list.size()>0){
			for(PartTimeInfo obj : list){
				List<PartTimeInfo> list2 = this.userMapper.getPartTimeInfoRolesById(userId,obj.getOrganId());
				String roles = "";
				if(list2!=null&&list2.size()>0){
					for(PartTimeInfo o : list2){
						roles += o.getUserId()+",";
					}
					if(roles.length()>0){
						roles = roles.substring(0, roles.length()-1);
					}
				}
				obj.setJzRoles(roles);
			}
		}
		return list;
	}
	
	/**
	 * 通过用户查询兼职机构
	 * @param userId
	 * @return List<PartTimeInfo>
	 */
	@Override
	public List<PartTimeInfo> getPartTimeRolesById(String userId) {
		List<PartTimeInfo> list = this.userMapper.getPartTimeRolesById(userId);
		return list;
	}

	
	@Override
	public JsonData findUserByOranAndNameFirst(PageParam pageParam,
			String organId, String name, String mobile) {
		JsonData jsonData = new JsonData();
		Organ org=this.organMapper.getOrganById(organId);
		if(org==null)return null;
		String tierCode=org.getTierCode()+"%";
		if(name!=null&&!StringUtils.isEmpty(name)){
			name="%"+name+"%";
		}
		if(mobile!=null&&!StringUtils.isEmpty(mobile)){
			mobile="%"+mobile+"%";
		}
		List<User> rows = this.userMapper.findByOrganAndNameFirst(tierCode,name,mobile);
		Integer total = this.userMapper.findByOrganAndNameCountFirst(tierCode,name,mobile);
		jsonData.setTotal(total);
		jsonData.setRows(rows);
		return jsonData;
	}
	
}
