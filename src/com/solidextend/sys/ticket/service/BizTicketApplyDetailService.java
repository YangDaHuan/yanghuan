package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketApplyDetail;
import com.solidextend.sys.ticket.dao.BizTicketApplyDetailMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketApplyDetailService{   
    /**
     * 根据主键查询
     */
    public BizTicketApplyDetail getBizTicketApplyDetailById(String applyDetailId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketApplyDetail> findAllBizTicketApplyDetail();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketApplyDetail> findByAttrBizTicketApplyDetail(BizTicketApplyDetail bizTicketApplyDetail);    
    
    /**
     * 保存
     */
    public int saveBizTicketApplyDetail(BizTicketApplyDetail bizTicketApplyDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketApplyDetail(String[] applyDetailId);
}

