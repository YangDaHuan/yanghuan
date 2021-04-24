/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2013-11-26     导出类型枚举类
 */
package com.solidextend.sys.report.export;

/**
 * 导出类型枚举类
 * 
 * @author lilin
 * @version [版本号, 2013-11-26]
 */
public enum ExportType
{
    /**
     * 导出EXCEL
     */
    EXCEL("xls"),

    /**
     * 导出WORD
     */
    WORD("doc"),

    /**
     * 导出PDF
     */
    PDF("pdf");
    
    private String value;
    
    /**
     * 默认构造函数
     * 
     * @param value value
     */
    private ExportType(String value)
    {
        this.value = value;
    }
    
    /**
     * 返回Value
     * 
     * @return 返回 value
     */
    public String getValue()
    {
        return value;
    }
    
    /**
     * 根据字符串值范围枚举
     *
     * @param value value
     * @return 枚举
     */
    public static ExportType getExportType(String value)
    {
        if ("xls".equals(value))
        {
            return EXCEL;
        }
        else if ("doc".equals(value))
        {
            return WORD;
        }
        else if ("pdf".equals(value))
        {
            return PDF;
        }
        return null;
    }
}
