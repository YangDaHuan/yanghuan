
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketOutDetail;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketOutDetailMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketOutDetail getBizTicketOutDetailById(@Param("outDetailId")String outDetailId); 

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
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketOutDetail(BizTicketOutDetail bizTicketOutDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketOutDetail(@Param("outDetailId")String outDetailId);
}

