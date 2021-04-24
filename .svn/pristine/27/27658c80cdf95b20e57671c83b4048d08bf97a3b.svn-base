package com.solidextend.sys.ticket.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.sys.ticket.dao.BizTicketSaleMapper;
import com.solidextend.sys.ticket.vo.BizTicketSale;

/**
 * TODO
 * @author 
 */
@Service("bizTicketSaleService")
public class BizTicketSaleServiceImpl implements BizTicketSaleService{   

	@Resource
	private BizTicketSaleMapper bizTicketSaleMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketSale getBizTicketSaleById(){
    	return bizTicketSaleMapper.getBizTicketSaleById();
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketSale> findAllBizTicketSale(){
    	return bizTicketSaleMapper.findAllBizTicketSale();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketSale> findByAttrBizTicketSale(BizTicketSale bizTicketSale){
    	return bizTicketSaleMapper.findByAttrBizTicketSale(bizTicketSale);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketSale(BizTicketSale bizTicketSale){
    	boolean isInsert=false;
        
        if(isInsert){
        	return bizTicketSaleMapper.saveBizTicketSale(bizTicketSale);
        }else{
        	return bizTicketSaleMapper.updateBizTicketSale(bizTicketSale);
        }
    	
    }
    
  
}

