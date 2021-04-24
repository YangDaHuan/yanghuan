package com.solidextend.sys.subway.service;

import java.util.List;
import java.util.Map;

import com.solidextend.sys.subway.vo.BizStationFluxSumm;
import com.solidextend.sys.subway.dao.BizStationFluxSummMapper;

/**
 * TODO
 * @author 
 */
public interface BizStationFluxSummService{   
	
	public List<Map> getStationInfo(BizStationFluxSumm bizStationFluxSumm);   
    /**
     * 根据主键查询
     */
    public BizStationFluxSumm getBizStationFluxSummById(String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxSumm> findAllBizStationFluxSumm();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxSumm> findByAttrBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxSumm(String[] id);
}

