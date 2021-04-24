package com.solidextend.sys.authorize.service;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solidextend.sys.authorize.dao.AuthorizeMapper;
import com.solidextend.sys.authorize.vo.Authorize;

@Service
public class AuthorizeServiceImpl implements AuthorizeService {

	@Resource
	private AuthorizeMapper authorizeMapper;
	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int save(Authorize authorize) {		
		authorizeMapper.deleteUse(authorize.getRoleId());
		authorizeMapper.deleteAssign(authorize.getRoleId());
		this.insert(authorize);
		if(!StringUtils.isEmpty(authorize.getAssignModules())){
			String[] assignModules=authorize.getAssignModules().split(",");
			for(String moduleId : assignModules){
				authorizeMapper.insertAssign(authorize.getRoleId(), moduleId);
			}
			
		}	
		return 1;
	}
	private int insert(Authorize authorize){
		if(!StringUtils.isEmpty(authorize.getUseModules())){
			String[] userModules=authorize.getUseModules().split(",");
			String[] funForms=authorize.getFunForms().split(",",-1);
			for(int i=0;i<userModules.length;i++){
				String moduleId=userModules[i];
				//不管有没有功能授权，先将模块授权
				authorizeMapper.insertUse(authorize.getRoleId(), moduleId,null,null);
				String funForm=null;
				if(i<funForms.length){
					funForm=funForms[i];
				}else{
					funForm=null;
				}
				
				//如果有功能授权，循环添加功能授权
				if(funForm!=null&&funForm.indexOf("=")>=0){
					String[] funs=funForm.split("&");
					for(int j=0;j<funs.length;j++){
						String[] fun=funs[j].split("=");
						String funCode=fun[0];
						String funValue=fun[1];
						authorizeMapper.insertUse(authorize.getRoleId(), moduleId,funCode,funValue);
					}
				}
			}
			
		}
		return 1;
	}
	/**
	 * 模块授权
	 * @param authorize
	 * @return int
	 */
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int saveModuleAuthorize(Authorize authorize){
		String useModules=authorize.getUseModules();
		String[] modules=useModules.split(",");
		String funForms=authorize.getFunForms();
		String[] roleIds=authorize.getRoleId().split(",");
		
		for(int i=0;i<roleIds.length;i++){
			Authorize newAuthorize=new Authorize();
			newAuthorize.setRoleId(roleIds[i]);
			newAuthorize.setFunForms(funForms);
			newAuthorize.setUseModules(useModules);
			for(int j=0;j<modules.length;j++){
				this.authorizeMapper.deleteModuleAuthorize(modules[j], roleIds[i]);
			}
			this.insert(newAuthorize);
		}
		return 1;
	}
	@Override
	public Authorize getAuthorize(String roleId) {
		Authorize authorize = new Authorize();
		authorize.setRoleId(roleId);
		authorize.setUseModules(authorizeMapper.selectUse(roleId));
		authorize.setAssignModules(authorizeMapper.selectAssign(roleId));
		return authorize;
	}


}
