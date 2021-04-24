package com.solidextend.sys.subway.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import com.solidextend.sys.subway.vo.BizStationFluxTransfer;
import com.solidextend.sys.subway.dao.BizStationFluxTransferMapper;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.solidextend.core.util.Identities;

/**
 * TODO
 * @author 
 */
@Service
public class BizStationFluxTransferServiceImpl implements BizStationFluxTransferService{   

	@Resource
	private BizStationFluxTransferMapper bizStationFluxTransferMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public BizStationFluxTransfer getBizStationFluxTransferById(String id){
    	return bizStationFluxTransferMapper.getBizStationFluxTransferById(id);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<BizStationFluxTransfer> findAllBizStationFluxTransfer(){
    	return bizStationFluxTransferMapper.findAllBizStationFluxTransfer();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public List<BizStationFluxTransfer> findByAttrBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer){
    	return bizStationFluxTransferMapper.findByAttrBizStationFluxTransfer(bizStationFluxTransfer);
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer){
    	boolean isInsert=false;
            if(bizStationFluxTransfer.getId()==null||"".equals(bizStationFluxTransfer.getId())){
            	isInsert=true;
            }
        
        if(isInsert){
        	bizStationFluxTransfer.setId(Identities.uuid());
        	return bizStationFluxTransferMapper.saveBizStationFluxTransfer(bizStationFluxTransfer);
        }else{
        	return bizStationFluxTransferMapper.updateBizStationFluxTransfer(bizStationFluxTransfer);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteBizStationFluxTransfer(String[] id){
    	int i;
    	for(i=0;i<id.length;i++){
    		bizStationFluxTransferMapper.deleteBizStationFluxTransfer(id[i]);
    	}
    	return i;
    }
    @Override
	public void saveExcelData(MultipartFile excel) throws Exception{
		// TODO Auto-generated method stub
		String excelFileHome = System.getProperty("java.io.tmpdir");
		String name = excel.getOriginalFilename();

		String filePath = excelFileHome + File.separatorChar + name;
		
			InputStream is = excel.getInputStream();
			FileOutputStream fos = new FileOutputStream(filePath);

			byte[] b = new byte[1024];

			while ((is.read(b)) != -1) {

				fos.write(b);

			}
			excel = null;
			is.close();
			fos.close();
			
			
			// 建立连接
			Class.forName("com.esproc.jdbc.InternalDriver");

			Connection con = DriverManager.getConnection("jdbc:esproc:local://");

			// 调用存储过程，其中createTable1是dfx的文件名
			String call="call subway/transfor(?)";
			
			com.esproc.jdbc.InternalCStatement st = (com.esproc.jdbc.InternalCStatement) con.prepareCall(call);
			st.setObject(1, filePath);
			// 执行存储过程

			boolean hasResult = st.execute();
			
		
		
	}
}

