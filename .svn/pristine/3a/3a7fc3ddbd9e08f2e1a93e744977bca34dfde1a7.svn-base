package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketIn;
import com.solidextend.sys.ticket.dao.BizTicketInMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketInService{   
    /**
     * 根据主键查询
     */
    public BizTicketIn getBizTicketInById(String inId); 

    /**
     * 根据Code查询,查看是否已存在code
     */
    public Long getCountByCode(String inCode); 
    
    /**
     * 查询出所有记录
     */
    public List<BizTicketIn> findAllBizTicketIn();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketIn> findByAttrBizTicketIn(BizTicketIn bizTicketIn);    
    
    /**
     * 保存
     */
    public String saveBizTicketIn(BizTicketIn bizTicketIn,boolean saveDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketIn(String[] inId);
    /*
     * 获取新code
     */
    public String getNewBizTicketInCode();
}

