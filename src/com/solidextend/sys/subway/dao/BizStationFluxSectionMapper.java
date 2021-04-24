
package com.solidextend.sys.subway.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxSection;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizStationFluxSectionMapper{   
    /**
     * 根据主键查询
     */
    public BizStationFluxSection getBizStationFluxSectionById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxSection> findAllBizStationFluxSection();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxSection> findByAttrBizStationFluxSection(BizStationFluxSection bizStationFluxSection);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxSection(BizStationFluxSection bizStationFluxSection);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizStationFluxSection(BizStationFluxSection bizStationFluxSection);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxSection(@Param("id")String id);
}

