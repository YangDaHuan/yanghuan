package com.solidextend.sys.dict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.util.ChineseToPinYin;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.dict.service.DictService;
import com.solidextend.sys.dict.vo.Dict;
import com.solidextend.sys.dict.vo.DictItem;


/**
 * 字典管理
 * @author wangjujin songjunie
 * @version 2014-1-16 下午3:55:07
 */
@Controller
@RequestMapping("/dict")
public class DictController {
	private static final Log log = LogFactory.getLog(DictController.class);
	@Resource
	private DictService dictService;
	
	@RequestMapping("/dictIndex")
	public String index(){
		return "dict/dictIndex";
	}
	
	@RequestMapping("/saveDict")
	@ResponseBody
	public JsonData saveDict(Dict dict){
		JsonData jsonData = new JsonData();
		if(StringUtils.isBlank(dict.getParentId())){
			dict.setParentId("0");
		}
		try {
			if(StringUtils.isBlank(dict.getId())){
				this.dictService.saveDict(dict);
				jsonData.setSuccess(true);
			}else{
				//判断是否有字典
				DictItem dictItem = new DictItem();
				dictItem.setDictId(dict.getId());
				List<DictItem> rows = this.dictService.findDictItem(dictItem);
				if(rows!=null&&rows.size()>0){
					jsonData.setMsg("不允许修改已有记录的字典类型");
					jsonData.setSuccess(false);
				}else{
					this.dictService.updateDictById(dict);
					jsonData.setSuccess(true);
				}
			}
			jsonData.setExtData(dict);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	
	@RequestMapping("/removeDict")
	@ResponseBody
	public JsonData removeDict(@RequestParam String id){
		JsonData jsonData = new JsonData();
		try {
			Dict condition = new Dict();
			condition.setParentId(id);
			List<Dict> list = this.dictService.findDict(condition);
			if(list!=null && !list.isEmpty()){
				jsonData.setSuccess(false);
				jsonData.setMsg("不能删除有子类别的字典类别");
				return jsonData;
			}
			
			//删除前校验是否已经存在字典
			DictItem dictItem = new DictItem();
			dictItem.setDictId(id);
			List<DictItem> rows = this.dictService.findDictItem(dictItem);
			if(rows!=null&&rows.size()>0){
				jsonData.setSuccess(false);
				jsonData.setMsg("不允许删除已有记录的字典类型。");
			}else{
				this.dictService.removeDictById(id);
				jsonData.setSuccess(true);
			}
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	@RequestMapping("/getDictByDictId")
	@ResponseBody
	public JsonData getDictByDictId(@RequestParam String id){
		JsonData jsonData = new JsonData();
		try {
			Dict dict = this.dictService.getDictById(id);
			jsonData.setSuccess(true);
			jsonData.setExtData(dict);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	@RequestMapping("/existDictCode")
	@ResponseBody
	public boolean existDictCode(@RequestParam(required=false) String code, @RequestParam(required=false) String id){
		Dict dict = new Dict();
		dict.setDictCode(code);
		List<Dict> list = this.dictService.findDict(dict);
		if(list!=null && !list.isEmpty()){
			return false; 
		}else{
			return true;
		}
	}
	
	/**
	 * 返回所有的字典节点
	 * @param root 如果为true，则增加根节点。
	 * @return
	 */
	@RequestMapping("/dictTree")
	@ResponseBody
	public List<Dict> dictTree(String root){
		List<Dict> tree = new ArrayList<Dict>();
		if(root!=null&&root.equals("true")){
			Dict rootDict = new Dict();
			rootDict.setId("0");
			rootDict.setDictName("字典类型");
			rootDict.setDictCode("");
			rootDict.setDictType("2");
			tree.add(rootDict);
		}
		Dict dict = new Dict();
		List<Dict> list = this.dictService.findDict(dict);
		tree.addAll(list);
		return tree;
	}
	
	/**
	 * 返回字典类别节点(不包括具体字典)
	 * @param root 如果为true，则增加根节点。
	 * @return
	 */
	@RequestMapping("/dictTreeExcludeLeaf")
	@ResponseBody
	public List<Dict> dictTreeExcludeLeaf(String root){
		List<Dict> tree = new ArrayList<Dict>();
		if(root!=null&&root.equals("true")){
			Dict rootDict = new Dict();
			rootDict.setId("0");
			rootDict.setDictName("数据字典");
			rootDict.setDictCode("");
			rootDict.setDictType("2");
			tree.add(rootDict);
		}
		Dict dict = new Dict();
		dict.setDictType("2");
		List<Dict> list = this.dictService.findDict(dict);
		tree.addAll(list);
		return tree;
	}
	
	///////////////////////////////////////////
	
	/**
	 * 保存或者更新字典项。当参数中有id值就执行更新操作，否则保存
	 * @param dictItem
	 * @return
	 */
	@RequestMapping("/saveDictItem")
	@ResponseBody
	public JsonData saveDictItem(DictItem dictItem){
		JsonData jsonData = new JsonData();
		try {
			if(StringUtils.isBlank(dictItem.getId())){
				if(StringUtils.isBlank(dictItem.getJianpin())){
					String[] pinyin = ChineseToPinYin.chineseToShortPinyin(dictItem.getItemName()).split(",");		
					dictItem.setJianpin(pinyin.length>1?pinyin[1]:pinyin[0]);
				}
				this.dictService.saveDictItem(dictItem);
			}else{
				DictItem oldDictItem = this.dictService.getDictItemById(dictItem.getId());
				//如果简拼没有修改.或者没有指定简拼长度，那么重新生成简拼
				if(dictItem.getJianpin().equals(oldDictItem.getJianpin())||dictItem.getJianpin().length()==0){
					String[] pinyin = ChineseToPinYin.chineseToShortPinyin(dictItem.getItemName()).split(",");		
					dictItem.setJianpin(pinyin.length>1?pinyin[1]:pinyin[0]);
				}
				dictItem.setDeleted("0");
				this.dictService.updateDictItemById(dictItem);
			}
			jsonData.setExtData(dictItem);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	/**
	 * 根据字典id得到字典下面的所有字典项
	 * @param pageParam
	 * @param dictId
	 * @return
	 */
	@RequestMapping("/getDictItemByDictId")
	@ResponseBody
	public List<DictItem> getDictItemByDictId(@RequestParam(required=false) String dictId,@RequestParam(required=false) String dictName,@RequestParam(required=false) String dictCode){
		if(StringUtils.isBlank(dictId)){
			return null;
		}
		DictItem dictItem = new DictItem();
		dictItem.setDictId(dictId);
		dictItem.setItemCode(dictCode);
		if(dictName!=null&&dictName!=""){
			dictItem.setItemName(dictName);
		}
		List<DictItem> rows=null;
		try {
			rows = this.dictService.findDictItem(dictItem);
			
		} catch (Exception e) {
			log.error("",e);
		}
		return rows;
	}
	
	/**
	 * 删除字典项
	 * @param id 字典项ID
	 * @return
	 */
	@RequestMapping("/deleteDictItem")
	@ResponseBody
	public JsonData deleteDictItem(String id){
		JsonData jsonData = new JsonData();
		try {
			this.dictService.removeDictItemById(id);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	/**
	 * 检查字典项代码是否重复
	 * @param code
	 * @param dictId
	 * @return
	 */
	@RequestMapping("/existDictItemCode")
	@ResponseBody
	public boolean existDictItemCode(String code,String dictId,String id){
		boolean bool = false;
		DictItem dictItem = new DictItem();
		dictItem.setItemCode(code);
		dictItem.setDictId(dictId);
		List<DictItem> list = this.dictService.findDictItem(dictItem);
		if(id!=null&&id!=""){
			//修改状态
			if(list!=null&&list.size()>0){
				if(id.equals(list.get(0).getId())){
					bool = true;
				}else{
					bool = false;
				}
			}else{
				bool = true;
			}
		}else{
			//新建状态
			if(list!=null&&list.size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}
		return bool;
	}
	
	/**
	 * 更新排序号 
	 * @param ids id列表，按照此列表中的顺序排序。
	 * @return
	 */
	@RequestMapping("/dictItemOrder")
	@ResponseBody
	public JsonData dictItemOrder(String ids){
		JsonData jsonData = new JsonData();
		if(StringUtils.isBlank(ids)){
			jsonData.setSuccess(true);
			return jsonData;
		}
		String[] idArray = ids.split(",");
		try {
			int i=1;
			for(String id : idArray){
				DictItem dictItem = new DictItem();
				dictItem.setId(id);
				dictItem.setOrderNo(i);
				this.dictService.updateDictItemById(dictItem);
				i++;
			}
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	
	@RequestMapping("/isExistDictName")
	@ResponseBody
	public boolean isExistDictName(String dictName){
		Dict dict = new Dict();
		dict.setDictName(dictName);
		List<Dict> list = this.dictService.findDict(dict);
		if(list!=null && !list.isEmpty()){
			return true;
		}
		return false;
	}
	
	/**
	 * 根据字典编码查询出字典下面的所有字典项。不包括删除的
	 * 
	 * @param dictCode
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/findDictItemByDictCode")
	@ResponseBody
	public List findDictItemByDictCode(String dictCode){
		List<DictItem> list = this.dictService.findDictItemByDictCode(dictCode);
		List list2 = new ArrayList();
		for(DictItem item : list){
			Map<String,String> map = new HashMap<String,String>();
			map.put("text", item.getItemName());
			map.put("value", item.getItemCode());
			map.put("id", item.getId());
			list2.add(map);
		}
		return list2;
	}
	/**
	 * 根据字典id查询出字典下面的所有字典项。不包括删除的
	 * 
	 * @param dictId
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/findDictItemByDictId")
	@ResponseBody
	public List findDictItemByDictId(String dictId){
		DictItem dictItem = new DictItem();
		dictItem.setDictId(dictId);
		
			List<DictItem> list = this.dictService.findDictItem(dictItem);
			List list2 = new ArrayList();
			for(DictItem item : list){
				Map<String,String> map = new HashMap<String,String>();
				map.put("text", item.getItemName());
				map.put("value", item.getItemCode());
				map.put("id", item.getId());
				list2.add(map);
			}
		return list2;
	}
}
