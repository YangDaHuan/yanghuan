package com.solidextend.sys.organ.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.organ.dao.OrganMapper;
import com.solidextend.sys.organ.vo.Organ;
import com.solidextend.sys.security.UserDetails;

@Service
public class OrganServiceImpl implements OrganService {

	@Resource
	private OrganMapper organMapper;
	@Override
	public int save(Organ organ) {
		if(StringUtils.isEmpty(organ.getParentId())){
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			organ.setParentId(userDetails.getOrganId());
		}
		if(StringUtils.isEmpty(organ.getId())){
			organ.setId(Identities.uuid());
			organ.setDeleted("0");
			//生成机构层级码
			organ.setTierCode(getLevelCode(organ.getParentId()));
			return organMapper.saveOrgan(organ);
		}else{
			Organ org = getOrgById(organ.getId());
			if(!org.getParentId().equals(organ.getParentId())||StringUtils.isEmpty(organ.getTierCode())){
				//生成机构层级码
				organ.setTierCode(getLevelCode(organ.getParentId()));
			}
			return organMapper.updateOrgan(organ);
		}		
	}
	public void updateTierCode(String rootId){
		Organ org=this.organMapper.getOrganById(rootId);
		org.setTierCode("1000");
		this.organMapper.updateOrgan(org);
		this.updateChildTierCode(org);
		
		
	}
	private void updateChildTierCode(Organ parent){
		List<Organ> orgs=this.organMapper.findOrganByParentId(parent.getId());
		int i=0;
		for(Organ organ : orgs){
			i++;
			String tierCode = parent.getTierCode();
			if(i<10){
				tierCode+="00"+i;
			}else if(i<100&&i>=10){
				tierCode+="0"+i;
			}else{
				tierCode+=i;
			}
			organ.setTierCode(tierCode);
			this.organMapper.updateOrgan(organ);
			this.updateChildTierCode(organ);
		}
		
	}
	private String getLevelCode(String parentId){
		String tierCode = "";
		List<Organ> list = organMapper.findOrganByParentId(parentId);
		if(parentId.equals("0")){
			if(list.size()>0){
				//取最大编码加一
				tierCode = String.valueOf(Integer.parseInt(list.get(0).getTierCode())+1);
			}else{
				tierCode = "1000";
			}
		}else{
			if(list.size()>0){
				//取最大编码加一
				tierCode = String.valueOf(Long.parseLong(list.get(0).getTierCode())+1);
			}else{
				Organ org = getOrgById(parentId);
				tierCode = org.getTierCode()+"001";
			}
		}
		return tierCode;
	}
	
	
	/**
	 * 根据机构id查询机构的基本信息
	 * @param orgId
	 * @return Organ
	 */
	@Override
	public Organ getOrgById(String orgId) {
		return this.organMapper.getOrganById(orgId);
	}
	

	/**
	 * 根据id查询出此机构及下面的子机构，不包括部门 。查询结果按照机构层级码正序排列
	 * @param id 机构id
	 * @return
	 */
	public List<Organ> findSubOrgan(String id,String orgType,String orgName){
		Organ org=this.organMapper.getOrganById(id);
		if(org==null)return null;
		String tierCode=org.getTierCode()+"%";
		return this.organMapper.findSubOrgan(tierCode,orgType,orgName);
	}
	
	/**
	 * 校验机构名称唯一
	 * @param name
	 * @param parentId
	 * @return
	 */
	@Override
	public List<Organ> selectForName(String name, String parentId) {
		return this.organMapper.selectForName(name,parentId);
	}
	@Override
	public List<Organ> selectForNameById(String name, String parentId, String id) {
		return this.organMapper.selectForNameById(name,parentId,id);
	}

	@Override
	public List<Organ> findAllOrgan() {
		// TODO Auto-generated method stub
		return this.organMapper.findAllOrgan();
	}

	@Override
	public int remove(String[] orgId) {
		// TODO Auto-generated method stub
		for(int i=0;i<orgId.length;i++){
			Organ organ=new Organ();
			organ.setId(orgId[i]);
			organ.setDeleted("1");
			this.organMapper.updateOrgan(organ);
		}
		return 1;
	}

	@Override
	public List<Organ> selectForCodeById(String organCode, String id) {
		// TODO Auto-generated method stub
		return this.organMapper.selectForCodeById(organCode, id);
	}

	@Override
	public JsonData selectByCodeOrName(String q) {
		// TODO Auto-generated method stub
		JsonData jsonData = new JsonData();
		String newQ=null;
		if(q!=null&q!=""){
			newQ=q+"%";
		}
		List<Organ> list = organMapper.selectByCodeOrName(newQ);
		int total =list.size();
		jsonData.setTotal(total);
		jsonData.setRows(list);
		return jsonData;
	}

	@Override
	public List<Organ> findParentOrgan(String id) {
		// TODO Auto-generated method stub
		List<Organ> list=new ArrayList();
		Organ org=organMapper.getOrganById(id);
		list.add(org);
		if(org!=null){
			String pid=org.getParentId();
			findParentOrgan(pid,list);
		}
		return list;
	}
	
	public void findParentOrgan(String pid,List<Organ> list){
		if(pid!=null&&pid.length()>0){
			Organ org=organMapper.getOrganById(pid);
			if(org!=null){
				list.add(org);
				findParentOrgan(org.getParentId(),list);
			}else{
				return;
			}
		}else{
			return;
		}
	}
	

}
