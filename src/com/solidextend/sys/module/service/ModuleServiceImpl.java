package com.solidextend.sys.module.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.authorize.dao.AuthorizeMapper;
import com.solidextend.sys.module.dao.ModuleMapper;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.security.UserDetails;

/**
 * 模块业务实现类
 * @author songjunjie
 * @version 2014-1-2 上午11:20:34
 */
@Service("moduleService")
public class ModuleServiceImpl implements ModuleService {
	@Resource
	private ModuleMapper moduleMapper; 
	
	@Resource
	private AuthorizeMapper authorizeMapper;
	/**
	 * 得到所有的模块，不管是否禁用
	 * @return
	 */
	public List<Module> getModuleList(){
		return this.moduleMapper.getModuleList();
	}
	
	/**
	 * 得到所有的模块，不管是否禁用
	 * @return
	 */
	public List<Module> getModuleInfoList(String onlyFolder){
		return this.moduleMapper.getModuleInfoList(onlyFolder);
	}
	
	/**
	 * 根据角色得到所有的模块或文件夹，不查询禁用的
	 * @return
	 */
	public List<Module> getModuleInfoListByRole(String onlyFolder,List<String> roleId){
		return this.moduleMapper.getModuleInfoListByRole(onlyFolder, roleId);
	}
	
	/**
	 * 返回给定父模块下面的的所有子模块，不管是否为禁用.如果没有指定父级id将返回
	 * 所有的顶级模块
	 * @param pid
	 * @return
	 */
	public List<Module> getModuleByPid(String pid){
		return this.moduleMapper.getModuleByPid(pid);
	}
	
	/**
     * 根据ID删除,如果是文件夹就删除下面所有的
     * @param id
     * @return
     */
    public int deleteModuleById(String id){
    	String[] ids = id.split(",");
    	for(String moduleId : ids){
    		deleteModuleFolder(moduleId);
    		
    	}
    	return 1;
    }
    private void deleteModuleFolder(String moduleId){
    	List<Module> list = this.getModuleByPid(moduleId);
    	for(int i=0;i<list.size();i++){
    		String id=list.get(i).getId();
    		deleteModuleFolder(id);
    		
    	}
    	this.moduleMapper.deleteRoleModuleByModuleId(moduleId);
		this.moduleMapper.deleteAdminRoleModuleByModuleId(moduleId);
		this.moduleMapper.deleteModuleById(moduleId);
    }

    /**
     * 保存模块
     * @param record
     * @return
     */
    public int saveModule(Module module){
    	if(StringUtils.isEmpty(module.getId())){
	    	String id = Identities.uuid();
	    	module.setId(id);
    	}
    	if(StringUtils.isBlank(module.getParentId())){
    		module.setParentId("0");
    	}
    	return this.moduleMapper.insertModule(module);
    }

    /**
     * 根据ID查询出模块信息
     * @param id
     * @return
     */
    public Module getModuleById(String id){
    	return this.moduleMapper.getModuleById(id);
    }
    /**
     * 根据ID查询出模块信息
     * @param id
     * @return
     */
    public Module getModuleByIdAndRole(String moduleId,List<String>roleId){
    	
    	return this.moduleMapper.getModuleByIdAndRole(moduleId,roleId);
    }

    /**
     * 根据ID更新模块信息
     * @param record
     * @return
     */
    public int updateModuleById(Module module){
    	updateModuleFolder(module.getId(),module.getDisabled());
    	return this.moduleMapper.updateModuleById(module);
    }
    /**
     * 根据ID更新目录下模块信息
     * @param moduleId
     * @param disabled
     * @return
     */
    private void updateModuleFolder(String moduleId,String disabled){
    	List<Module> list = this.getModuleByPid(moduleId);
    	for(int i=0;i<list.size();i++){
    		Module module=list.get(i);
    		String id=module.getId();
    		updateModuleFolder(id,disabled);
    		module.setDisabled(disabled);
    		this.moduleMapper.updateModuleById(module);
    	}
    }
    
    /**
   	 * 得到当前角色可使用的模块
   	 * @roleId 角色ID
   	 * @return
   	 */
   	public List<Module> getModuleListForRole(String roleId){
   		return this.moduleMapper.getModuleListForRole(roleId);
   	}
   	
   
    /**
     * 获取可分配模块授权ID
     * @param roleId
     * @return
     */
    public String[] getAssignModuleId(String roleId){
    	String moduleId = this.authorizeMapper.selectAssign(roleId);
    	if(StringUtils.isBlank(moduleId)){
    		return null;
    	}
    	return moduleId.split(",");
    }
    
