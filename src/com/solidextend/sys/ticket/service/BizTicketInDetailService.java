package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketInDetail;
import com.solidextend.sys.ticket.dao.BizTicketInDetailMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketInDetailService{   
    /**
     * 根据主键查询
     */
    public BizTicketInDetail getBizTicketInDetailById(String inDetailId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketInDetail> findAllBizTicketInDetail();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketInDetail> findByAttrBizTicketInDetail(BizTicketInDetail bizTicketInDetail);    
    
    /**
     * 保存
     */
    public int saveBizTicketInDetail(BizTicketInDetail bizTicketInDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketInDetail(String[] inDetailId);
}

