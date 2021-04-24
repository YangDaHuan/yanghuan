package com.solidextend.sys.organ.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.JsonTree;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.organ.service.OrganService;
import com.solidextend.sys.organ.vo.Organ;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.ticket.vo.BizTicketState;
import com.solidextend.sys.user.service.UserService;
import com.solidextend.sys.user.vo.User;

/**
 * 机构管理
 * @author wangjujin
 * @version 2014-1-6 下午1:49:05
 */
@Controller
@RequestMapping("/organ")
public class OrganController {

	private static final Log log = LogFactory.getLog(OrganController.class);
	
	@Resource
	private OrganService organService;
	@Resource
	private UserService userService;
	
	@RequestMapping("/organIndex")
	public String index(){
		return "organ/organIndex";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(Organ organ){
		JsonData jsonData = new JsonData();
		try {
			organService.save(organ);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	@RequestMapping("/updateTierCode")
	@ResponseBody
	public JsonData updateTierCode(String rootId){
		JsonData jsonData = new JsonData();
		try {
			organService.updateTierCode(rootId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	@RequestMapping("/list")
	@ResponseBody
	public JsonData list( PageParam pageParam,@RequestParam(required=false) String parentId
			,@RequestParam(required=false) String organName){
		
		

		JsonData jsonData = new JsonData();
		List<Organ> list;
		if(StringUtils.isEmpty(parentId)){
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			parentId = userDetails.getOrganId();
			
		}
		list = organService.findSubOrgan(parentId,null, organName);
		jsonData.setTotal(list.size());
		jsonData.setRows(list);
		return jsonData;
	}

	@RequestMapping("/comboList")
	@ResponseBody
	public JsonData comboList(@RequestParam(required=false) String q) {
		JsonData jsonData = new JsonData();
		jsonData = organService.selectByCodeOrName(q);
		return jsonData;
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public JsonData remove(@RequestParam String id){
		String[] ids = id.split(",");
		List<String> listIdsMove = new ArrayList<String>();
		List<String> listIdsNotMove = new ArrayList<String>();
		StringBuilder sb = new StringBuilder();
		for(String orgId : ids){
			List<Organ> list =  organService.findSubOrgan(orgId,null,null);
			List<User> userlist = this.userService.findUserByOrganId(orgId);
			//有子机构或者要删除的机构下面有人员
			if(list.size()>1 ){
				listIdsNotMove.add(orgId);
				Organ organ = this.organService.getOrgById(orgId);
				String name = organ.getOrganName();
				sb.append(name).append("<br/>");
			}else if(userlist.size()>0){
				if(!listIdsNotMove.contains(listIdsNotMove)){
					listIdsNotMove.add(orgId);
					Organ organ = this.organService.getOrgById(orgId);
					String name = organ.getOrganName();
					sb.append(name).append("<br/>");
				}
			}else{
				listIdsMove.add(orgId);
			}
		}
		JsonData jsonData = new JsonData();
		jsonData.setSuccess(true);
		//删除没有下属机构的机构
		if(listIdsMove.size()>0){
			final int size = listIdsMove.size();
			organService.remove((String[])listIdsMove.toArray(new String[size]));
		}
		//有下属机构或者机构下面有人员的不删除，拼装提示信息
		if(listIdsNotMove.size()>0){
			jsonData.setSuccess(false);
			jsonData.setMsg("如下机构存在下属机构或者人员，无法删除！<br/>"+sb.toString());
		}else{
			jsonData.setMsg("机构信息删除成功！\n"+sb.toString());
		}
		
		return jsonData;
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<JsonTree> tree(@RequestParam(required=false) String id){
		List<JsonTree> tree = new ArrayList<JsonTree>();
		if(StringUtils.isEmpty(id)){
			tree.add(new JsonTree("0", "组织机构", "tree-root"));
		}else{
			List<Organ> result = organService.findSubOrgan(id,null,null);
			for(Organ organ : result){				
				tree.add(new JsonTree(organ.getId(), organ.getOrganName().toString()));
			}
		}
		return tree;
	}
	
	
	/**
	 * 得到机构数的json数据。如果指定了机构id（organId），返回此机构下面的所有机构,不包括部门。
	 * @param organId
	 * @return
	 */
	@RequestMapping("/getOrganTree")
	@ResponseBody
	public List<Map<String,String>> getOrganTree(@RequestParam(required=false) String organId,@RequestParam(required=false) String orgType){
		List<Map<String,String>> tree = new ArrayList<Map<String,String>>();
		if(orgType==null||orgType==""){
			orgType="1";
		}
		List<Organ> list = this.organService.findSubOrgan(organId,orgType,null);
		for(Organ organ : list){	
			Map<String,String> node = new HashMap<String,String>();
			node.put("id", organ.getId());
			node.put("text", organ.getOrganName());
			node.put("parentId", organ.getParentId());
			tree.add(node);
		}
		return tree;
	}
	
	/**
	 * 得到用户所在机构及下属机构的json数据。
	 * @param organId
	 * @return
	 */
	@RequestMapping("/getUserOrganTree")
	@ResponseBody
	public List<Map<String,String>> getUserOrganTree(@RequestParam(required=false) String orgType){
		// 得到当前用户信息
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String organId = userDetails.getOrganId();
		List<Map<String,String>> tree = new ArrayList<Map<String,String>>();
		if(orgType==null||orgType==""){
			orgType="1";
		}
		List<Organ> list = this.organService.findSubOrgan(organId,orgType,null);
		for(Organ organ : list){	
			Map<String,String> node = new HashMap<String,String>();
			node.put("id", organ.getId());
			node.put("text", organ.getOrganName());
			node.put("parentId", organ.getParentId());
			node.put("text", organ.getOrganName());
			
			tree.add(node);
		}
		return tree;
	}
	
	/**
	 * 返回简单结构的组织机构数据。
	 * @param root 如果为ture，给树增加一个根节点
	 * @return
	 */
	@RequestMapping("/simpleTree")
	@ResponseBody
	public List<Organ> simpleTree(String root){
		List<Organ> list =  organService.findAllOrgan();
		if(root!=null && root.equals("true")){
			Organ organ = new Organ();
			organ.setId("0");
			organ.setOrganName("组织机构");
//			organ.setParentId(null);
			list.add(organ);
		}
		return list;
	}
	
	@RequestMapping("/check")
	@ResponseBody
	public boolean checkCode(@RequestParam(required=false) String code, @RequestParam(required=false) String id){
		boolean bool = false;
		if(StringUtils.isEmpty(id)){
			if(organService.selectForCodeById(code, null).size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}else{
			if(organService.selectForCodeById(code, id).size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}
		return bool;
	}
	
	@RequestMapping("/checkOrgName")
	@ResponseBody
	public boolean checkOrgName(@RequestParam(required=false) String name, @RequestParam(required=false) String id, @RequestParam(required=false) String parentId){
		boolean bool = false;
		if(parentId==null||parentId==""){
			parentId = "0";
		}
		if(StringUtils.isEmpty(id)){
			if(organService.selectForName(name, parentId).size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}else{
			if(organService.selectForNameById(name, parentId,id).size()>0){
				bool = false;
			}else{
				bool = true;
			}
		}
		return bool;
	}
	
	@RequestMapping("/orgList")
	@ResponseBody
	public List<Organ> list(){
		List<Organ> list = organService.findAllOrgan();
		return list;
	}
	
    @RequestMapping("/findOrgs")
	@ResponseBody
	public JsonData findOrgs(){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<Organ> list = organService.findAllOrgan();
			jsonData.setSuccess(true);
			jsonData.setExtData(list);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
	
	/**
	 * 根据机构id查询机构的基本信息
	 * @param orgId
	 * @return
	 */
	@RequestMapping("/getOrgById")
	@ResponseBody
	public JsonData getOrgById(String orgId){
		JsonData jsonData = new JsonData ();
		try {
			Organ organ = this.organService.getOrgById(orgId);
			jsonData.setExtData(organ);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
}
