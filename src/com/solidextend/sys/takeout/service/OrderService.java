package com.solidextend.sys.takeout.service;

import java.util.List;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.takeout.vo.OrderVO;

/**
 * TODO
 * @author 
 */
public interface OrderService{   
    /**
     * 根据主键查询
     */
    public OrderVO getOrderById(String OrderId); 

    /**
     * 查询出所有记录
     */
    public List<OrderVO> findAllOrder();  
    
    /**
     * 查询出所有符合条件的记录
     */
    JsonData findByOrder(OrderVO Order);   
    
    /**
     * 保存
     */
    public int saveOrder(OrderVO Order);
    
    /**
     * 根据主键删除
     */
    public int deleteOrder(String[] id);

	
}

