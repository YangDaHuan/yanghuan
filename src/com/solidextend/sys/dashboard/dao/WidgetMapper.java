package com.solidextend.sys.dashboard.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.dashboard.vo.Widget;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface WidgetMapper{   
    
    /**
     * 保存
     */
    public int saveWidget(Widget widget);
    
    /**
     * 根据仪表板主键删除
     */
    public int deleteWidget(@Param("dashboardId")String dashboardId);
}

