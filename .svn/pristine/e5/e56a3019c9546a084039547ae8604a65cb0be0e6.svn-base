package com.solidextend.sys.form.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.form.dao.SysFormItemMapper;
import com.solidextend.sys.form.dao.SysFormMapper;
import com.solidextend.sys.form.vo.SysForm;
import com.solidextend.sys.form.vo.SysFormItem;
import com.solidextend.sys.security.UserDetails;

@Service
public class FormServiceImpl implements FormService {
	@Resource
	private SysFormMapper formMapper;
	@Resource
	private SysFormItemMapper formItemMapper;
	@Override
	public void saveForm(SysForm form) {
		// TODO Auto-generated method stub
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		form.setDesignUser(userDetails.getId());
		form.setDesignOrg(userDetails.getOrganId());
		Date today=new Date();
		form.setUpdateTime(today);
		
		// ID不为空，说明是修改
		if (StringUtils.isNotBlank(form.getFormId())) {
			this.formMapper.updateSysForm(form);
		} else {
			form.setCreateTime(today);
			String id = Identities.uuid();
			form.setFormId(id);
			this.formMapper.saveSysForm(form);
		}
	}

	@Override
	public List<SysForm> getFormList(SysForm form) {
		// TODO Auto-generated method stub
		return this.formMapper.findByAttrSysForm(form);
	}

	@Override
	public int deleteForm(String formId) {
		// TODO Auto-generated method stub
		int r = this.formMapper.deleteSysForm(formId);
		
		if(r>0){
			this.formItemMapper.deleteSysFormItemByFormId(formId);
		}
		return r;
	}

	@Override
	public void saveFormItem(SysFormItem formItem) {
		// TODO Auto-generated method stub
		Date today=new Date();
		formItem.setUpdateTime(today);
		
		// ID不为空，说明是修改
		if (StringUtils.isNotBlank(formItem.getInputId())) {
			this.formItemMapper.updateSysFormItem(formItem);
		} else {
			formItem.setCreateTime(today);
			String id = Identities.uuid();
			formItem.setInputId(id);
			this.formItemMapper.saveSysFormItem(formItem);
		}
	}

	@Override
	public List<SysFormItem> getFormItemList(String disabled,String formId) {
		// TODO Auto-generated method stub
		SysFormItem formItem = new SysFormItem();
		formItem.setFormId(formId);
		formItem.setDisabled(disabled);
		return this.formItemMapper.findByAttrSysFormItem(formItem);
	}

	@Override
	public int deleteFormItem(String formItemId) {
		// TODO Auto-generated method stub
		return this.formItemMapper.deleteSysFormItem(formItemId);
	}

}
