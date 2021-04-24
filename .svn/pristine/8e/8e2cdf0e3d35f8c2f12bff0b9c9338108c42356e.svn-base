
package com.solidextend.sys.subway.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxLimitWeb;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizStationFluxLimitWebMapper{   
    /**
     * 根据主键查询
     */
    public BizStationFluxLimitWeb getBizStationFluxLimitWebById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxLimitWeb> findAllBizStationFluxLimitWeb();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxLimitWeb> findByAttrBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxLimitWeb(@Param("id")String id);
}

