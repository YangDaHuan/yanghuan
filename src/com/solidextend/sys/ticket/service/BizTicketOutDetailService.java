package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketOutDetail;
import com.solidextend.sys.ticket.dao.BizTicketOutDetailMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketOutDetailService{   
    /**
     * 根据主键查询
     */
    public BizTicketOutDetail getBizTicketOutDetailById(String outDetailId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketOutDetail> findAllBizTicketOutDetail();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketOutDetail> findByAttrBizTicketOutDetail(BizTicketOutDetail bizTicketOutDetail);    
    
    /**
     * 保存
     */
    public int saveBizTicketOutDetail(BizTicketOutDetail bizTicketOutDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketOutDetail(String[] outDetailId);
}

