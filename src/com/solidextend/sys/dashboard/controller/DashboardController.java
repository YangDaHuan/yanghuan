package com.solidextend.sys.dashboard.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raqsoft.report.model.expression.function.convert.Json;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.dashboard.service.DashboardService;
import com.solidextend.sys.dashboard.vo.Dashboard;
import com.solidextend.sys.dashboard.vo.Widget;
import com.solidextend.sys.quartz.controller.JobController;
import com.solidextend.sys.quartz.vo.JobGroup;
import com.solidextend.sys.security.UserDetails;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {
	private static final Log log = LogFactory.getLog(DashboardController.class);
	@Resource
	private DashboardService dashboardService;
	
	@RequestMapping("/designer")
	public String index(){
		return "dashboard/dashboard";
	}
	@RequestMapping("/show")
	public String show(){
		return "dashboard/showDashboard";
	}
	@RequestMapping("/saveDashboard")
	@ResponseBody
	public JsonData saveDashboard(String jsonStr){
		Dashboard dashboard=new Dashboard();
		JsonData jsonData = new JsonData();
		try {
			JSONObject jsonObject = new JSONObject(jsonStr);
			String id=jsonObject.getString("id");
			if("null".equals(id))id=null;
			dashboard.setId(id);
			dashboard.setName(jsonObject.getString("name"));
			JSONArray jsonArray = jsonObject.getJSONArray("widgets");
			List<Widget> widgets=new ArrayList();
			for(int i=0;i<jsonArray.length();i++){
				Widget widget=new Widget();
				jsonObject=jsonArray.getJSONObject(i);
				widget.setId(jsonObject.getString("id"));
				widget.setName(jsonObject.getString("name"));
				widget.setGroupName(jsonObject.getString("groupName"));
				widget.setSource(jsonObject.getString("source"));
				widget.setType(jsonObject.getString("type"));
				widget.setWidth(jsonObject.getInt("width"));
				widget.setHeight(jsonObject.getInt("height"));
				widget.setDashboardId(id);
				widget.setSort(i);
				widgets.add(widget);
			}
			dashboard.setWidgets(widgets);
			String dashboardId=dashboardService.saveDashboard(dashboard);
			
			jsonData.setSuccess(true);
			jsonData.setExtData(dashboardId);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		
		
		
		return jsonData;
	}
	
	
	@RequestMapping("/getDashboardList")
	@ResponseBody
	public List<Dashboard> getDashboardList(){
		return dashboardService.getDashboardList();
	}
	
	@RequestMapping("/getDashboardById")
	@ResponseBody
	public Dashboard getDashboardById(String id){
		return dashboardService.getDashboardById(id);
	}
	
	@RequestMapping("/deleteDashboard")
	@ResponseBody
	public JsonData deleteDashboard(String id){
		JsonData jsonData = new JsonData();
		try {
			
			dashboardService.deleteDashboard(id);
			
			jsonData.setSuccess(true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		
		
		
		return jsonData;
	}
}
