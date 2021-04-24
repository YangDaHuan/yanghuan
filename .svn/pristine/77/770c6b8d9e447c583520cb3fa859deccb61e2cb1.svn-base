
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketInDetail;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketInDetailMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketInDetail getBizTicketInDetailById(@Param("inDetailId")String inDetailId); 

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
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketInDetail(BizTicketInDetail bizTicketInDetail);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketInDetail(@Param("inDetailId")String inDetailId);
}

