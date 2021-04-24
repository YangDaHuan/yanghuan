package com.solidextend.sys.ticket.service;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.util.Identities;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.ticket.dao.BizTicketApplyMapper;
import com.solidextend.sys.ticket.dao.BizTicketDeployMapper;
import com.solidextend.sys.ticket.dao.BizTicketInDetailMapper;
import com.solidextend.sys.ticket.dao.BizTicketInMapper;
import com.solidextend.sys.ticket.dao.BizTicketStockMapper;
import com.solidextend.sys.ticket.vo.BizTicketIn;
import com.solidextend.sys.ticket.vo.BizTicketInDetail;
import com.solidextend.sys.ticket.vo.BizTicketStock;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketInServiceImpl implements BizTicketInService{   

	@Resource
	private BizTicketInMapper bizTicketInMapper;
	@Resource
	private BizTicketInDetailMapper bizTicketInDetailMapper;
	@Resource
	private BizTicketStockMapper bizTicketStockMapper;
	@Resource
	BizTicketDeployMapper bizTicketDeployMapper;
	
	private BizTicketStock bizTicketStock;
	
	@Resource
	private BizTicketApplyMapper bizTicketApplyMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketIn getBizTicketInById(String inId){
    	return bizTicketInMapper.getBizTicketInById(inId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketIn> findAllBizTicketIn(){
    	return bizTicketInMapper.findAllBizTicketIn();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketIn> findByAttrBizTicketIn(BizTicketIn bizTicketIn){
    	return bizTicketInMapper.findByAttrBizTicketIn(bizTicketIn);
    }    
    
    /**
     * 保存
     */
    @Override
    public String saveBizTicketIn(BizTicketIn bizTicketIn,boolean saveDetail){
    	boolean isInsert=false;
    	 bizTicketStock = new BizTicketStock();
            if(bizTicketIn.getInId()==null||"".equals(bizTicketIn.getInId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	String deployId=Identities.uuid();
        	bizTicketIn.setInId(deployId);
        	String inCode = getNewBizTicketInCode();
        	bizTicketIn.setInCode(inCode);
        	Date date = new Timestamp(new Date().getTime());
        	bizTicketIn.setInDate(date);
        	UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
        	bizTicketIn.setOperator(userDetails.getId());
        	
        	bizTicketInMapper.saveBizTicketIn(bizTicketIn);
        	
        	if(bizTicketIn.getDeployCode()!=null) {
	    		int deployState = 3;
	    		int auditingState = 6;
	    		bizTicketDeployMapper.updateBizTicketStateDeployByCode(bizTicketIn.getDeployCode(), deployState);
	    		bizTicketApplyMapper.updateBizTicketStateApplyByCode(bizTicketIn.getDeployCode(),auditingState);
	    	}
        	
        	List<BizTicketInDetail> details=bizTicketIn.getDetails();
        	bizTicketStock.setStockOrg(bizTicketIn.getInOrg());
        	bizTicketStock.setStockUpdateDate(date);
        	for(int i=0;i<details.size();i++){
	    		BizTicketInDetail bizTicketInDetail=details.get(i);
	    		String id = Identities.uuid();
	    		bizTicketInDetail.setInDetailId(id);
	    		bizTicketInDetail.setInDetailCode(id);
	    		bizTicketInDetail.setInId(deployId);
	    		bizTicketInDetailMapper.saveBizTicketInDetail(bizTicketInDetail);
	    		
	    		/**
	    		 *库存操作 
	    		 */
	    		bizTicketStock.setTicketStateId(bizTicketInDetail.getTicketStateId());
	    		bizTicketStock.setTicketTypeId(bizTicketInDetail.getTicketTypeId());
	    		bizTicketStock.setTicketMoney(bizTicketInDetail.getTicketMoney());
	    		BizTicketStock BizTicketStock2 = bizTicketStockMapper.bizTicketStock(bizTicketStock);
	    		
	    		if(BizTicketStock2==null) {
	    			bizTicketStock.setStockId(Identities.uuid());
	    			bizTicketStock.setTicketNumber(bizTicketInDetail.getTicketNumber());
	    			bizTicketStockMapper.saveBizTicketStock(bizTicketStock);
	    		}else {
	    			bizTicketStock.setStockId(BizTicketStock2.getStockId());
	    			bizTicketStock.setTicketNumber(BizTicketStock2.getTicketNumber()+bizTicketInDetail.getTicketNumber());
	    			bizTicketStockMapper.updateBizTicketStock(bizTicketStock);
	    		}
	    		
	    		
	    		
	    		
	    	}
        	return inCode;
        }
        
        else{
        	 bizTicketInMapper.updateBizTicketIn(bizTicketIn);
        	 if(saveDetail) {
        		 
        		 
        	 }
        	 return null;
        }
        
        
      /*  if(saveDetail){
        	String deployId=bizTicketDeploy.getDeployId();
        	bizTicketDeployDetailMapper.deleteBizTicketApplyDetailByDeployId(deployId);
        	List<BizTicketDeployDetail> details=bizTicketDeploy.getDetails();
        	for(int i=0;i<details.size();i++){
        		BizTicketDeployDetail bizTicketDeployDetail=details.get(i);
	    		bizTicketDeployDetail.setDepolyDetailId(Identities.uuid());
	    		bizTicketDeployDetail.setDeployId(deployId);
	    		bizTicketDeployDetailMapper.saveBizTicketDepolyDetail(bizTicketDeployDetail);
        	}
    	}*/
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketIn(String[] inId){
    	int i;
    	for(i=0;i<inId.length;i++){
    		bizTicketInMapper.deleteBizTicketIn(inId[i]);
    	}
    	return i;
    }
    /**
     * 
     */

	@Override
	public Long getCountByCode(String inCode) {	
		return bizTicketInMapper.getCountByCode(inCode);
	}
	
	/*
     * 获取新的code
     */
    public String getNewBizTicketInCode() {
		String code = bizTicketInMapper.getMaxBizTicketInCode();
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
			String newCode = "RK"+yyMMdd+str;
	    	return newCode;
		}
		return "RK"+yyMMdd+"001";
    }
}

