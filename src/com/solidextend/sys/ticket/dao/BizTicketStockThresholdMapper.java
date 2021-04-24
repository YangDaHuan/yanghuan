
package com.solidextend.sys.ticket.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.ticket.vo.BizTicketStockThreshold;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketStockThresholdMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketStockThreshold getBizTicketStockThresholdById(@Param("stockId")String stockId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketStockThreshold> findAllBizTicketStockThreshold();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketStockThreshold> findByAttrBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);    
    
    /**
     * 
     * 查询是否已存在阀值
     * @return
     */
    public long hasTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);
    /**
     * 保存
     */
    public int saveBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketStockThreshold(@Param("stockId")String stockId);
}

