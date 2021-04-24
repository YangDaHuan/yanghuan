package com.solidextend.sys.sms.service;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.sms.dao.SmsContentMapper;
import com.solidextend.sys.sms.vo.SmsContent;
/**
 * 短信服务类
 * @author 王聚金
 * @Company 江苏振邦智慧城市信息系统有限公司
 * @date 2014-02-12 10:20
 */
@Service
public class SmsContentServiceImpl implements SmsContentService {

	@Resource
	private SmsContentMapper smsContentMapper;
	
	@Override
	public int deleteById(String id) {
		return smsContentMapper.deleteById(id);
	}

	@Override
	public SmsContent getById(String id) {
		return smsContentMapper.getById(id);
	}

	@Override
	public int save(SmsContent smsContent) {
		return smsContentMapper.insert(smsContent);
	}

	@Override
	public JsonData select(PageParam pageParam, SmsContent smsContent) {
		JsonData jsonData = new JsonData();
		String senderName=smsContent.getSenderName();
		if(senderName!=null&!StringUtils.isEmpty(senderName)){
			senderName="%"+senderName+"%";
			smsContent.setSenderName(senderName);
		}
		String smsModuleName=smsContent.getSmsModuleName();
		if(smsModuleName!=null&!StringUtils.isEmpty(smsModuleName)){
			smsModuleName="%"+smsModuleName+"%";
			smsContent.setSmsModuleName(smsModuleName);
		}
		String startTime=smsContent.getStartTime();
		if(startTime!=null&!StringUtils.isEmpty(startTime)){
			startTime=startTime+" 00:00:00";
			smsContent.setStartTime(senderName);
		}
		String endTime=smsContent.getEndTime();
		if(endTime!=null&!StringUtils.isEmpty(endTime)){
			endTime=endTime+" 23:59:59";
			smsContent.setEndTime(endTime);
		}
		jsonData.setTotal(smsContentMapper.count(smsContent));
		jsonData.setRows(smsContentMapper.select(pageParam.getRowBounds(), smsContent));
		return jsonData;
	}

	@Override
	public int updateById(SmsContent smsContent) {
		return smsContentMapper.updateById(smsContent);
	}

}