    /**
  	 * 根据角色得到可以分配的所有模块列表
  	 * @param roleId
  	 * @return
  	 */
  	public List<Module> getAssignModule(String roleId){
  		return this.moduleMapper.getAssignModule(roleId);
  	}
  	
    /**
  	 * 根据角色得到可以使用的所有模块列表
  	 * @param roleId
  	 * @return
  	 */
  	public List<Module> getUseModule(String roleId){
  		return this.moduleMapper.getUseModule(roleId);
  	}
  	
  	/**
  	 * 根据角色ID，得到顶级模块.如果没有指定角色ID，返回null
  	 * @param roleId
  	 * @return
  	 */
  	public List<Module> getTopModuleForRole(List<String> roleId){
  		if(roleId==null||roleId.size()==0){
  			return null;
  		}
  		return this.moduleMapper.getTopModuleForRole(roleId);
  	}
  	
  	/**
  	 * 得到所有的顶级模块
  	 * @return
  	 */
  	public List<Module> getTopModule(){
  		return this.moduleMapper.getTopModule();
  	}
  	
  	/**
  	 * 查询子模块,如果没有指定参数，将返回null
  	 * @param roleId 角色ID
  	 * @param parentId 上级模块ID
  	 * @return
  	 */
  	public List<Module> getSubModuleForRole(List<String> roleId, String parentId){
  		if(roleId==null||roleId.size()==0){
  			return null;
  		}
  		if(StringUtils.isBlank(parentId)){
  			return null;
  		}
  		
  		return this.moduleMapper.getSubModuleForRole(roleId, parentId);
  	}

  	/**
  	 * 用户自主设置的快捷模块
  	 * @param id
  	 * @return List<Module>
  	 */
	@Override
	public List<Module> getQuickModulesByUserId(String id) {
		return this.moduleMapper.getQuickModulesByUserId(id);
	}

	/**
	 * 查询该角色拥有的正常模块
	 * @param roleId
	 * @return List<Module>
	 */
	@Override
	public List<Module> getNormalModuleListByRole(List<String> roleId) {
		return this.moduleMapper.getNormalModuleListByRole(roleId);
	}

	/**
	 * 保存用户的快捷模块
	 * @param id
	 * @return int
	 */
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int saveQuickModule(String id) {
		String[] ids = id.split(",");
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		//删除原有的快捷模块
		this.moduleMapper.deleteQuickModuleByUserId(userDetails.getId());
		//重新添加快捷模块
		for(String moduleId : ids){
			if(StringUtils.isBlank(moduleId)){
				continue;
			}
			this.moduleMapper.saveQuickModule(moduleId,userDetails.getId());
		}
		return 1;
	}

	/**
	 * 校验模块名称是否存在
	 * @param name
	 * @param id
	 * @return
	 */
	@Override
	public List<Module> selectModuleByName(String name) {
		return this.moduleMapper.selectModuleByName(name);
	}

	/**
	 * 查询出名字否重复的记录。如果指定了id参数，那么排除此id所表示的记录
	 * @param name
	 * @param id
	 * @return
	 */
	public List<Module> findNameDuplicate( String name, String id){
		return this.moduleMapper.findNameDuplicate(name, id);
	}
	
	/**
	 * 查询出编码否重复的记录。如果指定了id参数，那么排除此id所表示的记录
	 * @param name
	 * @param id
	 * @return
	 */
	public List<Module> findCodeDuplicate(String name,String id){
		return this.moduleMapper.findCodeDuplicate(name, id);
	}
	
	/**
     * 根据逗号分隔的id移动模块到指定节点下并排序
     * @param id
     * @param parentId
     * @return
     */
	@Transactional(rollbackFor=Exception.class)
    public void moveModule(String id,String parentId){
		Module module = new Module();
		String[] idList = id.split(",");
		for(Short i=0;i<idList.length;i++){
			module.setId(idList[i]);
			module.setOrderNo(i);
			if(parentId!=null){
				module.setParentId(parentId);
			}
			this.moduleMapper.updateModuleById(module);
		}
		
    	
    }
}
