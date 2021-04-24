package com.solidextend.sys.ticket.service;

import java.util.List;

import com.solidextend.sys.ticket.vo.BizTicketDeploy;
import com.solidextend.sys.ticket.vo.BizTicketOut;
import com.solidextend.sys.ticket.dao.BizTicketOutMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketOutService{   
    /**
     * 根据主键查询
     */
    public BizTicketOut getBizTicketOutById(String outId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketOut> findAllBizTicketOut();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketOut> findByAttrBizTicketOut(BizTicketOut bizTicketOut);    
    
    /**
     * 保存
     */
    public String saveBizTicketOut(BizTicketOut bizTicketOut,boolean saveDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketOut(String[] outId);
    
    /**
     * 根据code查询出是否存在该code
     * @param code
     * @return
     */
    public Long getCountByCode(String code);
    /*
     * 获取新code
     */
    public String getNewBizTicketOutCode();
}

