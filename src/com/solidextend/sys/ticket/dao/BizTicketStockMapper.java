
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketStock;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketStockMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketStock getBizTicketStockById(@Param("stockId")String stockId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketStock> findAllBizTicketStock();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketStock> findByAttrBizTicketStock(BizTicketStock bizTicketStock);    
    
    /**
     * 保存
     */
    public int saveBizTicketStock(BizTicketStock bizTicketStock);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketStock(BizTicketStock bizTicketStock);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketStock(@Param("stockId")String stockId);
    
    /**
     * 根据部门，票卡状态，票卡类型，票卡金额查询是否存在记录
     */
    public BizTicketStock bizTicketStock(BizTicketStock bizTicketStock);
}

