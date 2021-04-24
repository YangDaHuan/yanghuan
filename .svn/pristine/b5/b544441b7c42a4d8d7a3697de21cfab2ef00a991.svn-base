package com.solidextend.sys.ticket.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketState;
import com.solidextend.sys.ticket.dao.BizTicketStateMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketStateServiceImpl implements BizTicketStateService{   

	@Resource
	private BizTicketStateMapper bizTicketStateMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketState getBizTicketStateById(String ticketStateId){
    	return bizTicketStateMapper.getBizTicketStateById(ticketStateId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketState> findAllBizTicketState(){
    	return bizTicketStateMapper.findAllBizTicketState();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketState> findByAttrBizTicketState(BizTicketState bizTicketState){
    	return bizTicketStateMapper.findByAttrBizTicketState(bizTicketState);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketState(BizTicketState bizTicketState){
    	boolean isInsert=false;
            if(bizTicketState.getTicketStateId()==null||"".equals(bizTicketState.getTicketStateId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketState.setTicketStateId(Identities.uuid());
        	bizTicketState.setCreateTime(new Timestamp(new Date().getTime()));
        	bizTicketState.setUpdateTime(new Timestamp(new Date().getTime()));
        	return bizTicketStateMapper.saveBizTicketState(bizTicketState);
        }else{
        	bizTicketState.setUpdateTime(new Timestamp(new Date().getTime()));
        	return bizTicketStateMapper.updateBizTicketState(bizTicketState);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketState(String[] ticketStateId){
    	int i;
    	for(i=0;i<ticketStateId.length;i++){
    		bizTicketStateMapper.deleteBizTicketState(ticketStateId[i]);
    	}
    	return i;
    }
}

