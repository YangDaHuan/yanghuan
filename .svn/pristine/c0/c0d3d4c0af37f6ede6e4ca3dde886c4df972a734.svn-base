package com.solidextend.sys.subway.service;

import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxLimitWeb;
import com.solidextend.sys.subway.dao.BizStationFluxLimitWebMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizStationFluxLimitWebServiceImpl implements BizStationFluxLimitWebService{   

	@Resource
	private BizStationFluxLimitWebMapper bizStationFluxLimitWebMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizStationFluxLimitWeb getBizStationFluxLimitWebById(String id){
    	return bizStationFluxLimitWebMapper.getBizStationFluxLimitWebById(id);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizStationFluxLimitWeb> findAllBizStationFluxLimitWeb(){
    	return bizStationFluxLimitWebMapper.findAllBizStationFluxLimitWeb();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizStationFluxLimitWeb> findByAttrBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb){
    	return bizStationFluxLimitWebMapper.findByAttrBizStationFluxLimitWeb(bizStationFluxLimitWeb);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb){
    	boolean isInsert=false;
            if(bizStationFluxLimitWeb.getId()==null||"".equals(bizStationFluxLimitWeb.getId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizStationFluxLimitWeb.setId(Identities.uuid());
        	return bizStationFluxLimitWebMapper.saveBizStationFluxLimitWeb(bizStationFluxLimitWeb);
        }else{
        	return bizStationFluxLimitWebMapper.updateBizStationFluxLimitWeb(bizStationFluxLimitWeb);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizStationFluxLimitWeb(String[] id){
    	int i;
    	for(i=0;i<id.length;i++){
    		bizStationFluxLimitWebMapper.deleteBizStationFluxLimitWeb(id[i]);
    	}
    	return i;
    }
}

