package com.solidextend.sys.raqsoft.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.raqsoft.report.ide.base.DataSourceDefine;
import com.raqsoft.report.usermodel.Context;
import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.raqsoft.service.RaqsoftService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.raqsoft.vo.RaqSoftDataSource;
import com.solidextend.sys.raqsoft.vo.ReportFile;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;

/**
 * @author songjunjie
 * @version 2014-1-6 上午10:29:00
 */
@Controller
@RequestMapping("/raqsoft")
public class RaqsoftController {
	private static final Log log = LogFactory.getLog(RaqsoftController.class);
	@Resource
	private RaqsoftService raqsoftService;

	/**
	 * 报表管理主页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "raqsoft/resourceManager";
	} 

	/**
	 * 根据扩展名查询出报表根目录的所有文件和文件夹。
	 * 
	 * @param request
	 * @param fileSuffix
	 *            如果没有指定此参数返回所有的文件
	 * @return
	 */
	@RequestMapping("/getReportFileList")
	@ResponseBody
	public List<ReportFile> getReportFileList(HttpServletRequest request,String fileSuffix) {
		List<ReportFile> rf=raqsoftService.getReportFileList(fileSuffix);
		
		
		return rf;
	}
	
	/**
	 * 根据扩展名查询出报表根目录的所有文件和文件夹。
	 * 
	 * @param request
	 * @param fileSuffix
	 *            如果没有指定此参数返回所有的文件
	 * @return
	 */
	@RequestMapping("/getFileListByPid")
	@ResponseBody
	public List<ReportFile> getFileListByPid(HttpServletRequest request,String pid,String fileSuffix) {
		if(pid==null)pid="/";
		List<ReportFile> rf=raqsoftService.getFileList(pid,fileSuffix);
		
		
		return rf;
	}
	/**
	 * 上传报表模板
	 * @return
	 */
	@RequestMapping("/uploadFile")
	@ResponseBody
	public JsonData uploadFile(String path,@RequestParam MultipartFile file){
		JsonData jsonData = new JsonData();
		
		
		try{
			this.raqsoftService.saveReportFile(path,file);
			jsonData.setSuccess(true);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
	}
	/**
	 * 下载文件
	 * @return
	 */
	@RequestMapping("/download")
	public String download(String fileName,String filePath,HttpServletResponse response){
		
		return this.raqsoftService.download(fileName, filePath, response);
	}
	/**
	 * 删除文件
	 * @return
	 */
	@RequestMapping("/deleteFile")
	@ResponseBody
	public JsonData deleteFile(String filePaths){
		
		JsonData jsonData = new JsonData();
		String msg="";
		boolean success=true;
		String[] filePathList=filePaths.split(",");
		for(String filePath:filePathList){
			if(filePath==null||filePath.length()==0)break;
			if(this.raqsoftService.deleteFile(filePath)){
				msg+="<br>删除"+filePath+"成功";
			}else{
				success=false;
				msg+="<br>删除"+filePath+"失败";
			}
		}
		jsonData.setSuccess(success);
		jsonData.setMsg(msg);
		return jsonData;
	}
	/**
	 * 新建文件夹
	 * @return
	 */
	@RequestMapping("/createFolder")
	@ResponseBody
	public JsonData createFolder(String path,String folderName){
		
		JsonData jsonData = new JsonData();
		jsonData.setSuccess(this.raqsoftService.creatFolder(path, folderName));
		return jsonData;
	}
	/**
	 * 修改名称
	 * @return
	 */
	@RequestMapping("/rename")
	@ResponseBody
	public JsonData rename(String path,String oldName,String newName){
		
		JsonData jsonData = new JsonData();
		if(this.raqsoftService.fileExists(path, newName)){
			jsonData.setSuccess(false);
			jsonData.setMsg("该文件夹下同名文件已存在，请更换名称");
		}else{
			if(this.raqsoftService.renameTo(path, oldName, path, newName)){
				jsonData.setSuccess(true);
			}else{
				jsonData.setSuccess(false);
				jsonData.setMsg("修改名称时出现错误");
			}
		}
		return jsonData;
	}
	/**
	 * 修改目录
	 * @return
	 */
	@RequestMapping("/repath")
	@ResponseBody
	public JsonData rePath(String newPath,String oldPath,String names){
		
		JsonData jsonData = new JsonData();
		String msg="";
		boolean success=true;
		String[] nameList=names.split(",");
		for(String name:nameList){
			if(name==null||name.length()==0)break;
			if(this.raqsoftService.fileExists(newPath, name)){
				success=false;
				msg+="<br>"+name+"目标文件夹下同名文件已存在";
			}else{
				if(this.raqsoftService.renameTo(oldPath, name, newPath, name)){
					msg+="<br>"+name+"修改目录成功";
				}else{
					success=false;
					msg+="<br>"+name+"修改目录时出现错误";
				}
			}
		}
		jsonData.setSuccess(success);
		jsonData.setMsg(msg);
		return jsonData;
	}
	/**
	 * 执行集算器
	 * @return
	 */
	@RequestMapping("/getData")
	@ResponseBody
	public JsonData getData(String dfx,String params){
		List<Object> param=new ArrayList<Object>();
		JsonData jsonData = new JsonData();
		String msg="";
		boolean success=true;
		try{
			jsonData.setRows(this.raqsoftService.runDfx(dfx, param));
		}catch(Exception e){
			success=false;
			msg=e.getMessage();
			log.error(e);
		}
		jsonData.setSuccess(success);
		jsonData.setMsg(msg);
		return jsonData;
	}
	/**
	 * 数据源管理主页面
	 * 
	 * @return
	 */
	@RequestMapping("/dataSource")
	public String dataSource() {
		return "raqsoft/dataSourceManager";
	} 
	/**
	 * 查询数据源配置列表
	 * @return
	 */
	@RequestMapping("/getDataSourceList")
	@ResponseBody 
	public JsonData getDataSourceList(HttpServletRequest request){
		List<Object> param=new ArrayList<Object>();
		JsonData jsonData = new JsonData();
		String msg=""; 
		
		boolean success=true;
		jsonData.setRows(this.raqsoftService.getDataSourceList(request));
		jsonData.setSuccess(success);
		jsonData.setMsg(msg);
		return jsonData; 
	}
	/**
	 * 修改数据源配置
	 * @return
	 */
	@RequestMapping("/saveDataSource")
	@ResponseBody 
	public JsonData saveDataSource(HttpServletRequest request,RaqSoftDataSource dsoc,String editType){
		JsonData jsonData = new JsonData();
		ServletContext sc=request.getSession().getServletContext();
		String msg=""; 
		boolean success;
		if("1".equals(editType)){
			success=this.raqsoftService.updateDataSource(sc,dsoc);
		}else{
			success=this.raqsoftService.addDataSource(sc,dsoc);
		}
		
		jsonData.setSuccess(success);
		jsonData.setMsg(msg);
		return jsonData; 
	}
	/**
	 * 删除数据源配置
	 * @return
	 */
	@RequestMapping("/deleteDataSource")
	@ResponseBody 
	public JsonData deleteDataSource(HttpServletRequest request,String names){
		JsonData jsonData = new JsonData();
		ServletContext sc=request.getSession().getServletContext();
		String msg=""; 
		boolean success=true;
		String[] nameList=names.split(",");
		for(String name :nameList){
			if(this.raqsoftService.deleteDataSource(sc, name)){
				success=true;
			}else{
				success=false;
				
				msg="delete datasource error at "+name;
			}
		}
		
		jsonData.setSuccess(success);
		jsonData.setMsg(msg);
		return jsonData; 
	}
	/**
	 * 测试数据源配置
	 * @return
	 */
	@RequestMapping("/testDataSource")
	@ResponseBody 
	public JsonData testDataSource(RaqSoftDataSource dsoc){
		JsonData jsonData = new JsonData();
		
		try{
			Class.forName(dsoc.getDriver());
			Connection con=DriverManager.getConnection(dsoc.getUrl(),dsoc.getUser(),dsoc.getPassword());
			if(con==null){
				jsonData.setSuccess(false);
				jsonData.setMsg("连接为空");
			}else{
				jsonData.setSuccess(true);
				jsonData.setMsg("连接成功");
			}
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		
		return jsonData; 
	}
	
}
