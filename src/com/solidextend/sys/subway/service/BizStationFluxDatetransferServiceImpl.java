package com.solidextend.sys.subway.service;

import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxDatetransfer;
import com.solidextend.sys.subway.dao.BizStationFluxDatetransferMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizStationFluxDatetransferServiceImpl implements BizStationFluxDatetransferService{   

	@Resource
	private BizStationFluxDatetransferMapper bizStationFluxDatetransferMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizStationFluxDatetransfer getBizStationFluxDatetransferById(String id){
    	return bizStationFluxDatetransferMapper.getBizStationFluxDatetransferById(id);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizStationFluxDatetransfer> findAllBizStationFluxDatetransfer(){
    	return bizStationFluxDatetransferMapper.findAllBizStationFluxDatetransfer();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizStationFluxDatetransfer> findByAttrBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer){
    	return bizStationFluxDatetransferMapper.findByAttrBizStationFluxDatetransfer(bizStationFluxDatetransfer);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer){
    	boolean isInsert=false;
            if(bizStationFluxDatetransfer.getId()==null||"".equals(bizStationFluxDatetransfer.getId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizStationFluxDatetransfer.setId(Identities.uuid());
        	return bizStationFluxDatetransferMapper.saveBizStationFluxDatetransfer(bizStationFluxDatetransfer);
        }else{
        	return bizStationFluxDatetransferMapper.updateBizStationFluxDatetransfer(bizStationFluxDatetransfer);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizStationFluxDatetransfer(String[] id){
    	int i;
    	for(i=0;i<id.length;i++){
    		bizStationFluxDatetransferMapper.deleteBizStationFluxDatetransfer(id[i]);
    	}
    	return i;
    }
}

