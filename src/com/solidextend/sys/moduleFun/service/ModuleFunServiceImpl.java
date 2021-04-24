package com.solidextend.sys.moduleFun.service;

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
import com.solidextend.sys.moduleFun.dao.ModuleFunGroupMapper;
import com.solidextend.sys.moduleFun.dao.ModuleFunMapper;
import com.solidextend.sys.moduleFun.vo.ModuleFun;
import com.solidextend.sys.moduleFun.vo.ModuleFunGroup;
import com.solidextend.sys.security.UserDetails;

/**
 * 模块业务实现类
 * @author changxiaoxue
 * @version 2015-1-20 上午11:20:34
 */
@Service
public class ModuleFunServiceImpl implements ModuleFunService {
	@Resource
	private ModuleFunGroupMapper moduleFunGroupMapper; 
	
	@Resource
	private ModuleFunMapper moduleFunMapper; 
	
	@Resource
	private AuthorizeMapper authorizeMapper;
	/**
	 * 得到所有的模块，不管是否禁用
	 * @return
	 */
	public List<ModuleFunGroup> getModuleFunGroupList(){
		return this.moduleFunGroupMapper.selectModuleFunGroupList();
	}
	
	
	/**
	 * 得到所有的模块类型的code和name，不要禁用和公共的
	 * @return
	 */
	public List<ModuleFunGroup> selectModuleFunGroupOptions(){
		return this.moduleFunGroupMapper.selectModuleFunGroupOptions();
	}
	
	/**
	 * 根据组编号得到所有的模块功能组
	 * @return
	 */
	public List<ModuleFunGroup> selectModuleFunGroupByCode(String id,String code){
		return this.moduleFunGroupMapper.selectModuleFunGroupByCode(id, code);
	}
	
	/**
	 * 根据组名称得到所有忽略该id的模块功能组
	 * @return
	 */
	public List<ModuleFunGroup> selectModuleFunGroupByName(String id,String name){
		return this.moduleFunGroupMapper.selectModuleFunGroupByName(id, name);
	}
	
	/**
	 * 保存模块功能组
	 * @return
	 */
	public int saveFunGroup(ModuleFunGroup funGroup){
		String id = Identities.uuid();
		funGroup.setId(id);
		return this.moduleFunGroupMapper.insertModuleFunGroup(funGroup);
	}
	
	
	/**
	 * 更新模块功能组
	 * @return
	 */
	public int updateModuleFunGroup(ModuleFunGroup funGroup){
		return this.moduleFunGroupMapper.updateModuleFunGroup(funGroup);
	}
	
	
	/**
	 * 根据组编号得到所有的模块功能参数
	 * @return
	 */
	public List<ModuleFun> getModuleFunListByGroupCode(String funGroupCode){
		List<ModuleFun> modulFunList = this.moduleFunMapper.selectModuleFunListByGroupCode(funGroupCode);
		return modulFunList;
	}
	
	
	/**
	 * 根据组编号得到所有的模块功能组
	 * @return
	 */
	public List<ModuleFun> selectModuleFunByCode(String id,String code){
		return this.moduleFunMapper.selectModuleFunByCode(id, code);
	}
	
	/**
	 * 根据组名称得到所有忽略该id的模块功能组
	 * @return
	 */
	public List<ModuleFun> selectModuleFunByName(String id,String name){
		return this.moduleFunMapper.selectModuleFunByName(id, name);
	}
	
	/**
	 * 保存模块功能组
	 * @return
	 */
	public int saveModuleFun(ModuleFun fun){
		String id = Identities.uuid();
		fun.setId(id);
		return this.moduleFunMapper.insertModuleFun(fun);
	}
	
	
	/**
	 * 更新模块功能组
	 * @return
	 */
	public int updateModuleFun(ModuleFun fun){
		return this.moduleFunMapper.updateModuleFun(fun);
	}
	
	/**
	 * 删除一个功能根据功能编号
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int deleteModuleFunByCode(String funCode){
		this.authorizeMapper.deleteFun(funCode);
		this.moduleFunMapper.deleteModuleFunByCode(funCode);
		return 1;
	}
	
	/**
	 * 删除一个功能组根据功能组编号
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int deleteModuleFunGroupByCode(String groupCode){
		this.authorizeMapper.deleteFunByGroup(groupCode);
		this.moduleFunMapper.deleteModuleFunByGroupCode(groupCode);
		this.moduleFunGroupMapper.deleteModuleFunGroupByCode(groupCode);
		return 1;
		
	}
}
