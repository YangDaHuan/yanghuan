package com.solidextend.sys.test.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.test.service.TestService;
import com.solidextend.sys.test.vo.RepresentativeInfo;

/**
 * 用户管理
 * @author songjunjie
 * @version 2014-1-6 下午1:45:45
 */
@RequestMapping("/test")
@Controller
public class TestController {
	private static final Log log = LogFactory.getLog(TestController.class);

	@Resource
	private TestService testService; 
	
	
	/**
	 * 返回当前登陆用户信息
	 * @return
	 */
	@RequestMapping("/getRepresentativeInfoList")
	@ResponseBody
	public JsonData getRepresentativeInfoList(RepresentativeInfo obj){
		JsonData jsonData = new JsonData();
		try{
			List<RepresentativeInfo> rows=this.testService.getRepresentativeInfoList(obj);
			jsonData.setSuccess(true);
			jsonData.setRows(rows);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
	}
	/**
	 * 保存党代会代表信息
	 * @return
	 */
	@RequestMapping("/saveRepresentativeInfo")
	@ResponseBody
	public JsonData saveRepresentativeInfo(RepresentativeInfo obj){
		JsonData jsonData = new JsonData();
		try{
			String id=obj.getId();
			if(id==null||id.length()==0){
				id=Identities.uuid();
				obj.setId(id);
				this.testService.saveRepresentativeInfo(obj);
			}else{
				this.testService.updateRepresentativeInfoById(obj);
			}
			jsonData.setSuccess(true);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
	}
	/**
	 * 保存党代会代表信息
	 * @return
	 */
	@RequestMapping("/deleteRepresentativeInfo")
	@ResponseBody
	public JsonData deleteRepresentativeInfo(String id){
		JsonData jsonData = new JsonData();
		try{
			this.testService.deleteRepresentativeInfoById(id);
			jsonData.setSuccess(true);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
	}
	
}