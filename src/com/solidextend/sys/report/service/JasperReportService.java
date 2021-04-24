/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2013-11-19     JasperReport Service层
 */
package com.solidextend.sys.report.service;

import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

import com.solidextend.sys.report.bean.ReportParameter;
import com.solidextend.sys.report.export.ExportType;

/**
 * JasperReport Service层
 * 
 * @author lilin
 * @version [版本号, 2013-11-19]
 */
public interface JasperReportService
{
    /**
     * 根据报表名获取已加载的报表
     * 
     * @param reportName 报表名
     * @return jasperReport
     */
    JasperReport getReport(String reportName);
    
    /**
     * 获得Print对象
     * 
     * @param requestMap 请求参数map
     * @return print
     */
    JasperPrint getJasperPrint(Map<String, String[]> requestMap);
    
    /**
     * 获得封装后的报表参数集合
     * 
     * @param requestMap 请求参数集合
     * @return list
     */
    List<ReportParameter> getPropertyList(Map<String, String[]> requestMap);
    
    /**
     * 根据导出类型，获得导出对象
     *
     * @param exportType 导出类型
     * @return exporter
     */
    JRExporter getJRExporter(ExportType exportType);
}
