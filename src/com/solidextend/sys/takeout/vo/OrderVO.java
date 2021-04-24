package com.solidextend.sys.takeout.vo;

import java.util.Date;

public class OrderVO extends BaseVO {
	
	//菜品id
	private Long orderId;
	
	//商家ID
	private long orderBusId;
	
	//用户ID
	private long orderUserId;
	
	//订单日期
	private Date orderDate;
	
	//订单状态
	private String orderStatus;
	
	//送货地址
	private String orderAddress;
	
	//订单总价
	private double totalPrice;
	
	private String orderPalyType;
	
	
	
	public String getOrderPalyType() {
		return orderPalyType;
	}

	public void setOrderPalyType(String orderPalyType) {
		this.orderPalyType = orderPalyType;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public long getOrderBusId() {
		return orderBusId;
	}

	public void setOrderBusId(long orderBusId) {
		this.orderBusId = orderBusId;
	}

	public long getOrderUserId() {
		return orderUserId;
	}

	public void setOrderUserId(long orderUserId) {
		this.orderUserId = orderUserId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	

    

}
