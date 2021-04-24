package com.solidextend.sys.dashboard.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.dashboard.dao.DashboardMapper;
import com.solidextend.sys.dashboard.dao.WidgetMapper;
import com.solidextend.sys.dashboard.vo.Dashboard;
import com.solidextend.sys.dashboard.vo.Widget;
import com.solidextend.sys.security.UserDetails;
@Service("dashboardService")
public class DashboardServiceImpl implements DashboardService {

	@Resource
	private DashboardMapper dashboardMapper;
	
	@Resource
	private WidgetMapper widgetMapper;
	
	@Override
	public String saveDashboard(Dashboard dashboard) {
		// TODO Auto-generated method stub
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		dashboard.setLoginName(userDetails.getLoginName());
		String id =dashboard.getId();
		if(id==null||id.length()==0){
			id = Identities.uuid();
			dashboard.setId(id);
			dashboardMapper.saveDashboard(dashboard);
			for(Widget widget : dashboard.getWidgets()){
				widget.setDashboardId(id);
				widgetMapper.saveWidget(widget);
			}
		}else{
			dashboardMapper.updateDashboard(dashboard);
			widgetMapper.deleteWidget(dashboard.getId());
			for(Widget widget : dashboard.getWidgets()){
				widgetMapper.saveWidget(widget);
			}
		}
		return id;
	}

	@Override
	public void deleteDashboard(String id) {
		// TODO Auto-generated method stub
		dashboardMapper.deleteDashboard(id);
		widgetMapper.deleteWidget(id);
		
	}

	@Override
	public List<Dashboard> getDashboardList() {
		// TODO Auto-generated method stub
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		return dashboardMapper.findAllDashboard(userDetails.getLoginName());
		
	}

	@Override
	public Dashboard getDashboardById(String id) {
		// TODO Auto-generated method stub
		return dashboardMapper.getDashboardById(id);
	}

	@Override
	public boolean checkDashboardName(String name) {
		// TODO Auto-generated method stub
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String loginName=userDetails.getLoginName();
		if(dashboardMapper.getDashboardByName(name,loginName).size()>0){
			return false;
		}
		return true;
	}

	

}
