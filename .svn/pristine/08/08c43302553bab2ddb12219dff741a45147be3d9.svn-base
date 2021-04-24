package com.solidextend.sys.subway.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.solidextend.sys.subway.vo.BizStationFluxTransfer;
import com.solidextend.sys.subway.dao.BizStationFluxTransferMapper;

/**
 * TODO
 * @author 
 */
public interface BizStationFluxTransferService{   
    /**
     * 根据主键查询
     */
    public BizStationFluxTransfer getBizStationFluxTransferById(String id); 

    /**
     * 查询出所有记录
     */
    public List<BizStationFluxTransfer> findAllBizStationFluxTransfer();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizStationFluxTransfer> findByAttrBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer);    
    
    /**
     * 保存
     */
    public int saveBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer);
    
    /**
     * 根据主键删除
     */
    public int deleteBizStationFluxTransfer(String[] id);

	void saveExcelData(MultipartFile excel) throws Exception;
}

