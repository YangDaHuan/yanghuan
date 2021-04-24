package com.solidextend.sys.sms.service;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.sms.vo.SmsContent;


/**
 * 短信内容
 * @author songjunjie
 * @version 2014-2-11 上午11:26:14
 */
public interface SmsContentService {
	
	/**
	 * 根据ID删除短信内容
	 * @param id
	 * @return
	 */
	public int deleteById(String id);

	/**
	 * 保存短信内容
	 * @param smsContent
	 * @return
	 */
	public int save(SmsContent smsContent);

	/**
	 * 根据ID查询出短信内容信息
	 * @param id
	 * @return
	 */
	public SmsContent getById(String id);

	/**
	 * 根据ID更新短信内容
	 * @param smsContent
	 * @return
	 */
	public int updateById(SmsContent smsContent);
		
	/**
	 * 查询短信列表（分页）
	 * @param pageParam
	 * @param smsContent
	 * @return JsonData
	 * @author 王聚金
	 * @date 2014-02-12 10:05
	 */
	public JsonData select(PageParam pageParam, SmsContent smsContent);
}
