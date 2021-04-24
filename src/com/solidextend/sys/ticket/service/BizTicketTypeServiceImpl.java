package com.solidextend.sys.ticket.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketType;
import com.solidextend.sys.ticket.dao.BizTicketTypeMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketTypeServiceImpl implements BizTicketTypeService{   

	@Resource
	private BizTicketTypeMapper bizTicketTypeMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketType getBizTicketTypeById(String ticketTypeId){
    	return bizTicketTypeMapper.getBizTicketTypeById(ticketTypeId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketType> findAllBizTicketType(){
    	return bizTicketTypeMapper.findAllBizTicketType();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketType> findByAttrBizTicketType(BizTicketType bizTicketType){
    	return bizTicketTypeMapper.findByAttrBizTicketType(bizTicketType);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketType(BizTicketType bizTicketType){
    	boolean isInsert=false;
            if(bizTicketType.getTicketTypeId()==null||"".equals(bizTicketType.getTicketTypeId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketType.setTicketTypeId(Identities.uuid());
        	bizTicketType.setCreateTime(new Timestamp(new Date().getTime()));
        	bizTicketType.setUpdateTime(new Timestamp(new Date().getTime()));
        	
        	return bizTicketTypeMapper.saveBizTicketType(bizTicketType);
        }else{
        	bizTicketType.setUpdateTime(new Timestamp(new Date().getTime()));
        	return bizTicketTypeMapper.updateBizTicketType(bizTicketType);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketType(String[] ticketTypeId){
    	int i;
    	for(i=0;i<ticketTypeId.length;i++){
    		bizTicketTypeMapper.deleteBizTicketType(ticketTypeId[i]);
    	}
    	return i;
    }
}

