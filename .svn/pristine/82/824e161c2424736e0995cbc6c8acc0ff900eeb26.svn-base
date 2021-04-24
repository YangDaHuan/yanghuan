package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketType;
import com.solidextend.sys.ticket.dao.BizTicketTypeMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketTypeService{   
    /**
     * 根据主键查询
     */
    public BizTicketType getBizTicketTypeById(String ticketTypeId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketType> findAllBizTicketType();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketType> findByAttrBizTicketType(BizTicketType bizTicketType);    
    
    /**
     * 保存
     */
    public int saveBizTicketType(BizTicketType bizTicketType);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketType(String[] ticketTypeId);
}

