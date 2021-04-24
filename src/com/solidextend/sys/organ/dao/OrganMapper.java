package com.solidextend.sys.organ.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.organ.vo.Organ;

import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface OrganMapper{   
    /**
     * 根据主键查询
     */
    public Organ getOrganById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<Organ> findAllOrgan();    
    
    /**
     * 根据父ID查询出所有记录
     */
    public List<Organ> findOrganByParentId(@Param("parentId")String parentId);
    
    /**
	 * 根据id查询出此机构及下面的子机构，不包括部门 。查询结果按照机构层级码逆序排列
	 * @param id 机构id
	 * @return
	 */
	public List<Organ> findSubOrgan(@Param("tierCode") String tierCode,@Param("organType") String organType,@Param("organName") String organName);
	
	/**
	 * 校验机构名称唯一
	 * @param name
	 * @param parentId
	 * @return
	 */
	List<Organ> selectForName(@Param("name") String name,@Param("parentId") String parentId);
	List<Organ> selectForNameById(@Param("name") String name,@Param("parentId") String parentId, @Param("id") String id);
    
	/**
	 * 校验机构编码唯一
	 * @param organCode
	 * @param id
	 * @return
	 */
	List<Organ> selectForCodeById(@Param("organCode") String organCode, @Param("id") String id);
	
	/**
	 * 根据编码或名称查询机构列表
	 * @param q
	 * @return
	 */
	List<Organ> selectByCodeOrName(@Param("q") String q);

	/**
     * 保存
     */
    public int saveOrgan(Organ organ);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateOrgan(Organ organ);
    
    /**
     * 根据主键删除
     */
    public int deleteOrgan(@Param("id")String id);
}

