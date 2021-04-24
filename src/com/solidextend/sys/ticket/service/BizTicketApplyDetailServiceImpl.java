package com.solidextend.sys.ticket.service;

import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketApplyDetail;
import com.solidextend.sys.ticket.dao.BizTicketApplyDetailMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketApplyDetailServiceImpl implements BizTicketApplyDetailService{   

	@Resource
	private BizTicketApplyDetailMapper bizTicketApplyDetailMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketApplyDetail getBizTicketApplyDetailById(String applyDetailId){
    	return bizTicketApplyDetailMapper.getBizTicketApplyDetailById(applyDetailId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketApplyDetail> findAllBizTicketApplyDetail(){
    	return bizTicketApplyDetailMapper.findAllBizTicketApplyDetail();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketApplyDetail> findByAttrBizTicketApplyDetail(BizTicketApplyDetail bizTicketApplyDetail){
    	return bizTicketApplyDetailMapper.findByAttrBizTicketApplyDetail(bizTicketApplyDetail);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizTicketApplyDetail(BizTicketApplyDetail bizTicketApplyDetail){
    	boolean isInsert=false;
            if(bizTicketApplyDetail.getApplyDetailId()==null||"".equals(bizTicketApplyDetail.getApplyDetailId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizTicketApplyDetail.setApplyDetailId(Identities.uuid());
        	return bizTicketApplyDetailMapper.saveBizTicketApplyDetail(bizTicketApplyDetail);
        }else{
        	return bizTicketApplyDetailMapper.updateBizTicketApplyDetail(bizTicketApplyDetail);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketApplyDetail(String[] applyDetailId){
    	int i;
    	for(i=0;i<applyDetailId.length;i++){
    		bizTicketApplyDetailMapper.deleteBizTicketApplyDetail(applyDetailId[i]);
    	}
    	return i;
    }
}

