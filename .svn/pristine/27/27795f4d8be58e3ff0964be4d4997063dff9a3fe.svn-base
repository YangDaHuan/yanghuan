package com.solidextend.sys.subway.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.solidextend.sys.subway.vo.BizStationFluxSection;
import com.solidextend.sys.subway.dao.BizStationFluxSectionMapper;

/**
 * TODO
 * @author 
 */
public interface BizStationFluxSectionService{   
    /**
     * 根据主键查询
     */
    public BizStationFluxSection getBizStationFluxSectionById(String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxSection> findAllBizStationFluxSection();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxSection> findByAttrBizStationFluxSection(BizStationFluxSection bizStationFluxSection);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxSection(BizStationFluxSection bizStationFluxSection);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxSection(String[] id);

	void saveExcelData(MultipartFile excel) throws Exception;
}

