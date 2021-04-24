/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2013-12-11     报表查询数据库接口实现类
 */
package com.solidextend.sys.report.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.dbcp.BasicDataSource;
import com.alibaba.druid.pool.DruidDataSource;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.solidextend.sys.report.bean.PropertyOptions;
import com.solidextend.sys.report.dao.JasperReportDao;

/**
 * 报表查询数据库接口实现类
 * 
 * @author lilin
 * @version [版本号, 2013-12-11]
 */
@Repository
public class JasperReportDaoImpl implements JasperReportDao
{
    /**
     * log4j日志
     */
    private static final Logger log = Logger.getLogger(JasperReportDaoImpl.class);
    
    /**
     * rowMapper
     */
    private static final RowMapper<PropertyOptions> rowMapper = new RowMapper<PropertyOptions>()
    {
        @Override
        public PropertyOptions mapRow(ResultSet rs, int arg1)
            throws SQLException
        {
            return new PropertyOptions(rs.getString(1), rs.getString(2));
        }
        
    };
    
    /**
     * 注入datasource供后台使用
     */
    @Resource
    private com.alibaba.druid.pool.DruidDataSource dataSource;
    
    /**
     * jdbcTemplate
     */
    @Resource
    private JdbcTemplate jdbcTemplate;
    
    /**
     * 根据sql查询数据
     * 
     * @param sql sql
     * @return 查询结果
     */
    @Override
    public List<PropertyOptions> getResultList(String sql)
    {
        return jdbcTemplate.query(sql, rowMapper);
    }
    
    /**
     * 获得数据库连接
     * 
     * @return Connection
     */
    @Override
    public Connection getConnection()
    {
        try
        {
            return dataSource.getConnection();
        }
        catch (SQLException e)
        {
            log.error("Get conncection failed.", e);
            throw new RuntimeException("Get conncection failed.", e);
        }
    }
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    public void setDataSource(DruidDataSource dataSource)
    {
        this.dataSource = dataSource;
    }
    
}
