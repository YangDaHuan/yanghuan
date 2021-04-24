
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketOut;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketOutMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketOut getBizTicketOutById(@Param("outId")String outId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketOut> findAllBizTicketOut();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketOut> findByAttrBizTicketOut(BizTicketOut bizTicketOut);    
    
    /**
     * 保存
     */
    public int saveBizTicketOut(BizTicketOut bizTicketOut);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketOut(BizTicketOut bizTicketOut);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketOut(@Param("outId")String outId);

    /**
     * 根据code 查询code是否存在
     * @param code
     * @return
     */
	public Long getCountByCode(@Param("outCode") String outCode);
	/*
	 * 获取最新code
	 */
	public String getMaxBizTicketOutCode();
}

