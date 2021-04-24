package com.solidextend.sys.log.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.excelutils.ExcelException;
import net.sf.excelutils.ExcelUtils;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.log.dao.LoginLogMapper;
import com.solidextend.sys.log.vo.LoginLog;

/**
 * 登录人日志付服类
 * @author songjunjie
 * @version 2014-2-17 上午10:45:56
 */
@Service("loginLogService")
public class LoginLogServiceImpl implements LoginLogService {
	@Resource
	private LoginLogMapper loginLogMapper;
	/**
     * 根据ID删除
     * @param id
     * @return
     */
    public void deleteById(String id){
    	this.loginLogMapper.deleteById(id);
    }

    /**
     * 保存登录日志
     * @param loginLog
     * @return
     */
    public void insert(LoginLog loginLog){
    	String id = Identities.uuid();
    	loginLog.setId(id);
    	this.loginLogMapper.insert(loginLog);
    }

    /**
     * 根据ID查询出登录日志
     * @param id
     * @return
     */
    public LoginLog getById(String id){
    	return this.loginLogMapper.getById(id);
    }
    
    /**
     * 根据ID更新登录日志信息
     * @param loginLog
     * @return
     */
    public void updateById(LoginLog loginLog){
    	this.loginLogMapper.updateById(loginLog);
    }

    /**
     * 分页查询登录日志信息
     * @param rowBounds
     * @param loginLog
     * @return JsonData
     */
	@Override
	public JsonData searchLog(RowBounds rowBounds, LoginLog loginLog) {
		JsonData jsonData = new JsonData();
		String userName=loginLog.getUserName();
		if(userName!=null&&!StringUtils.isEmpty(userName)){
			userName="%"+userName+"%";
			loginLog.setUserName(userName);
		}
		String loginStartTime=loginLog.getLoginStartTime();
		if(loginStartTime!=null&&!StringUtils.isEmpty(loginStartTime)){
			loginStartTime=loginStartTime+" 00:00:00";
			loginLog.setLoginStartTime(loginStartTime);
		}
		String loginEndTime=loginLog.getLoginEndTime();
		if(loginEndTime!=null&&!StringUtils.isEmpty(loginEndTime)){
			loginEndTime=loginEndTime+" 23:59:59";
			loginLog.setLoginEndTime(loginEndTime);
		}
		
		List<LoginLog> loginLogInfoList = loginLogMapper.searchLog(rowBounds,
				loginLog);
		Integer total = loginLogMapper.getTotalCount(loginLog);
		jsonData.setRows(loginLogInfoList);
		jsonData.setTotal(total);
		return jsonData;
	}

	@Override
	public void deleteLog(String... logIds) {
		if (logIds != null) {
			for (String logId : logIds) {
				loginLogMapper.deleteById(logId);
			}
		}
	}

	/**
	 * 根据条件，查询出符合条件的记录总数 
	 * @see com.solidextend.sys.log.service.LoginLogService#loginLogCount(com.solidextend.sys.log.vo.LoginLog)
	 */
	public int loginLogCount(LoginLog loginLog){
		String userName=loginLog.getUserName();
		if(userName!=null&&!StringUtils.isEmpty(userName)){
			userName="%"+userName+"%";
			loginLog.setUserName(userName);
		}
		String loginStartTime=loginLog.getLoginStartTime();
		if(loginStartTime!=null&&!StringUtils.isEmpty(loginStartTime)){
			loginStartTime=loginStartTime+" 00:00:00";
			loginLog.setLoginStartTime(loginStartTime);
		}
		String loginEndTime=loginLog.getLoginEndTime();
		if(loginEndTime!=null&&!StringUtils.isEmpty(loginEndTime)){
			loginEndTime=loginEndTime+" 23:59:59";
			loginLog.setLoginEndTime(loginEndTime);
		}
		
		Integer total = loginLogMapper.getTotalCount(loginLog);
		return total;
	}

	@Override
	public void updateByJsessionid(LoginLog loginLog) {
		// TODO Auto-generated method stub
		this.loginLogMapper.updateByJsessionid(loginLog);
	}
}
