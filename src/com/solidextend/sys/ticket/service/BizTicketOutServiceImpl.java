package com.solidextend.sys.ticket.service;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.ticket.dao.BizTicketApplyMapper;
import com.solidextend.sys.ticket.dao.BizTicketDeployMapper;
import com.solidextend.sys.ticket.dao.BizTicketOutDetailMapper;
import com.solidextend.sys.ticket.dao.BizTicketOutMapper;
import com.solidextend.sys.ticket.dao.BizTicketStockMapper;
import com.solidextend.sys.ticket.vo.BizTicketOut;
import com.solidextend.sys.ticket.vo.BizTicketOutDetail;
import com.solidextend.sys.ticket.vo.BizTicketStock;

/**
 * TODO
 * @author 
 */
@Service("bizTicketOutService")
public class BizTicketOutServiceImpl implements BizTicketOutService{   

	@Resource
	private BizTicketOutMapper bizTicketOutMapper;
	@Resource
	private BizTicketOutDetailMapper bizTicketOutDetailMapper;
	@Resource
	private BizTicketStockMapper bizTicketStockMapper;
	
	@Resource
	private BizTicketDeployMapper bizTicketDeployMapper;
	private BizTicketStock bizTicketStock;
	
	@Resource
	private BizTicketApplyMapper bizTicketApplyMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketOut getBizTicketOutById(String outId){
    	return bizTicketOutMapper.getBizTicketOutById(outId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketOut> findAllBizTicketOut(){
    	return bizTicketOutMapper.findAllBizTicketOut();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketOut> findByAttrBizTicketOut(BizTicketOut bizTicketOut){
    	return bizTicketOutMapper.findByAttrBizTicketOut(bizTicketOut);
    }    
    
    /**
     * 保存
     */
    @Override
    @Transactional
    public String saveBizTicketOut(BizTicketOut bizTicketOut,boolean saveDetail){
    	boolean isInsert=false;
    	bizTicketStock = new BizTicketStock();
            if(bizTicketOut.getOutId()==null||"".equals(bizTicketOut.getOutId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	String setOutId=Identities.uuid();
        	bizTicketOut.setOutId(setOutId);
        	String outCode=getNewBizTicketOutCode();
        	bizTicketOut.setOutCode(outCode);
        	Date date = new Timestamp(new Date().getTime());
        	bizTicketOut.setOutDate(date);
        	if(bizTicketOut.getOutType()!=4) {
        		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
    	    	bizTicketOut.setOperator(userDetails.getId());
        	}
	    	List<BizTicketOutDetail> details=bizTicketOut.getDetails();
	    	bizTicketStock.setStockOrg(bizTicketOut.getOutOrg());
	    	bizTicketStock.setStockUpdateDate(date);
	    	for(int i=0;i<details.size();i++){
	    		BizTicketOutDetail bizTicketOutDetail=details.get(i);
	    		/**
	    		 * 库存操作
	    		 */
	    		bizTicketStock.setTicketMoney(bizTicketOutDetail.getTicketMoney());
	    		if( "f61bef88ea1340b3a782523d3c15604c".equals(bizTicketOutDetail.getTicketStateId())) {
	    			bizTicketStock.setTicketStateId("1035433b623642cea57b602233e96594");
	    		}else {
	    			bizTicketStock.setTicketStateId(bizTicketOutDetail.getTicketStateId());
	    		}
	    		bizTicketStock.setTicketTypeId(bizTicketOutDetail.getTicketTypeId());
	    		BizTicketStock bizTicketStock2 = bizTicketStockMapper.bizTicketStock(bizTicketStock);
	    		if(bizTicketStock2==null) {
	    			return "";
	    		}
	    		bizTicketStock.setStockId(bizTicketStock2.getStockId());
	    		int TICKET_NUMBER = bizTicketStock2.getTicketNumber();
	    		if(TICKET_NUMBER<bizTicketOutDetail.getTicketNumber()) {
	    			return "";
	    		}
	    	}
	    	
	    	if(bizTicketOut.getDeployCode()!=null) {
	    		int deployState = 2;
	    		int auditingState = 5;
	    		bizTicketDeployMapper.updateBizTicketStateDeployByCode(bizTicketOut.getDeployCode(), deployState);
	    		bizTicketApplyMapper.updateBizTicketStateApplyByCode(bizTicketOut.getDeployCode(),auditingState);
	    	}
	    	
	    	bizTicketOutMapper.saveBizTicketOut(bizTicketOut);
	    	
	    	for(int i=0;i<details.size();i++){
	    		BizTicketOutDetail bizTicketOutDetail=details.get(i);
	    		bizTicketOutDetail.setOutId(setOutId);
	    		bizTicketOutDetail.setOutDetailId(Identities.uuid());
	    		bizTicketOutDetailMapper.saveBizTicketOutDetail(bizTicketOutDetail);
	    		
	    		/**
	    		 * 库存操作
	    		 */
	    		bizTicketStock.setTicketMoney(bizTicketOutDetail.getTicketMoney());
	    		BizTicketStock bizTicketStock2 = bizTicketStockMapper.bizTicketStock(bizTicketStock);
	    		
	    		bizTicketStock.setStockId(bizTicketStock2.getStockId());
	    		int TICKET_NUMBER = bizTicketStock2.getTicketNumber();
	    		
	    		bizTicketStock.setTicketNumber((TICKET_NUMBER-bizTicketOutDetail.getTicketNumber()));
	    			bizTicketStockMapper.updateBizTicketStock(bizTicketStock);
	    	}
	    	return outCode;
        }else{
        	bizTicketOutMapper.updateBizTicketOut(bizTicketOut);
        	return "";
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketOut(String[] outId){
    	int i;
    	for(i=0;i<outId.length;i++){
    		bizTicketOutMapper.deleteBizTicketOut(outId[i]);
    	}
    	return i;
    }
    @Override
    public Long getCountByCode(String code){
    	
    	return bizTicketOutMapper.getCountByCode(code);
    }
    
    public String getNewBizTicketOutCode() {
		String code = bizTicketOutMapper.getMaxBizTicketOutCode();
		Date date = new  Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String yyyy=sdf.format(date);
		String yy =  yyyy.substring(2,4);
		String MM =  yyyy.substring(5,7);
		String dd =  yyyy.substring(8,10);
		String yyMMdd=yy+MM+dd;
		if(code!=null && code.length()>8 && code.substring(2,8).equals(yyMMdd)) {
			int i =Integer.parseInt(code.substring(8));
			i+=1;
			DecimalFormat df=new DecimalFormat("000");
			String str=df.format(i);
			String newCode = "CK"+yyMMdd+str;
	    	return newCode;
		}
		return "CK"+yyMMdd+"001";
    }
}

