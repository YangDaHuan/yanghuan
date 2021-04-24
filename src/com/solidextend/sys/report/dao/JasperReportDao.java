/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2013-12-11     报表查询数据库接口
 */
package com.solidextend.sys.report.dao;

import java.sql.Connection;
import java.util.List;

import com.solidextend.sys.report.bean.PropertyOptions;

/**
 * 报表查询数据库接口
 * 
 * @author lilin
 * @version [版本号, 2013-12-11]
 */
public interface JasperReportDao
{
    /**
     * 根据sql查询数据
     *
     * @param sql sql
     * @return 查询结果
     */
    List<PropertyOptions> getResultList(String sql);
    
    /**
     * 活动数据库连接
     *
     * @return connection
     */
    Connection getConnection();
}
