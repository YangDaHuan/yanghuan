package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketInDetail;
import com.solidextend.sys.ticket.dao.BizTicketInDetailMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketInDetailServiceImpl implements BizTicketInDetailService{   

	@Resource
	private BizTicketInDetailMapper bizTicketInDetailMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketInDetail getBizTicketInDetailById(String inDetailId){
    	return bizTicketInDetailMapper.getBizTicketInDetailById(inDetailId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketInDetail> findAllBizTicketInDetail(){
    	return bizTicketInDetailMapper.findAllBizTicketInDetail();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketInDetail> findByAttrBizTicketInDetail(BizTicketInDetail bizTicketInDetail){
    	return bizTicketInDetailMapper.findByAttrBizTicketInDetail(bizTicketInDetail);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketInDetail(BizTicketInDetail bizTicketInDetail){
    	boolean isInsert=false;
            if(bizTicketInDetail.getInDetailId()==null||"".equals(bizTicketInDetail.getInDetailId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketInDetail.setInDetailId(Identities.uuid());
        	return bizTicketInDetailMapper.saveBizTicketInDetail(bizTicketInDetail);
        }else{
        	return bizTicketInDetailMapper.updateBizTicketInDetail(bizTicketInDetail);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketInDetail(String[] inDetailId){
    	int i;
    	for(i=0;i<inDetailId.length;i++){
    		bizTicketInDetailMapper.deleteBizTicketInDetail(inDetailId[i]);
    	}
    	return i;
    }
}

