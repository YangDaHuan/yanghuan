/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2013-11-19
 */
package com.solidextend.sys.report.service.impl;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRReportTemplate;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignExpression;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;


import com.solidextend.core.util.JsonUtil;
import com.solidextend.sys.report.bean.PropertyOptions;
import com.solidextend.sys.report.bean.ReportParameter;
import com.solidextend.sys.report.dao.JasperReportDao;
import com.solidextend.sys.report.export.ExportType;
import com.solidextend.sys.report.service.JasperReportService;

/**
 * JasperReport Sevice层实现类
 * 
 * @author lilin
 * @version [版本号, 2013-11-19]
 */
@Service("jasperReportService")
public class JasperReportServiceImpl implements JasperReportService, ServletContextAware
{
    /**
     * log4j日志
     */
    private static final Logger log = Logger.getLogger(JasperReportServiceImpl.class);
    
    /**
     * 报表目录
     */
    private static final String REPORT_HOME = "../report/jasperReport/";
    
    /**
     * 定义报表图片目录
     */
    private static final String IMAGE_HOME = "../report/jasperReport/images";
    
    /**
     * 报表文件后缀名
     */
    private static final String FILE_SUFFIX = ".jrxml";
    
    /**
     * 报表文件的绝对路径，默认值为相对路径
     */
    private String reportFileHome = "/WEB-INF/report/jasperReport";
    
    
    /**
     * 注入jasperReportDao
     */
    @Resource
    private JasperReportDao jasperReportDao;
    
    /**
     * 初始化报表的Map
     */
    private Map<String, JasperReport> reportMap;
    
    /**
     * 图片路径
     */
    private String imagePath;
    
    /**
     * 标示是否初始化
     */
    private boolean isInit;
    
    /**
     * 初始化jasperReport报表
     * 
     * @throws IOException
     */
    // @PostConstruct
    public synchronized void initReport()
    {
        if (isInit)
        {
            return;
        }
        File reportFileDir;
        // 获得图片存放目录
        org.springframework.core.io.Resource rs = new ClassPathResource(IMAGE_HOME);
        try
        {
            imagePath = rs.getFile().getAbsolutePath() + File.separator;
            // 获得报表存放目录
            rs = new ClassPathResource(REPORT_HOME);
            reportFileDir = rs.getFile();
        }
        catch (IOException e)
        {
            log.error("Load file failed.", e);
            throw new RuntimeException("Load file failed.", e);
        }
        // 定义文件过滤规则
        FileFilter filter = new FileFilter()
        {
            @Override
            public boolean accept(File pathname)
            {
                return pathname.getName().toLowerCase().endsWith(FILE_SUFFIX);
            }
        };
        
        reportMap = new HashMap<String, JasperReport>();
        
        for (File reportFile : reportFileDir.listFiles(filter))
        {
            try
            {
                // JasperReport report = (JasperReport)JRLoader.loadObject(reportFile);
                JasperReport report = getReport(reportFile);
                // 缓存报表
                reportMap.put(report.getName(), report);
            }
            catch (JRException e)
            {
                log.error("Load report failed. The file name is " + reportFile.getName(), e);
                throw new RuntimeException("Load report failed.", e);
            }
            
        }
        
        isInit = true;
    }
    
    /**
     * 开发期为方便报表刷新，每次都从文件读取报表
     * 
     * @param reportName 报表目录
     * @return report
     */
    private JasperReport flushReport(String reportName)
    {
        org.springframework.core.io.Resource rs = new ClassPathResource(REPORT_HOME + reportName + FILE_SUFFIX);
        
        if (!rs.exists())
        {
            log.warn("The jasperreport file does not exist! The reportName is " + reportName);
            return null;
        }
        
        try
        {
            return getReport(rs.getFile());
        }
        catch (IOException e)
        {
            log.error("Load file failed.", e);
            throw new RuntimeException("Load file failed.", e);
        }
        catch (JRException e)
        {
            log.error("Load report failed.", e);
            throw new RuntimeException("Load report failed.", e);
        }
    }
    
    private JasperReport getReport(File reportFile)
        throws JRException
    {
        JasperDesign design = JRXmlLoader.load(reportFile);
        configReport(design);
        
        return JasperCompileManager.compileReport(design);
        
    }
    
    /**
     * 对报表做一些配置
     * 
     * @param design design
     */
    private void configReport(JasperDesign design)
    {
        if (CollectionUtils.isEmpty(design.getTemplatesList()))
        {
            return;
        }
        // 修改样式表的路径
        for (JRReportTemplate tmp : design.getTemplatesList())
        {
            JRDesignExpression exp = (JRDesignExpression)tmp.getSourceExpression();
            // File file = new File(exp.getText().replace("\"", ""));
            
            String text =
                "\"" + reportFileHome + File.separator + exp.getText().substring(exp.getText().lastIndexOf('\\') + 1);
            // file.getName() + "\"";
            text = text.replace("\\", "\\\\");
            
            // 设置为相对路径
            exp.setText(text);
        }
    }
    
