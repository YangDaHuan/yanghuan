package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketStockHistory;
import com.solidextend.sys.ticket.dao.BizTicketStockHistoryMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service("bizTicketStockHistoryService")
public class BizTicketStockHistoryServiceImpl implements BizTicketStockHistoryService{   

	@Resource
	private BizTicketStockHistoryMapper bizTicketStockHistoryMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketStockHistory getBizTicketStockHistoryById(String stockId){
    	return bizTicketStockHistoryMapper.getBizTicketStockHistoryById(stockId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketStockHistory> findAllBizTicketStockHistory(){
    	return bizTicketStockHistoryMapper.findAllBizTicketStockHistory();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketStockHistory> findByAttrBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory){
    	return bizTicketStockHistoryMapper.findByAttrBizTicketStockHistory(bizTicketStockHistory);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketStockHistory(BizTicketStockHistory bizTicketStockHistory){
    	boolean isInsert=false;
            if(bizTicketStockHistory.getStockId()==null||"".equals(bizTicketStockHistory.getStockId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketStockHistory.setStockId(Identities.uuid());
        	return bizTicketStockHistoryMapper.saveBizTicketStockHistory(bizTicketStockHistory);
        }else{
        	return bizTicketStockHistoryMapper.updateBizTicketStockHistory(bizTicketStockHistory);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketStockHistory(String[] stockId){
    	int i;
    	for(i=0;i<stockId.length;i++){
    		bizTicketStockHistoryMapper.deleteBizTicketStockHistory(stockId[i]);
    	}
    	return i;
    }
}

