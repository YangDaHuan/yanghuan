
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketType;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketTypeMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketType getBizTicketTypeById(@Param("ticketTypeId")String ticketTypeId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketType> findAllBizTicketType();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketType> findByAttrBizTicketType(BizTicketType bizTicketType);    
    
    /**
     * 保存
     */
    public int saveBizTicketType(BizTicketType bizTicketType);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketType(BizTicketType bizTicketType);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketType(@Param("ticketTypeId")String ticketTypeId);
}

