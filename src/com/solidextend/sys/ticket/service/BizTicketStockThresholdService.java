package com.solidextend.sys.ticket.service;

import java.util.List;

import com.solidextend.sys.ticket.vo.BizTicketStockThreshold;

/**
 * TODO
 * @author 
 */
public interface BizTicketStockThresholdService{   
    /**
     * 根据主键查询
     */
    public BizTicketStockThreshold getBizTicketStockThresholdById(String stockId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketStockThreshold> findAllBizTicketStockThreshold();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketStockThreshold> findByAttrBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);    
    
    /**
     * 查询阀值是否已设定
     */
    public long hasTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);    
    
    /**
     * 保存
     */
    public int saveBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketStockThreshold(String[] stockId);
}

