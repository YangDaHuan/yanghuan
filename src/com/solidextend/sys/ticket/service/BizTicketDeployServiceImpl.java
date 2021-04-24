package com.solidextend.sys.ticket.service;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.solidextend.sys.ticket.vo.BizTicketApplyDetail;
import com.solidextend.sys.ticket.vo.BizTicketDeploy;
import com.solidextend.sys.ticket.vo.BizTicketDeployDetail;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.ticket.dao.BizTicketApplyMapper;
import com.solidextend.sys.ticket.dao.BizTicketDeployMapper;
import com.solidextend.sys.ticket.dao.BizTicketDepolyDetailMapper;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizTicketDeployServiceImpl implements BizTicketDeployService{   

	@Resource
	private BizTicketDeployMapper bizTicketDeployMapper;
	@Resource
	private BizTicketDepolyDetailMapper bizTicketDeployDetailMapper;
	
	@Resource
	private BizTicketApplyMapper bizTicketApplyMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizTicketDeploy getBizTicketDeployById(String deployId){
    	return bizTicketDeployMapper.getBizTicketDeployById(deployId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizTicketDeploy> findAllBizTicketDeploy(){
    	return bizTicketDeployMapper.findAllBizTicketDeploy();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizTicketDeploy> findByAttrBizTicketDeploy(BizTicketDeploy bizTicketDeploy){
    	return bizTicketDeployMapper.findByAttrBizTicketDeploy(bizTicketDeploy);
    }    
    /**
     * 查询出所有和调配部门相关的记录
     */
    @Override
    public List<BizTicketDeploy> findByAboutBizTicketDeploy(BizTicketDeploy bizTicketDeploy){
    	return bizTicketDeployMapper.findByAboutBizTicketDeploy(bizTicketDeploy);
    }    
    
    /**
     * 保存
     */
    @Override 
    public String saveBizTicketDeploy(BizTicketDeploy bizTicketDeploy,boolean saveDetail){
    	boolean isInsert=false;
        if(bizTicketDeploy.getDeployId()==null||"".equals(bizTicketDeploy.getDeployId())){
        	isInsert=true;
        }
    
	    if(isInsert){
	    	String deployId=Identities.uuid();
	    	bizTicketDeploy.setDeployId(deployId);
	    	String deployCode = getNewBizTicketDeployCode();
	    	bizTicketDeploy.setDeployCode(deployCode);
	    	bizTicketDeploy.setDepolyDate(new Timestamp(new Date().getTime()));
	    	UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
	    	bizTicketDeploy.setDesignUser(userDetails.getId());
	    	bizTicketDeploy.setDepolyState(1);
	    	bizTicketDeployMapper.saveBizTicketDeploy(bizTicketDeploy);
	    	List<BizTicketDeployDetail> details=bizTicketDeploy.getDetails();
	    	for(int i=0;i<details.size();i++){
	    		BizTicketDeployDetail bizTicketDeployDetail=details.get(i);
	    		bizTicketDeployDetail.setDepolyDetailId(Identities.uuid());
	    		bizTicketDeployDetail.setDeployId(deployId);
	    		bizTicketDeployDetailMapper.saveBizTicketDepolyDetail(bizTicketDeployDetail);
	    	}
	    	
	    	if(bizTicketDeploy.getApplyCode()!=null) {
	    		//int deployState = 4;//已调配
	    		int auditingState = 7;//已调配
	    		//bizTicketDeployMapper.updateBizTicketStateDeployByCode(bizTicketDeploy.getDeployCode(), deployState);
	    		bizTicketApplyMapper.updateBizTicketStateApplyByCode(bizTicketDeploy.getApplyCode(),auditingState);
	    	}
	    	return deployCode;
	    }else{
	    	bizTicketDeployMapper.updateBizTicketDeploy(bizTicketDeploy);
	    	if(saveDetail){
	        	String deployId=bizTicketDeploy.getDeployId();
	        	bizTicketDeployDetailMapper.deleteBizTicketApplyDetailByDeployId(deployId);
	        	List<BizTicketDeployDetail> details=bizTicketDeploy.getDetails();
	        	for(int i=0;i<details.size();i++){
	        		BizTicketDeployDetail bizTicketDeployDetail=details.get(i);
		    		bizTicketDeployDetail.setDepolyDetailId(Identities.uuid());
		    		bizTicketDeployDetail.setDeployId(deployId);
		    		bizTicketDeployDetailMapper.saveBizTicketDepolyDetail(bizTicketDeployDetail);
	        	}
	    	}
	    	return null;
	    }
	    
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizTicketDeploy(String[] deployId){
    	int i;
    	for(i=0;i<deployId.length;i++){
    		bizTicketDeployMapper.deleteBizTicketDeploy(deployId[i]);
    	}
    	return i;
    }
    /*
     * 获取新的code
     */
    public String getNewBizTicketDeployCode() {
		String code = bizTicketDeployMapper.getMaxBizTicketDeployCode();
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
			String newCode = "TP"+yyMMdd+str;
	    	return newCode;
		}
		return "TP"+yyMMdd+"001";
    }

	@Override
	public List<BizTicketDeploy> findByAttrBizTicketDeployAndApply(BizTicketDeploy bizTicketDeploy, Integer auditingState,String groupName) {
		// TODO Auto-generated method stub
		return bizTicketDeployMapper.findByAttrBizTicketDeployAndApply( bizTicketDeploy,auditingState,groupName);
	}
}

