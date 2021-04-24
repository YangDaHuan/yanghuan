package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketDeploy;
import com.solidextend.sys.ticket.dao.BizTicketDeployMapper;

/**
 * TODO
 * @author 
 */
public interface BizTicketDeployService{   
    /**
     * 根据主键查询
     */
    public BizTicketDeploy getBizTicketDeployById(String deployId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketDeploy> findAllBizTicketDeploy();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketDeploy> findByAttrBizTicketDeploy(BizTicketDeploy bizTicketDeploy);    
    /**
     * 查询出所有和调配部门相关的记录
     */
    public List<BizTicketDeploy> findByAboutBizTicketDeploy(BizTicketDeploy bizTicketDeploy);    
    
    /**
     * 保存
     */
    public String  saveBizTicketDeploy(BizTicketDeploy bizTicketDeploy,boolean saveDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketDeploy(String[] deployId);
    
    public String getNewBizTicketDeployCode();

	public List<BizTicketDeploy> findByAttrBizTicketDeployAndApply(BizTicketDeploy bizTicketDeploy, Integer auditingState,String groupName);
}

