
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketSale;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketSaleMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketSale getBizTicketSaleById(); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketSale> findAllBizTicketSale();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketSale> findByAttrBizTicketSale(BizTicketSale bizTicketSale);    
    
    /**
     * 保存
     */
    public int saveBizTicketSale(BizTicketSale bizTicketSale);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketSale(BizTicketSale bizTicketSale);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketSale();
}

