package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketStock;
import com.solidextend.sys.ticket.dao.BizTicketStockMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service("bizTicketStockService")
public class BizTicketStockServiceImpl implements BizTicketStockService{   

	@Resource
	private BizTicketStockMapper bizTicketStockMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketStock getBizTicketStockById(String stockId){
    	return bizTicketStockMapper.getBizTicketStockById(stockId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketStock> findAllBizTicketStock(){
    	return bizTicketStockMapper.findAllBizTicketStock();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketStock> findByAttrBizTicketStock(BizTicketStock bizTicketStock){
    	return bizTicketStockMapper.findByAttrBizTicketStock(bizTicketStock);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketStock(BizTicketStock bizTicketStock){
    	boolean isInsert=false;
            if(bizTicketStock.getStockId()==null||"".equals(bizTicketStock.getStockId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketStock.setStockId(Identities.uuid());
        	return bizTicketStockMapper.saveBizTicketStock(bizTicketStock);
        }else{
        	return bizTicketStockMapper.updateBizTicketStock(bizTicketStock);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketStock(String[] stockId){
    	int i;
    	for(i=0;i<stockId.length;i++){
    		bizTicketStockMapper.deleteBizTicketStock(stockId[i]);
    	}
    	return i;
    }

	@Override
	public boolean bizTicketStock(BizTicketStock bizTicketStock) {
		
		
		bizTicketStockMapper.bizTicketStock(bizTicketStock);
		return true;
	}
}

