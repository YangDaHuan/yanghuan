package com.solidextend.sys.log.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.log.vo.LoginLog;

/**
 * 登录日志DAO
 * @author songjunjie
 * @version 2014-2-17 上午10:34:47
 */
@Mapper 
public interface LoginLogMapper {
    
    /**
     * 根据ID删除
     * @param id
     * @return
     */
    public int deleteById(String id);

    /**
     * 保存登录日志
     * @param loginLog
     * @return
     */
    public int insert(LoginLog loginLog);

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
    public int updateById(LoginLog loginLog);
    
    /**
     * 根据JSESSIONID更新登录日志信息
     * @param loginLog
     * @return
     */
    public int updateByJsessionid(LoginLog loginLog);

    /**
     * 分页查询登录日志信息
     *
     * @param rowBounds 分页对象
     * @param loginLog 查询条件
     * @return List<AuditLogInfo>
     */
    List<LoginLog> searchLog(RowBounds rowBounds, LoginLog loginLog);

    /**
     * 获得记录总数     
     * @param loginLog 查询条件
     * @return int
     */
    int getTotalCount(LoginLog loginLog);
}