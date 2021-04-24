package com.solidextend.sys.sms.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.sms.service.SmsContentService;
import com.solidextend.sys.sms.vo.SmsContent;

/**
 * 短信管理
 * @author 王聚金
 * @Company 江苏振邦智慧城市有限公司
 * @date 2014-02-12 10:00
 */
@Controller
@RequestMapping("/sms")
public class SmsController {

	@Resource
	private SmsContentService smsContentService;
	
	@RequestMapping("/smsIndex")
	public String index(){
		return "sms/smsIndex";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public JsonData list(PageParam pageParam, SmsContent smsContent){
		return smsContentService.select(pageParam, smsContent);
	}

}
