package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketOutDetail;
import com.solidextend.sys.ticket.dao.BizTicketOutDetailMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketOutDetailServiceImpl implements BizTicketOutDetailService{   

	@Resource
	private BizTicketOutDetailMapper bizTicketOutDetailMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketOutDetail getBizTicketOutDetailById(String outDetailId){
    	return bizTicketOutDetailMapper.getBizTicketOutDetailById(outDetailId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketOutDetail> findAllBizTicketOutDetail(){
    	return bizTicketOutDetailMapper.findAllBizTicketOutDetail();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketOutDetail> findByAttrBizTicketOutDetail(BizTicketOutDetail bizTicketOutDetail){
    	return bizTicketOutDetailMapper.findByAttrBizTicketOutDetail(bizTicketOutDetail);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketOutDetail(BizTicketOutDetail bizTicketOutDetail){
    	boolean isInsert=false;
            if(bizTicketOutDetail.getOutDetailId()==null||"".equals(bizTicketOutDetail.getOutDetailId())){
            	isInsert=true;
            }
        	System.out.println(isInsert);
        if(isInsert){
        	bizTicketOutDetail.setOutDetailId(Identities.uuid());
        	return bizTicketOutDetailMapper.saveBizTicketOutDetail(bizTicketOutDetail);
        }else{
        	return bizTicketOutDetailMapper.updateBizTicketOutDetail(bizTicketOutDetail);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketOutDetail(String[] outDetailId){
    	int i;
    	for(i=0;i<outDetailId.length;i++){
    		bizTicketOutDetailMapper.deleteBizTicketOutDetail(outDetailId[i]);
    	}
    	return i;
    }
}

