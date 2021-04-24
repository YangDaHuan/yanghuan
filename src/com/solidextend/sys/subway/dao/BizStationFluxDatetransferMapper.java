
package com.solidextend.sys.subway.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxDatetransfer;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizStationFluxDatetransferMapper{   
    /**
     * 根据主键查询
     */
    public BizStationFluxDatetransfer getBizStationFluxDatetransferById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxDatetransfer> findAllBizStationFluxDatetransfer();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxDatetransfer> findByAttrBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxDatetransfer(@Param("id")String id);
}

