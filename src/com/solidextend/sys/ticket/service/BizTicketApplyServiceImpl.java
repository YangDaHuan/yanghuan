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
import com.solidextend.sys.ticket.dao.BizTicketApplyDetailMapper;
import com.solidextend.sys.ticket.dao.BizTicketApplyMapper;
import com.solidextend.sys.ticket.vo.BizTicketApply;
import com.solidextend.sys.ticket.vo.BizTicketApplyDetail;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketApplyServiceImpl implements BizTicketApplyService{   

	@Resource
	private BizTicketApplyMapper bizTicketApplyMapper;
	@Resource
	private BizTicketApplyDetailMapper bizTicketApplyDetailMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketApply getBizTicketApplyById(String applyId){
    	return bizTicketApplyMapper.getBizTicketApplyById(applyId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketApply> findAllBizTicketApply(){
    	return bizTicketApplyMapper.findAllBizTicketApply();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketApply> findByAttrBizTicketApply(BizTicketApply bizTicketApply, String[] applyOrgArray, String[] toOrgArray, String[] auditingStateArray,String[] auditingOrgArray){
    	return bizTicketApplyMapper.findByAttrBizTicketApply(bizTicketApply, applyOrgArray,  toOrgArray,  auditingStateArray,auditingOrgArray);
    }    
    /**
     * 查询出所有待审核的记录
     */
    @Override
    public List<BizTicketApply> findByAuditBizTicketApply(String[] applyOrgArray, String[] toOrgArray, String[] auditingStateArray,String[] auditingOrgArray,String groupName){
    	return bizTicketApplyMapper.findByAuditBizTicketApply( applyOrgArray,  toOrgArray,  auditingStateArray,auditingOrgArray,groupName);
    }
    /**
     * 查询出所有已审核的记录
     */
    @Override
    public List<BizTicketApply> findByAuditedBizTicketApply(String[] applyOrgArray, String[] toOrgArray, String[] auditingStateArray,String[] auditingOrgArray){
    	return bizTicketApplyMapper.findByAuditedBizTicketApply( applyOrgArray,  toOrgArray,  auditingStateArray,auditingOrgArray);
    }
    /**
     * 保存
     */
    @Override
    public String saveBizTicketApply(BizTicketApply bizTicketApply,boolean saveDetail){
    	boolean isInsert=false;
            if(bizTicketApply.getApplyId()==null||"".equals(bizTicketApply.getApplyId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	String applyId=Identities.uuid();
        	String applyCode;
        	if(bizTicketApply.getApplyType()==1){
        		applyCode = getNewBizTicketApplyCode("SL");
        	}else if(bizTicketApply.getApplyType()==2){
        		applyCode = getNewBizTicketApplyCode("SJ");
        	}else{
        		applyCode = getNewBizTicketApplyCode("HS");
        	}
        	
        	bizTicketApply.setApplyCode(applyCode);
        	bizTicketApply.setApplyId(applyId);
        	bizTicketApply.setApplyDate(new Timestamp(new Date().getTime()));
        	UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
        	bizTicketApply.setOperator(userDetails.getId());
        	bizTicketApplyMapper.saveBizTicketApply(bizTicketApply);
        	List<BizTicketApplyDetail> details=bizTicketApply.getDetails();
        	for(int i=0;i<details.size();i++){
        		BizTicketApplyDetail bizTicketApplyDetail=details.get(i);
        		bizTicketApplyDetail.setApplyDetailId(Identities.uuid());
        		bizTicketApplyDetail.setApplyId(applyId);
        		bizTicketApplyDetailMapper.saveBizTicketApplyDetail(bizTicketApplyDetail);
        	}
        	return applyCode;
        }else{
			bizTicketApply.setAuditingDate(new Timestamp(new Date().getTime()));
        	bizTicketApplyMapper.updateBizTicketApply(bizTicketApply);
        	if(saveDetail){
	        	String applyId=bizTicketApply.getApplyId();
	        	bizTicketApplyDetailMapper.deleteBizTicketApplyDetailByApplyId(applyId);
	        	List<BizTicketApplyDetail> details=bizTicketApply.getDetails();
	        	for(int i=0;i<details.size();i++){
	        		BizTicketApplyDetail bizTicketApplyDetail=details.get(i);
	        		bizTicketApplyDetail.setApplyDetailId(Identities.uuid());
	        		bizTicketApplyDetail.setApplyId(applyId);
	        		bizTicketApplyDetailMapper.saveBizTicketApplyDetail(bizTicketApplyDetail);
	        	}
        	}
        	return null;
        }
        
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketApply(String[] applyId){
    	int i;
    	for(i=0;i<applyId.length;i++){
    		bizTicketApplyMapper.deleteBizTicketApply(applyId[i]);
    	}
    	return i;
    }
    public String getNewBizTicketApplyCode(String type) {
		String code = bizTicketApplyMapper.getMaxBizTicketApplyCode(type);
		Date date = new  Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String yyyy=sdf.format(date);
		String yy =  yyyy.substring(2,4);
		String MM =  yyyy.substring(5,7);
		String dd =  yyyy.substring(8,10);
		String yyMMdd=yy+MM+dd;
		//code SL180212001
		if(code!=null && code.length()>8 && code.substring(2,8).equals(yyMMdd)) {
			int i =Integer.parseInt(code.substring(8));
			i+=1;
			DecimalFormat df=new DecimalFormat("000");
			String str=df.format(i);
			String newCode = type+yyMMdd+str;
	    	return newCode;
		}
		return type+yyMMdd+"001";
    }

	@Override
	public List<BizTicketApply> findByOrgandGroupName(String org, String groupName, int auditingState,int applyType) {
		
		return bizTicketApplyMapper.findByOrgandGroupName(org,groupName,auditingState,applyType);
	}
}

