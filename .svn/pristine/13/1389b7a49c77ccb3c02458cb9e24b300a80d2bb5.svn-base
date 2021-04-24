
package com.solidextend.sys.subway.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxTransfer;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizStationFluxTransferMapper{   
    /**
     * 根据主键查询
     */
    public BizStationFluxTransfer getBizStationFluxTransferById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxTransfer> findAllBizStationFluxTransfer();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxTransfer> findByAttrBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxTransfer(@Param("id")String id);
}

