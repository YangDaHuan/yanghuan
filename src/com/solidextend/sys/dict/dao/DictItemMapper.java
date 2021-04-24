package com.solidextend.sys.dict.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.dict.vo.DictItem;


/**
 * 字典项管理
 * @author songjunjie
 * @version 2014-1-22 上午10:42:15
 */
@Mapper
public interface DictItemMapper {
	
	public DictItem getById(String id);
	
	/**
	 * 查询出所有的字典项。不包括删除的.按照排序号正序
	 * @return
	 */
	public List<DictItem> findAll();
	
	/**
	 * 根据条件查询字典项. itemCode itemName dictId jianpin 可以作为条件。
	 * 其中jianpin是模糊查询，从前面开始匹配。查询结果不包括删除的
	 * @param dictItem
	 */
	public List<DictItem> find(DictItem dictItem);
	
	/**
	 * 根据字典编码查询出字典下面的所有字典项。不包括删除的
	 * @param dictCode
	 * @return
	 */
	public List<DictItem> findByDictCode(String dictCode);
	
	/**
	 * 找到一个字典下面的所有字典项中最大的排序号.返回空时表示排序号为空,或者没有记录
	 * @param dictId
	 * @return
	 */
	public Integer findMaxOrderNo(String dictId);
	
	/**
	 * 保存字典项信息
	 * @param dictItem
	 * @return
	 */
	public int insert(DictItem dictItem);
	
	/**
	 * 根据id删除
	 * @param id
	 * @return
	 */
	public int deleteById(String id);
	
	/**
	 * 根据id更新
	 * @param dictItem
	 * @return
	 */
	public int updateById(DictItem dictItem);
}