package com.solidextend.sys.organ.service;

import java.util.List;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.organ.vo.Organ;

/**
 * 机构管理
 * @author 王聚金
 * @date 2013-01-02
 */
public interface OrganService {

	/**
	 * 保存机构信息
	 * @param organ
	 * @return int
	 */
	public int save(Organ organ);	
	
	/**
	 * 查询机构列表
	 * @return List<Organ>
	 */
	public List<Organ> findAllOrgan();
	
		
	/**
	 * 删除机构信息
	 * @param orgId
	 * @return int
	 */
	public int remove(String[] orgId);
	
	
	/**
	 * 获取机构信息
	 * @param code
	 * @param id
	 * @return List<Organ>
	 */
	public List<Organ> selectForCodeById(String code, String id);
	
	/**
	 * 根据机构id查询机构的基本信息
	 * @param orgId
	 * @return Organ
	 */
	public Organ getOrgById(String orgId);

	
	
	/**
	 * 根据id查询出此机构及下面的子机构，不包括部门 。查询结果按照机构层级码正序排列
	 * @param id 机构id
	 * @return
	 */
	public List<Organ> findSubOrgan(String id,String orgType,String orgName);
	/**
	 * 根据id查询出此机构的父机构
	 * @param id 机构id
	 * @return
	 */
	public List<Organ> findParentOrgan(String id);
	/**
	 * 校验机构名称唯一
	 * @param name
	 * @param parentId
	 * @return
	 */
	public List<Organ> selectForName(String name, String parentId);
	public List<Organ> selectForNameById(String name, String parentId,
			String id);

	
	/**
	 * 根据机构编码或名称查询机构列表
	 * @param q
	 * @return
	 */
	public JsonData selectByCodeOrName(String q);

	public void updateTierCode(String rootId);
}
