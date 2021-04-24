package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketState;
import com.solidextend.sys.ticket.dao.BizTicketStateMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketStateService{   
    /**
     * 根据主键查询
     */
    public BizTicketState getBizTicketStateById(String ticketStateId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketState> findAllBizTicketState();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketState> findByAttrBizTicketState(BizTicketState bizTicketState);    
    
    /**
     * 保存
     */
    public int saveBizTicketState(BizTicketState bizTicketState);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketState(String[] ticketStateId);
}

