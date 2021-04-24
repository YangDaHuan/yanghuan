package com.solidextend.sys.report;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.report.bean.PropertyOptions;
import com.solidextend.sys.report.export.ExportType;
import com.solidextend.sys.report.service.JasperReportService;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;


/**
 * 
 * JasperReport的控制层
 * 
 * @author lilin
 * @version [版本号, 2013-11-18]
 */
@Controller
@Scope(value = "prototype")
public class JasperReportController
{
    /**
     * 注入reportService
     */
    @Autowired
    private JasperReportService reportService;
    
    /**
     * 注入btpModuleService
     */
    @Resource
    private ModuleService btpModuleService;
    
    
    
    /**
     * 显示报表参数页面
     * 
     * @param request request
     * @return String
     */
    @SuppressWarnings({"unchecked"})
    @RequestMapping("/showJasperReport")
    public String showJasperReport(HttpServletRequest request)
    {
        request.setAttribute("paramList", reportService.getPropertyList(request.getParameterMap()));
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH, -1);
        request.setAttribute("curYear", cal.get(Calendar.YEAR));
        request.setAttribute("curMonth", cal.get(Calendar.MONTH));
        request.setAttribute("curDay", cal.get(Calendar.DAY_OF_MONTH));
        
        // 如果是钻取后的报表，则省略查询参数部分，并提供返回按钮
        request.setAttribute("isSub", request.getParameter("reportName").indexOf("sub") != -1);
        
        return "report/showReport";
    }
    
    /**
     * 显示报表页面
     * 
     * @param request request
     * @param session session
     * @return String
     */
    @SuppressWarnings({"deprecation", "unchecked"})
    @RequestMapping("/reportIndex")
    public @ResponseBody
    Map<String, Object> showReport(HttpServletRequest request, HttpSession session)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        
        JasperPrint jsPrint = reportService.getJasperPrint(request.getParameterMap());
        if (jsPrint == null)
        {
            map.put("reportHtml", "");
            return map;
        }
        session.setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jsPrint);
        
        JRHtmlExporter exporter = new JRHtmlExporter();
        StringWriter writer = new StringWriter();
        
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jsPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, writer);
        exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
        
        // 避免图片缓存，加随机数
        String url = "jasper/image?key=" + Math.random() + "&image=";
        exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, url);
        
        try
        {
            exporter.exportReport();
        }
        catch (JRException e)
        {
            throw new RuntimeException(e);
        }
        map.put("reportHtml", writer.toString());
        
        return map;
    }
    
    /**
     * 导出报表
     * 
     * @param request request
     * @param session session
     * @param response response
     * @throws IOException IOException
     */
    @RequestMapping("/exportReport")
    public void exportReport(HttpServletRequest request, HttpSession session, HttpServletResponse response)
        throws IOException
    {
        JasperPrint jsPrint = (JasperPrint)session.getAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE);
        
        ExportType type = ExportType.getExportType(request.getParameter("exportType"));
        JRExporter exporter = reportService.getJRExporter(type);
        
        StringBuilder builder = new StringBuilder();
        builder.append("attachment; filename=\"");
        builder.append(request.getParameter("reportName"));
        builder.append('.');
        builder.append(type.getValue());
        builder.append('"');
        
        response.setContentType("bin");
        response.addHeader("Content-Disposition", builder.toString());
        
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jsPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
        exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
        
        try
        {
            exporter.exportReport();
        }
        catch (JRException e)
        {
            throw new RuntimeException(e);
        }
    }
}
