package com.solidextend.sys.log.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.log.vo.LoginLog;

/**
 * 登录日志服务接口
 * @author songjunjie
 * @version 2014-2-17 上午10:40:54
 */
public interface LoginLogService {
	/**
     * 根据ID删除
     * @param id
     * @return
     */
    public void deleteById(String id);
    
    /**
     * 删除登录日志数据
     * @param logIds 日志id集合
     */
    void deleteLog(String... logIds);

    /**
     * 保存登录日志
     * @param loginLog
     * @return
     */
    public void insert(LoginLog loginLog);

    /**
     * 根据ID查询出登录日志
     * @param id
     * @return
     */
    public LoginLog getById(String id);
    
    /**
     * 根据ID更新登录日志信息
     * @param loginLog
     * @return
     */
    public void updateById(LoginLog loginLog);
    
    /**
     * 根据JSESSIONID更新登录日志信息
     * @param loginLog
     * @return
     */
    public void updateByJsessionid(LoginLog loginLog);
    
    /**
     * 分页查询登录日志信息
     * @param rowBounds
     * @param loginLog
     * @return JsonData
     */
    public JsonData searchLog(RowBounds rowBounds, LoginLog loginLog);
    
    public int loginLogCount(LoginLog loginLog);
}
