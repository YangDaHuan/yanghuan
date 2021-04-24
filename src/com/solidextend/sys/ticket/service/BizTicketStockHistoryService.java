package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketStockHistory;
import com.solidextend.sys.ticket.dao.BizTicketStockHistoryMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketStockHistoryService{   
    /**
     * 根据主键查询
     */
    public BizTicketStockHistory getBizTicketStockHistoryById(String stockId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketStockHistory> findAllBizTicketStockHistory();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketStockHistory> findByAttrBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory);    
    
    /**
     * 保存
     */
    public int saveBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketStockHistory(String[] stockId);
}

