package com.solidextend.sys.dict.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.dict.dao.DictItemMapper;
import com.solidextend.sys.dict.dao.DictMapper;
import com.solidextend.sys.dict.vo.Dict;
import com.solidextend.sys.dict.vo.DictItem;

/**
 * 字典管理。对字典、字典类别、字典数据项的相关操作
 * @author songjunjie
 * @version 2014-1-22 上午11:14:25
 */
@Service
public class DictServiceImpl implements DictService {

	@Resource
	private DictMapper dictMapper;
	@Resource
	private DictItemMapper dictItemMapper;

	/**
	 * 删除字典信息(逻辑删除)
	 * 
	 * @param id
	 * @return int
	 */
	public void removeDictById(String id) {
		Dict dict = new Dict();
		dict.setId(id);
		dict.setDeleted("1");
		this.dictMapper.updateById(dict);
	}

	/**
	 * 保存字典信息
	 * 
	 * @param record
	 * @return int
	 */
	public void saveDict(Dict dict) {
		String id = Identities.uuid();
		dict.setId(id);
		dict.setDeleted("0");
		this.dictMapper.insert(dict);
	}

	public Dict getDictById(String id) {
		return this.dictMapper.getById(id);
	}

	/**
	 * 根据条件查询。remark不作为条件
	 * 
	 * @param dict
	 * @return
	 */
	public List<Dict> findDict(Dict dict) {
		return this.dictMapper.findDict(dict);
	}

	/**
	 * 更新字典信息
	 * 
	 * @param record
	 * @return int
	 */
	public void updateDictById(Dict dict) {
		this.dictMapper.updateById(dict);
	}

	// //////////////////////////////
	// 字典项相关操作
	// //////////////////////////////

	/**
	 * 保存数据字典的字典项目
	 * 
	 * @param dictItem
	 */
	public void saveDictItem(DictItem dictItem){
		String id = Identities.uuid();
		dictItem.setId(id);
		Integer maxOrderNo = this.dictItemMapper.findMaxOrderNo(dictItem.getDictId());
		if(maxOrderNo==null){
			maxOrderNo = 0;
		}
		dictItem.setOrderNo(++maxOrderNo);
		this.dictItemMapper.insert(dictItem);
	}

	/**
	 * 根据ID得到字典项信息
	 * 
	 * @param id
	 * @return
	 */
	public DictItem getDictItemById(String id){
		return this.dictItemMapper.getById(id);
	}

	/**
	 * 查询出所有的字典项。不包括删除的.按照排序号正序
	 * 
	 * @return
	 */
	public List<DictItem> findDictItemAll(){
		return this.dictItemMapper.findAll();
	}

	/**
	 * 根据条件查询字典项. itemCode itemName dictId jianpin 可以作为条件。
	 * 其中jianpin是模糊查询，从前面开始匹配。查询结果不包括删除的
	 * 
	 * @param dictItem
	 */
	public List<DictItem> findDictItem(DictItem dictItem){
		String itemName=dictItem.getItemName();
		if(itemName!=null&&!StringUtils.isEmpty(itemName)){
			itemName="%"+itemName+"%";
			dictItem.setItemName(itemName);
		}
		String jianpin=dictItem.getJianpin();
		if(jianpin!=null&&!StringUtils.isEmpty(jianpin)){
			jianpin=jianpin+"%";
			dictItem.setJianpin(jianpin);
		}
		return this.dictItemMapper.find(dictItem);
	}

	/**
	 * 根据字典编码查询出字典下面的所有字典项。不包括删除的
	 * 
	 * @param dictCode
	 * @return
	 */
	public List<DictItem> findDictItemByDictCode(String dictCode){
		return this.dictItemMapper.findByDictCode(dictCode);
	}

	
	/**
	 * 逻辑删除字典项
	 * @param id
	 */
	public void removeDictItemById(String id){
		if(StringUtils.isBlank(id)){
			return;
		}
		DictItem dictItem = new DictItem();
		dictItem.setId(id);
		dictItem.setDeleted("1");
		this.dictItemMapper.updateById(dictItem);
	}
	
	/**
	 * 根据id删除 物理删除
	 * 
	 * @param id
	 * @return
	 */
	public void deleteDictItemById(String id){
		this.dictItemMapper.deleteById(id);
	}

	/**
	 * 根据id更新
	 * 
	 * @param dictItem
	 * @return
	 */
	public void updateDictItemById(DictItem dictItem){
		this.dictItemMapper.updateById(dictItem);
	}

}
