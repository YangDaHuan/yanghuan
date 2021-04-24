package com.solidextend.sys.role.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.organ.dao.OrganMapper;
import com.solidextend.sys.organ.vo.Organ;
import com.solidextend.sys.role.dao.RoleMapper;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.role.vo.RoleExample;

@Service
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleMapper roleMapper;
	@Resource
	private OrganMapper organMapper;
	@Override
	public int save(Role role) {
		if(StringUtils.isEmpty(role.getId())){
			role.setId(Identities.uuid());
			return roleMapper.insert(role);
		}else{
			return roleMapper.updateByPrimaryKeySelective(role);
		}		
	}
	@Override
	public List<Role> select() {
		RoleExample example = new RoleExample();
		example.setOrderByClause("ROLE_NAME ASC ");		
		return roleMapper.selectByExample(example);		
	}
	@Override
	public int remove(String[] roleId) {
		//首先解除角色和模块关系
		roleMapper.deleteRoleModuleByroleId(roleId);
		roleMapper.deleteAdminRoleModuleByroleId(roleId);
		RoleExample example = new RoleExample();
		example.createCriteria().andIdIn(Arrays.asList(roleId));		
		return roleMapper.deleteByExample(example);
	}	
	@Override
	public JsonData select(String orgId, String roleName) {
		RoleExample example = new RoleExample();
		example.createCriteria().andOrganIdEqualTo(orgId);
		if(roleName!=null&&roleName!=""){
			example.createCriteria().andRoleNameLike(roleName);
		}
		List<Role> list =  roleMapper.selectByExample( example);
		int total = roleMapper.countByExample(example);
		JsonData jsonData = new JsonData();
		jsonData.setTotal(total);
		jsonData.setRows(list);
		return jsonData;
	}
	
	/**
     * 根据用户id得到用户的角色列表
     * @param userId
     * @return
     */
    public List<Role> getRolesByUser(String userId){
    	return this.roleMapper.getRolesByUser(userId);
    }
    
    /**
     * 根据角色id查询角色的基本信息
     * @param roleId
     * @return Role
     */
	@Override
	public Role getRoleById(String roleId) {
		return this.roleMapper.getRoleById(roleId);
	}
	
	/**
	 * 通过机构id查询角色
	 * @param organId
	 * @return List<Role>
	 */
	@Override
	public List<Role> getRolesByOrgId(String organId) {
		Organ org =this.organMapper.getOrganById(organId);
		if("2".equals(org.getOrganType())){
			Organ org2 =this.organMapper.getOrganById(org.getParentId());
			organId = org2.getId();
		}
		RoleExample example = new RoleExample();
		example.setOrderByClause("ROLE_NAME ASC ");		
		example.createCriteria().andOrganIdEqualTo(organId);
		return roleMapper.selectByExample(example);	
	}

	/**
	 * 根据角色名称和密码查询出角色。参数可以不指定。只按照指定的参数查询
	 * @param roleName
	 * @param organId
	 * @return
	 */
	public List<Role> findRoleByNameAndOrganId(@Param("roleName")String roleName, @Param("organId")String organId){
		return this.roleMapper.findRoleByNameAndOrganId(roleName, organId);
	}
	
	@Override
	public JsonData selectPage(String orgId, String roleName) {
		if(roleName!=null&&!StringUtils.isEmpty(roleName)){
			roleName="%"+roleName+"%";
		}
		List<Role> list =  roleMapper.selectRoles(orgId,roleName);
		int total = roleMapper.selectRolesCount(orgId,roleName);
		JsonData jsonData = new JsonData();
		jsonData.setTotal(total);
		jsonData.setRows(list);
		return jsonData;
	}
	
	/**
	 * 根据机构编号查询出机构和角色拼接成树所需的数据。只按照指定的参数查询
	 * @param organId
	 * @return
	 */
	@Override
	public List<Map> findRoleTreeByOrginId(String organId) {
		// TODO Auto-generated method stub
		Organ org=this.organMapper.getOrganById(organId);
		if(org==null)return null;
		String tierCode=org.getTierCode()+"%";
		return this.roleMapper.selectRolesOrganTree(organId, tierCode);
	}
	/**
	 * 根据模块id和功能查询出已授权角色
	 * @param moduleId
	 * @param funs
	 * @return
	 */
	public List<Role> getRoleListByModule(String moduleId,String funForm){
		String[][] funs={};
		if(funForm.indexOf("=")<0){
			return this.roleMapper.getRoleListByModule(moduleId,funs);
		}else{
			String[] funInputs=funForm.split("&");
			funs=new String[funInputs.length][];
			for(int i=0;i<funInputs.length;i++){
				String[] fun=funInputs[i].split("=");
				if(fun.length==2)funs[i]=fun;
			}
			return this.roleMapper.getRoleListByModule(moduleId, funs);
		}
	}
}
