package com.solidextend.sys.subway.service;

import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxLimitWeb;
import com.solidextend.sys.subway.dao.BizStationFluxLimitWebMapper;

/**
 * TODO
 * @author 
 */
public interface BizStationFluxLimitWebService{   
    /**
     * 根据主键查询
     */
    public BizStationFluxLimitWeb getBizStationFluxLimitWebById(String id); 

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
     * 根据主键删除
     */
    public int deleteBizStationFluxLimitWeb(String[] id);
}

