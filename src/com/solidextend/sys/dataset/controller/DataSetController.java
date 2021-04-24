package com.solidextend.sys.dataset.controller;



import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.dataset.service.DataSetService;
import com.solidextend.sys.dataset.vo.Params;


/**
 * 数据查询
 * @author changxiaoxue
 * @version 2015-2-8 下午3:55:07
 */
@Controller
@RequestMapping("/dataset")
public class DataSetController {
	private static final Log log = LogFactory.getLog(DataSetController.class);
	
	@Resource
	private DataSetService dataSetService;
	
	@RequestMapping("/selectJson")
	@ResponseBody
	public JsonData selectJson(HttpServletRequest req){
		Enumeration pNames=req.getParameterNames();
		String dsId=null;
		Params params=new Params();
		while(pNames.hasMoreElements()){
			String pName=(String) pNames.nextElement();
			String pValue=req.getParameter(pName);
			if("dataSetName".equals(pName)){
				dsId=pValue;
			}else{
				params.put(pName, pValue);
			}
		}
		JsonData jsonData = new JsonData();
		List list=null;
		try {
			list = this.dataSetService.select(dsId,params);
			jsonData.setSuccess(true);
			jsonData.setRows(list);
		} catch (Exception e) {
			log.error("", e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}
	@RequestMapping("/select")
	@ResponseBody
	public List select(HttpServletRequest req){
		Enumeration pNames=req.getParameterNames();
		String dsId=null;
		Params params=new Params();
		while(pNames.hasMoreElements()){
			String pName=(String) pNames.nextElement();
			String pValue=req.getParameter(pName);
			if("dataSetName".equals(pName)){
				dsId=pValue;
			}else{
				params.put(pName, pValue);
			}
		}
		List list=null;
		try {
			list = this.dataSetService.select(dsId,params);
			
		} catch (Exception e) {
			log.error("", e);
		}
		
		return list;
	}
	
	
}
