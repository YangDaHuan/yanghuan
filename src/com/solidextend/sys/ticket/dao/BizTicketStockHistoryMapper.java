
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketStockHistory;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketStockHistoryMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketStockHistory getBizTicketStockHistoryById(@Param("stockId")String stockId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketStockHistory> findAllBizTicketStockHistory();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketStockHistory> findByAttrBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory);    
    
    /**
     * 保存
     */
    public int saveBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketStockHistory(@Param("stockId")String stockId);
}

