
package com.solidextend.sys.subway.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxCardinalWeb;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizStationFluxCardinalWebMapper{   
    /**
     * 根据主键查询
     */
    public BizStationFluxCardinalWeb getBizStationFluxCardinalWebById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxCardinalWeb> findAllBizStationFluxCardinalWeb();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxCardinalWeb> findByAttrBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxCardinalWeb(@Param("id")String id);
}

