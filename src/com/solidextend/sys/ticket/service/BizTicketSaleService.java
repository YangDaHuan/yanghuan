package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketSale;
import com.solidextend.sys.ticket.dao.BizTicketSaleMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketSaleService{   
    /**
     * 根据主键查询
     */
    public BizTicketSale getBizTicketSaleById(); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketSale> findAllBizTicketSale();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketSale> findByAttrBizTicketSale(BizTicketSale bizTicketSale);    
    
    /**
     * 保存
     */
    public int saveBizTicketSale(BizTicketSale bizTicketSale);
    
  
}

