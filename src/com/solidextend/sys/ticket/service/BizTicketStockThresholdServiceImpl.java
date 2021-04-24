package com.solidextend.sys.ticket.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.ticket.dao.BizTicketStockThresholdMapper;
import com.solidextend.sys.ticket.vo.BizTicketStockThreshold;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketStockThresholdServiceImpl implements BizTicketStockThresholdService{   

	@Resource
	private BizTicketStockThresholdMapper bizTicketStockThresholdMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketStockThreshold getBizTicketStockThresholdById(String stockId){
    	return bizTicketStockThresholdMapper.getBizTicketStockThresholdById(stockId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketStockThreshold> findAllBizTicketStockThreshold(){
    	return bizTicketStockThresholdMapper.findAllBizTicketStockThreshold();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketStockThreshold> findByAttrBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold){
    	return bizTicketStockThresholdMapper.findByAttrBizTicketStockThreshold(bizTicketStockThreshold);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold){
    	boolean isInsert=false;
            if(bizTicketStockThreshold.getStockId()==null||"".equals(bizTicketStockThreshold.getStockId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketStockThreshold.setStockId(Identities.uuid());
        	return bizTicketStockThresholdMapper.saveBizTicketStockThreshold(bizTicketStockThreshold);
        }else{
        	return bizTicketStockThresholdMapper.updateBizTicketStockThreshold(bizTicketStockThreshold);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketStockThreshold(String[] stockId){
    	int i;
    	for(i=0;i<stockId.length;i++){
    		bizTicketStockThresholdMapper.deleteBizTicketStockThreshold(stockId[i]);
    	}
    	return i;
    }
/**
 * 查询是否已存在阀值
 */
	@Override
	public long hasTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold) {
		
		return bizTicketStockThresholdMapper.hasTicketStockThreshold(bizTicketStockThreshold);
	}
}

