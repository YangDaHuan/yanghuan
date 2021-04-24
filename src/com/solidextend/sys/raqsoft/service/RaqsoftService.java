package com.solidextend.sys.raqsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.raqsoft.report.ide.base.DataSourceDefine;
import com.solidextend.sys.raqsoft.vo.RaqSoftDataSource;
import com.solidextend.sys.raqsoft.vo.ReportFile;

public interface RaqsoftService {
	public List<ReportFile> getReportFileList(String fileSuffix );
	public List<ReportFile> getFileList(String pid,String fileSuffix );
	public void saveReportFile(String path, MultipartFile report);
	public boolean creatFolder(String path,String folderName);
	
	public String download(String fileName,String filePath,HttpServletResponse response) ;
	public boolean deleteFile(String filePath);
	public boolean fileExists(String path,String name);
	public boolean renameTo(String oldPath,String oldName,String newPath,String newName);
	public List<List<Map<String,Object>>> runDfx(String dfx,List<Object> param) throws Exception;
	
	
	public List<RaqSoftDataSource> getDataSourceList(HttpServletRequest request);
	public boolean addDataSource(ServletContext sc,RaqSoftDataSource ds);
	public boolean deleteDataSource(ServletContext sc,String dsName);
	public boolean updateDataSource(ServletContext sc,RaqSoftDataSource ds);
	
	
}
