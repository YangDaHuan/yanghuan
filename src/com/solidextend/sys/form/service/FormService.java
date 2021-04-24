package com.solidextend.sys.form.service;

import java.util.List;

import com.solidextend.sys.form.vo.SysForm;
import com.solidextend.sys.form.vo.SysFormItem;

public interface FormService {
 public void saveForm(SysForm form);
 public List<SysForm> getFormList(SysForm form);
 public int deleteForm(String formId);
 
 public void saveFormItem(SysFormItem formItem);
 public List<SysFormItem> getFormItemList(String disable,String formId);
 public int deleteFormItem(String formItemId);
}
