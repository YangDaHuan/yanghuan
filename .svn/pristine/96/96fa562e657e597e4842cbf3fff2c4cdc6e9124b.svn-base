package com.solidextend.sys.dict.service;

import java.util.List;

import com.solidextend.sys.dict.vo.Dict;
import com.solidextend.sys.dict.vo.DictItem;

/**
 * 字典管理
 * @author 王聚金 songjunjie
 * @date 2013-12-31 09:25
 */
public interface DictService {

	/**
     * 删除字典信息
     * @param id
     * @return int
     */
    public void removeDictById(String id);

    /**
     * 保存字典信息
     * @param record
     * @return int
     */
    public void saveDict(Dict dict);


    /**
     * 得到字典
     * @param id
     * @return
     */
    public Dict getDictById(String id);
    
    /**
     * 根据条件查询。remark不作为条件
     * @param dict
     * @return
     */
    public List<Dict> findDict(Dict dict);

   
    /**
     * 更新字典信息
     * @param record
     * @return int
     */
    public void updateDictById(Dict dict);
    
    
    ////////////////////////////////
    // 字典项相关操作
    ////////////////////////////////
    
    /**
     * 保存数据字典的字典项目
     * @param dictItem
     */
    public void saveDictItem(DictItem dictItem);
    
    
    /**
     * 根据ID得到字典项信息
     * @param id
     * @return
     */
    public DictItem getDictItemById(String id);

	/**
	 * 查询出所有的字典项。不包括删除的.按照排序号正序
	 * 
	 * @return
	 */
	public List<DictItem> findDictItemAll();

	/**
	 * 根据条件查询字典项. itemCode itemName dictId jianpin 可以作为条件。
	 * 其中jianpin是模糊查询，从前面开始匹配。查询结果不包括删除的
	 * 
	 * @param dictItem
	 */
	public List<DictItem> findDictItem(DictItem dictItem);

	/**
	 * 根据字典编码查询出字典下面的所有字典项。不包括删除的
	 * 
	 * @param dictCode
	 * @return
	 */
	public List<DictItem> findDictItemByDictCode(String dictCode);


	/**
	 * 逻辑删除字典项
	 * @param id
	 */
	public void removeDictItemById(String id);
	
	/**
	 * 根据id删除 物理删除
	 * 
	 * @param id
	 * @return
	 */
	public void deleteDictItemById(String id);

	/**
	 * 根据id更新
	 * 
	 * @param dictItem
	 * @return
	 */
	public void updateDictItemById(DictItem dictItem);
}
