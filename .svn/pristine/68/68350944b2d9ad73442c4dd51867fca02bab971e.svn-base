/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2012-11-22     审计日志Mapper
 */
package com.solidextend.sys.log.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.log.vo.AuditLogInfo;
import com.solidextend.sys.log.vo.AuditLogInfoExt;

/**
 * 审计日志Mapper
 *
 * @author lilin
 * @version [版本号, 2012-11-22]
 */
@Mapper
public interface AuditLogMapper
{
    /**
     * 保存审计日志主表
     * @param auditLogInfo 审计日志对象
     */
    void saveLog(AuditLogInfo auditLogInfo);

    /**
     * 保存审计日志从表
     * @param auditLogInfoExt 审计日志从表对象
     */
    void saveLogExt(AuditLogInfoExt auditLogInfoExt);

    /**
     * 删除审计日志主表数据
     * @param logId 日志id
     */
    void deleteLogById(String logId);

    /**
     * 删除审计日志从表数据
     * @param logId 日志id
     */
    void deleteLogExt(String logId);

    /**
     * 根据日志id查询某条日志的详细信息
     * @param logId 日志id
     * @return 日志信息
     */
    AuditLogInfo findLogById(String logId);

    /**
     * 分页查询审计日志信息
     *
     * @param rowBounds 分页对象
     * @param auditLogInfo 查询条件
     * @return list
     */
    List<AuditLogInfo> searchLog(RowBounds rowBounds, AuditLogInfo auditLogInfo);

    /**
     * 获得记录总数
     *
     * @param auditLogInfo 查询条件
     * @return count
     */
    int getTotalCount(AuditLogInfo auditLogInfo);
}
