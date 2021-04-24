package com.solidextend.sys.takeout.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.takeout.vo.OrderVO;

@Mapper
public interface OrderMapper {

	public OrderVO getOrderById(@Param("OrderId")String OrderId);

	public List<OrderVO> findAllOrder();

	public List<OrderVO> findByOrder(OrderVO Order);
	
	public int findByOrderCount(OrderVO Order);

	public int updateOrder(OrderVO Order);

	public void deleteOrder(@Param("OrderId")String OrderId);

	public int saveOrder(OrderVO Order);

	public void delete(String string);

	
	
}