    /**
     * 根据报表名获取已加载的报表
     * 
     * @param reportName 报表名
     * @return jasperReport
     */
    @Override
    public JasperReport getReport(String reportName)
    {
        // TODO:开发期用于获取刷新后的报表，正式上线改用以下代码
        return flushReport(reportName);
        // return reportMap.get(reportName);
    }
    
    /**
     * 获得封装后的报表参数集合
     * 
     * @param requestMap 请求参数集合
     * @return list
     */
    @Override
    public List<ReportParameter> getPropertyList(Map<String, String[]> requestMap)
    {
        JasperReport report = getReport(requestMap);
        if (report == null)
        {
            return null;
        }
        
        List<ReportParameter> paramList = new ArrayList<ReportParameter>();
        
        for (JRParameter p : report.getParameters())
        {
            // 忽略系统参数
            if (!p.isSystemDefined())
            {
                ReportParameter param = new ReportParameter();
                param.setName(p.getName());
                param.setDescription(p.getDescription());
                if (p.getDefaultValueExpression() != null)
                {
                    param.setDefaultValue(p.getDefaultValueExpression().getText());
                }
                // 没设置属性则跳过
                if (p.getPropertiesMap() == null)
                {
                    continue;
                }
                
                for (String pName : p.getPropertiesMap().getPropertyNames())
                {
                    param.getPropertiesMap().put(pName, p.getPropertiesMap().getProperty(pName));
                }
                
                // 文本框形式
                if ("text".equals(p.getPropertiesMap().getProperty("type")))
                {
                    
                }
                else
                {
                    // 设置页面需要的参数
                    // 获取查询的内容
                    setQueryContent(param, p.getPropertiesMap().getProperty("query"), requestMap);
                }
                
                paramList.add(param);
            }
        }
        return paramList;
    }
    
    private JasperReport getReport(Map<String, String[]> requestMap)
    {
        if (requestMap.get("reportName") == null || requestMap.get("reportName").length == 0)
        {
            throw new RuntimeException("Parameter reportName is requied");
        }
        String reportName = requestMap.get("reportName")[requestMap.get("reportName").length - 1];
        return getReport(reportName);
    }
    
    private void setQueryContent(ReportParameter param, String queryString, Map<String, String[]> requestMap)
    {
        if (queryString == null)
        {
            return;
        }
        if (requestMap.get("levelCode") == null)
        {
            throw new RuntimeException("Parameter 'levelCode' can not be null!");
        }
        
        // 有其他的扩展先在这里加，以后再重构
        // 其他情况都默认为sql形式
        else
        {
            param.setJsonStr(JsonUtil.writeValueAsString(jasperReportDao.getResultList(queryString)));
        }
    }
    
    
    
    /**
     * 获得Print对象
     * 
     * @param requestMap 请求参数map
     * @return print
     */
    @Override
    public JasperPrint getJasperPrint(Map<String, String[]> requestMap)
    {
        JasperReport report = getReport(requestMap);
        if (report == null)
        {
            return null;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        
        for (JRParameter p : report.getParameters())
        {
            if (!p.isSystemDefined())
            {
                String[] paramValue = requestMap.get(p.getName());
                if (paramValue != null && !StringUtils.isEmpty(paramValue[0]))
                {
                    map.put(p.getName(), paramValue[0]);
                }
            }
        }
        
        // 图片路径
        map.put("imgPath", imagePath);
        
        Connection conn = null;
        try
        {
            conn = jasperReportDao.getConnection();
            return JasperFillManager.fillReport(report, map, conn);
        }
        catch (JRException e)
        {
            log.error("Get JasperPrint failed.", e);
            throw new RuntimeException("Get JasperPrint failed.", e);
        }
        finally
        {
            try
            {
                if (conn != null)
                {
                    // 释放连接
                    conn.close();
                }
            }
            catch (SQLException e)
            {
                log.error("Close conncection failed.", e);
                throw new RuntimeException("Close conncection failed.", e);
            }
        }
    }
    
    /**
     * 根据导出类型，获得导出对象
     * 
     * @param exportType 导出类型
     * @return exporter
     */
    @Override
    public JRExporter getJRExporter(ExportType exportType)
    {
        JRExporter exporter = null;
        if (ExportType.EXCEL == exportType)
        {
            exporter = new JRXlsExporter();
            // exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
        }
        else if (ExportType.PDF == exportType)
        {
            exporter = new JRPdfExporter();
            exporter.setParameter(JRPdfExporterParameter.IS_ENCRYPTED, Boolean.FALSE);
        }
        else if (ExportType.WORD == exportType)
        {
            exporter = new JRRtfExporter();
        }
        else
        {
            exporter = new JRXmlExporter();
        }
        
        return exporter;
    }
    
    /**
     * 获得项目的绝对路径
     * 
     * @param context ServletContext
     */
    @Override
    public void setServletContext(ServletContext context)
    {
        reportFileHome = context.getRealPath(reportFileHome);
    }
    
    
    
    public void setJasperReportDao(JasperReportDao jasperReportDao)
    {
        this.jasperReportDao = jasperReportDao;
    }
}
