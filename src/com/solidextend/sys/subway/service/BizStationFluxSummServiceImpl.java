package com.solidextend.sys.subway.service;

import java.util.List;
import java.util.Map;

import com.solidextend.sys.subway.vo.BizStationFluxSumm;
import com.solidextend.sys.subway.dao.BizStationFluxSummMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizStationFluxSummServiceImpl implements BizStationFluxSummService{   

	@Resource
	private BizStationFluxSummMapper bizStationFluxSummMapper;
	
	@Override
	public List<Map> getStationInfo(BizStationFluxSumm bizStationFluxSumm)
	{
		return bizStationFluxSummMapper.getStationInfo(bizStationFluxSumm);
	}
	/**
     * 根据主键查询
     */
    @Override
    public BizStationFluxSumm getBizStationFluxSummById(String id){
    	return bizStationFluxSummMapper.getBizStationFluxSummById(id);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizStationFluxSumm> findAllBizStationFluxSumm(){
    	return bizStationFluxSummMapper.findAllBizStationFluxSumm();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizStationFluxSumm> findByAttrBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm){
    	return bizStationFluxSummMapper.findByAttrBizStationFluxSumm(bizStationFluxSumm);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm){
    	boolean isInsert=false;
            if(bizStationFluxSumm.getId()==null||"".equals(bizStationFluxSumm.getId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizStationFluxSumm.setId(Identities.uuid());
        	return bizStationFluxSummMapper.saveBizStationFluxSumm(bizStationFluxSumm);
        }else{
        	return bizStationFluxSummMapper.updateBizStationFluxSumm(bizStationFluxSumm);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizStationFluxSumm(String[] id){
    	int i;
    	for(i=0;i<id.length;i++){
    		bizStationFluxSummMapper.deleteBizStationFluxSumm(id[i]);
    	}
    	return i;
    }
}

