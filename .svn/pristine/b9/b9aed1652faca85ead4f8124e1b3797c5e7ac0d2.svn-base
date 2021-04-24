
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketApplyDetail;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketApplyDetailMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketApplyDetail getBizTicketApplyDetailById(@Param("applyDetailId")String applyDetailId); 

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
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketApplyDetail(BizTicketApplyDetail bizTicketApplyDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketApplyDetail(@Param("applyDetailId")String applyDetailId);
    /**
     * 根据申请ID删除
     */
    public int deleteBizTicketApplyDetailByApplyId(@Param("applyId")String applyId);
}

