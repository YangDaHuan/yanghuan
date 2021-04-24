package com.solidextend.sys.subway.service;

import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxCardinalWeb;
import com.solidextend.sys.subway.dao.BizStationFluxCardinalWebMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizStationFluxCardinalWebServiceImpl implements BizStationFluxCardinalWebService{   

	@Resource
	private BizStationFluxCardinalWebMapper bizStationFluxCardinalWebMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizStationFluxCardinalWeb getBizStationFluxCardinalWebById(String id){
    	return bizStationFluxCardinalWebMapper.getBizStationFluxCardinalWebById(id);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizStationFluxCardinalWeb> findAllBizStationFluxCardinalWeb(){
    	return bizStationFluxCardinalWebMapper.findAllBizStationFluxCardinalWeb();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizStationFluxCardinalWeb> findByAttrBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb){
    	return bizStationFluxCardinalWebMapper.findByAttrBizStationFluxCardinalWeb(bizStationFluxCardinalWeb);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb){
    	boolean isInsert=false;
            if(bizStationFluxCardinalWeb.getId()==null||"".equals(bizStationFluxCardinalWeb.getId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizStationFluxCardinalWeb.setId(Identities.uuid());
        	return bizStationFluxCardinalWebMapper.saveBizStationFluxCardinalWeb(bizStationFluxCardinalWeb);
        }else{
        	return bizStationFluxCardinalWebMapper.updateBizStationFluxCardinalWeb(bizStationFluxCardinalWeb);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizStationFluxCardinalWeb(String[] id){
    	int i;
    	for(i=0;i<id.length;i++){
    		bizStationFluxCardinalWebMapper.deleteBizStationFluxCardinalWeb(id[i]);
    	}
    	return i;
    }
}

