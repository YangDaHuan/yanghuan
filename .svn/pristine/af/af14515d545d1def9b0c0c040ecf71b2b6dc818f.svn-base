
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketDeployDetail;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketDepolyDetailMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketDeployDetail getBizTicketDepolyDetailById(@Param("depolyDetailId")String depolyDetailId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketDeployDetail> findAllBizTicketDepolyDetail();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketDeployDetail> findByAttrBizTicketDepolyDetail(BizTicketDeployDetail bizTicketDepolyDetail);    
    
    /**
     * 保存
     */
    public int saveBizTicketDepolyDetail(BizTicketDeployDetail bizTicketDepolyDetail);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketDepolyDetail(BizTicketDeployDetail bizTicketDepolyDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketDepolyDetail(@Param("depolyDetailId")String depolyDetailId);
    /**
     * 根据外键删除
     */
    public int deleteBizTicketApplyDetailByDeployId(@Param("depolyId")String depolyId);
}

