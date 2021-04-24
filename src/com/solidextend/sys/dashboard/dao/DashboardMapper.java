package com.solidextend.sys.dashboard.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.dashboard.vo.Dashboard;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface DashboardMapper{   
    /**
     * 根据主键查询
     */
    public Dashboard getDashboardById(@Param("id")String id); 
    
    /**
     * 根据名称和用户查询
     */
    public List<Dashboard> getDashboardByName(@Param("name")String name,@Param("loginName")String loginName); 


    /**
     * 查询出所有记录
     */
    public List<Dashboard> findAllDashboard(@Param("loginName")String loginName);    
    
    /**
     * 保存
     */
    public int saveDashboard(Dashboard dashboard);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateDashboard(Dashboard dashboard);
    
    /**
     * 根据主键删除
     */
    public int deleteDashboard(@Param("id")String id);
}

