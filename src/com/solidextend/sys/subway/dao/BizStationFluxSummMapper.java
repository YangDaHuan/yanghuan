
package com.solidextend.sys.subway.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import java.util.Map;

import com.solidextend.sys.subway.vo.BizStationFluxSumm;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizStationFluxSummMapper{   
	
	public List<Map> getStationInfo(BizStationFluxSumm bizStationFluxSumm);   
    /**
     * 根据主键查询
     */
    public BizStationFluxSumm getBizStationFluxSummById(@Param("id")String id); 

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
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxSumm(@Param("id")String id);
}

