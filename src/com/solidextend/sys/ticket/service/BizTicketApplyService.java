package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketApply;
import com.solidextend.sys.ticket.dao.BizTicketApplyMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketApplyService{   
    /**
     * 根据主键查询
     */
    public BizTicketApply getBizTicketApplyById(String applyId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketApply> findAllBizTicketApply();  
    
    /**
     * 查询出所有符合条件的记录
     * @param auditingStateArray 
     * @param toOrgArray 
     * @param applyOrgArray 
     */
    public List<BizTicketApply> findByAttrBizTicketApply(BizTicketApply bizTicketApply, String[] applyOrgArray, String[] toOrgArray, String[] auditingStateArray,String[] auditingOrgArray);    
    /**
     * 查询出所有待审核的记录
     * @param auditingStateArray 
     * @param toOrgArray 
     * @param applyOrgArray 
     */
    public List<BizTicketApply> findByAuditBizTicketApply(String[] applyOrgArray, String[] toOrgArray, String[] auditingStateArray,String[] auditingOrgArray,String groupName);    
    /**
     * 查询出所有已审核的记录
     * @param auditingStateArray 
     * @param toOrgArray 
     * @param applyOrgArray 
     */
    public List<BizTicketApply> findByAuditedBizTicketApply(String[] applyOrgArray, String[] toOrgArray, String[] auditingStateArray,String[] auditingOrgArray);    
    
    /**
     * 保存
     */
    public String saveBizTicketApply(BizTicketApply bizTicketApply,boolean saveDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketApply(String[] applyId);
    
    /*
     * 获取最大的code
     */
    public String getNewBizTicketApplyCode(String type);
    
    public List<BizTicketApply> findByOrgandGroupName(String org,String groupName,int auditingState,int applyType);
}

