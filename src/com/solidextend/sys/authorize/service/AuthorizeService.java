package com.solidextend.sys.authorize.service;

import com.solidextend.sys.authorize.vo.Authorize;

/**
 * 授权管理
 * @author 王聚金
 * @date 2014-01-06
 */
public interface AuthorizeService {

	/**
	 * 模块授权
	 * @param authorize
	 * @return int
	 */
	public int save(Authorize authorize);
	
	/**
	 * 获取角色模块授权
	 * @param roleId
	 * @return Authorize
	 */
	public Authorize getAuthorize(String roleId);
	
	/**
	 * 模块授权
	 * @param authorize
	 * @return int
	 */
	public int saveModuleAuthorize(Authorize authorize);
	
	 
}
