/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2013-11-20     JasperReport参数配置类
 */
package com.solidextend.sys.report.bean;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * JasperReport参数配置类
 * 
 * @author lilin
 * @version [版本号, 2013-11-20]
 */
public class ReportParameter
{
    /**
     * 名称
     */
    private String name;
    
    /**
     * 描述
     */
    private String description;
    
    /**
     * 默认值
     */
    private String defaultValue;
    
    /**
     * 属性map
     */
    private Map<String, String> propertiesMap;
    
    /**
     * 数据json串
     */
    private String jsonStr;
    
    /**
     * 默认构造函数
     */
    public ReportParameter()
    {
        propertiesMap = new HashMap<String, String>();
    }
    
    @Override
    public String toString()
    {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description;
    }
    
    public String getDefaultValue()
    {
        return defaultValue;
    }
    
    public void setDefaultValue(String defaultValue)
    {
        this.defaultValue = defaultValue;
    }
    
    public Map<String, String> getPropertiesMap()
    {
        return propertiesMap;
    }
    
    public void setPropertiesMap(Map<String, String> propertiesMap)
    {
        this.propertiesMap = propertiesMap;
    }

    public String getJsonStr()
    {
        return jsonStr;
    }

    public void setJsonStr(String jsonStr)
    {
        this.jsonStr = jsonStr;
    }
}
