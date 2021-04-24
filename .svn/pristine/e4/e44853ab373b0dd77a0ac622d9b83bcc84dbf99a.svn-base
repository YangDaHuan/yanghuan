
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketIn;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketInMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketIn getBizTicketInById(@Param("inId")String inId); 
    
    /**
     * 根据编码查询是否存在该编号的记录
     */
    public Long getCountByCode(@Param("inCode")String inCode); 
    /**
     * 查询出所有记录
     */
    public List<BizTicketIn> findAllBizTicketIn();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketIn> findByAttrBizTicketIn(BizTicketIn bizTicketIn);    
    
    /**
     * 保存
     */
    public int saveBizTicketIn(BizTicketIn bizTicketIn);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketIn(BizTicketIn bizTicketIn);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketIn(@Param("inId")String inId);
    /*
     * 获取最大code
     */
	public String getMaxBizTicketInCode();
}

