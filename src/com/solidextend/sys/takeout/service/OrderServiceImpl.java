package com.solidextend.sys.takeout.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.takeout.dao.OrderMapper;
import com.solidextend.sys.takeout.vo.OrderVO;

/**
 * TODO
 * @author 
 */
@Service
public class OrderServiceImpl implements OrderService{   

	@Resource
	private OrderMapper orderMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public OrderVO getOrderById(String OrderId){
    	return orderMapper.getOrderById(OrderId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<OrderVO> findAllOrder(){
    	return orderMapper.findAllOrder();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public JsonData findByOrder(OrderVO Order){
    	List<OrderVO> list =  orderMapper.findByOrder(Order);
		int total = orderMapper.findByOrderCount(Order);
		JsonData jsonData = new JsonData();
		jsonData.setTotal(total);
		jsonData.setRows(list);
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveOrder(OrderVO Order){
    	boolean isInsert=false;
            if(Order.getOrderId()==null||Order.getOrderId()==0){
            	isInsert=true;
            }
        
        if(isInsert){
        	
        	return orderMapper.saveOrder(Order);
        }else{
        	return orderMapper.updateOrder(Order);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteOrder(String[] OrderId){
    	int i;
    	for(i=0;i<OrderId.length;i++){
    		orderMapper.delete(OrderId[i]);
    	}
    	return i;
    }

}

