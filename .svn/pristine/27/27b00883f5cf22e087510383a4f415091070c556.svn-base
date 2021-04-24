
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketState;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketStateMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketState getBizTicketStateById(@Param("ticketStateId")String ticketStateId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketState> findAllBizTicketState();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketState> findByAttrBizTicketState(BizTicketState bizTicketState);    
    
    /**
     * 保存
     */
    public int saveBizTicketState(BizTicketState bizTicketState);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketState(BizTicketState bizTicketState);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketState(@Param("ticketStateId")String ticketStateId);
}

