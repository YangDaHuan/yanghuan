package com.solidextend.sys.df.controller;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.df.service.DFService;
import com.solidextend.sys.df.vo.ConfigInfo;

/**
 * DF版本升级程序
 * @author 一代魔笛
 * @version 1.0
 */
@Controller
@RequestMapping("dfcode/update")
public class DFUpdateController {

	/** 当前版本号 */
	public static final String DF_VERSION = "2014-04-15 15:45";
	
	protected static final Log log = LogFactory.getLog(DFUpdateController.class);
	
	@Resource
	private DFService dFService;
	
	@RequestMapping("check")
	@ResponseBody
	public JsonData check(){
		JsonData jsonData = new JsonData();
		try{
			ConfigInfo configInfo = dFService.getConfigById("1");
			jsonData.setSuccess(true);
			jsonData.setTotal(DFUpdateController.DF_VERSION.compareTo(StringUtils.defaultString(configInfo.getVersion())));
		}catch(Exception e){
			log.error("系统版本检查失败", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("检查失败，请重试");
		}
		return jsonData;
	}
	
	@RequestMapping
	@ResponseBody
	public JsonData update(){
		JsonData jsonData = new JsonData();		
		boolean bool = false;
		ConfigInfo configInfo = dFService.getConfigById("1");
		if(configInfo.getVersion().compareToIgnoreCase("2014-04-01 11:15")<0) bool = U201404011115();
		if(configInfo.getVersion().compareToIgnoreCase("2014-04-08 10:02")<0) bool = U201404081002();
		if(configInfo.getVersion().compareToIgnoreCase("2014-04-15 10:00")<0) bool = U201404151000();
		if(configInfo.getVersion().compareToIgnoreCase("2014-04-15 15:45")<0) bool = U201404151545();
		if(bool){
			configInfo.setVersion(DF_VERSION);
			dFService.updateConfig(configInfo);
		}
		jsonData.setSuccess(bool);		
		return jsonData;
	}
	/**
	 * DF_FIELD表中增加ALLOW_ADD(允许新建)、ALLOW_UPDATE(允许修改)、ALLOW_VALUE(新建默认值)字段
	 * @return boolean
	 */
	public boolean U201404151545(){
		boolean bool = false;
		log.info("执行U201404151545更新包...");
		try{			
			dFService.createTable("ALTER TABLE DF_FIELD ADD (" +
					"ALLOW_ADD CHAR(1) DEFAULT 1 NOT NULL," +
					"ALLOW_UPDATE CHAR(1) DEFAULT 1 NOT NULL," +
					"ALLOW_VALUE VARCHAR2(200) NULL " +
			")");
			bool = true;
		}catch(Exception e){
			log.error("更新包U201404151545执行失败",e);			
		}
		return bool;
	}
	/**
	 * DF_FORM表中增加ACTION_ADD(新建操作)、ACTION_UPDATE(修改操作)、ACTION_DELETE(删除操作)、
	 * ACTION_IMP(导入操作)、ACTION_EXP(导出操作)字段
	 * @return boolean
	 */
	public boolean U201404151000(){
		boolean bool = false;
		log.info("执行U201404151000更新包...");
		try{			
			dFService.createTable("ALTER TABLE DF_FORM ADD (" +
					"ACTION_ADD CHAR(1) DEFAULT 1 NOT NULL," +
					"ACTION_UPDATE CHAR(1) DEFAULT 1 NOT NULL," +
					"ACTION_DELETE CHAR(1) DEFAULT 1 NOT NULL," +
					"ACTION_IMP CHAR(1) DEFAULT 0 NOT NULL," +
					"ACTION_EXP CHAR(1) DEFAULT 0 NOT NULL" +
			")");
			bool = true;
		}catch(Exception e){
			log.error("更新包U201404151000执行失败",e);			
		}
		return bool;
	}
	/**
	 * DF_FORM表中增加FILE_UPLOAD(文件上传标识)字段
	 * @return boolean
	 */
	public boolean U201404081002(){
		boolean bool = false;
		log.info("执行U201404081002更新包...");
		try{			
			dFService.createTable("ALTER TABLE DF_FORM ADD (FILE_UPLOAD CHAR(1) DEFAULT 0 NOT NULL)");
			bool = true;
		}catch(Exception e){
			log.error("更新包U201404081002执行失败",e);			
		}
		return bool;
	}
	/**
	 * 修改数据源相关属性的字段长度
	 * @return boolean
	 */
	public boolean U201404011115(){
		boolean bool = false;
		log.info("执行U201404011115更新包...");
		try{			
			dFService.createTable("ALTER TABLE DF_FIELD MODIFY(DS_URL_VAL VARCHAR(50))");
			dFService.createTable("ALTER TABLE DF_FIELD MODIFY(DS_URL_TEXT VARCHAR(50))");
			bool = true;
		}catch(Exception e){
			log.error("更新包U201404011115执行失败",e);			
		}
		return bool;
	}
}
