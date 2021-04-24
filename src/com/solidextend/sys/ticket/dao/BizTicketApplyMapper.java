
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketApply;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketApplyMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketApply getBizTicketApplyById(@Param("applyId")String applyId); 

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
    public List<BizTicketApply> findByAttrBizTicketApply(@Param("bizTicketApply")BizTicketApply bizTicketApply, @Param("applyOrgArray")String[] applyOrgArray,  @Param("toOrgArray")String[] toOrgArray, @Param("auditingStateArray") String[] auditingStateArray, @Param("auditingOrgArray") String[] auditingOrgArray);    
    /**
     * 查询出所有待审核的记录
     * @param auditingStateArray 
     * @param toOrgArray 
     * @param applyOrgArray 
     */
    public List<BizTicketApply> findByAuditBizTicketApply(@Param("applyOrgArray")String[] applyOrgArray,  @Param("toOrgArray")String[] toOrgArray, @Param("auditingStateArray") String[] auditingStateArray, @Param("auditingOrgArray") String[] auditingOrgArray,@Param("groupName") String groupName);    
    /**
     * 查询出所有已审核的记录
     * @param auditingStateArray 
     * @param toOrgArray 
     * @param applyOrgArray 
     */
    public List<BizTicketApply> findByAuditedBizTicketApply(@Param("applyOrgArray")String[] applyOrgArray,  @Param("toOrgArray")String[] toOrgArray, @Param("auditingStateArray") String[] auditingStateArray, @Param("auditingOrgArray") String[] auditingOrgArray);    
    
    /**
     * 保存
     */
    public int saveBizTicketApply(BizTicketApply bizTicketApply);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketApply(BizTicketApply bizTicketApply);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketApply(@Param("applyId")String applyId);
   
    /*
     * 获取最大的code
     */
	public String getMaxBizTicketApplyCode(@Param("type") String type);

	public List<BizTicketApply> findByOrgandGroupName(@Param("org") String org,@Param("groupName") String groupName,@Param("auditingState") int auditingState,@Param("applyType") int applyType);

	public void updateBizTicketStateApplyByCode(@Param("applyCode") String applyCode, @Param("auditingState") int auditingState);
	
}

