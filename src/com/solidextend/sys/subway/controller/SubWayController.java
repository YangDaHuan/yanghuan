
package com.solidextend.sys.subway.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.solidextend.sys.subway.vo.BizStationFluxSection;
import com.solidextend.sys.subway.vo.BizStationFluxSumm;
import com.solidextend.sys.subway.vo.BizStationFluxTransfer;
import com.solidextend.sys.subway.vo.BizStationFluxLimitWeb;
import com.solidextend.sys.subway.vo.BizStationFluxCardinalWeb;
import com.solidextend.sys.subway.vo.BizStationFluxDatetransfer;

import com.solidextend.sys.subway.service.BizStationFluxCardinalWebService;
import com.solidextend.sys.subway.service.BizStationFluxDatetransferService;
import com.solidextend.sys.subway.service.BizStationFluxLimitWebService;
import com.solidextend.sys.subway.service.BizStationFluxSectionService;
import com.solidextend.sys.subway.service.BizStationFluxSummService;
import com.solidextend.sys.subway.service.BizStationFluxTransferService;

import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.solidextend.core.web.JsonData;

/**
 * TODO
 * @author 
 */
@RequestMapping("/subway")
@Controller
public class SubWayController{   
	private static final Log log = LogFactory.getLog(SubWayController.class);
	
	/**
	 * 上传Excel
	 * @return
	 */
	@RequestMapping("/uploadExcel")
	@ResponseBody
	public JsonData uploadFile(String excelType,@RequestParam MultipartFile file){
		JsonData jsonData = new JsonData();
		
		
		try{
			if("transfor".equals(excelType)){
				this.bizStationFluxTransferService.saveExcelData(file);
			}else if("section".equals(excelType)){
				this.bizStationFluxSectionService.saveExcelData(file);
			}
			jsonData.setSuccess(true);
		}catch(Exception e){
			log.error(e);
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
	}
	
	@RequestMapping("/index")
	public String index(){
		return "subway/beijing";
	}
	
	@RequestMapping("/BizStationFluxSection")
	public String BizStationFluxSection(){
		return "subway/BizStationFluxSection";
	}
	

	@Resource
	private BizStationFluxSectionService bizStationFluxSectionService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizStationFluxSection")
	@ResponseBody
	public JsonData findByAttrBizStationFluxSection(BizStationFluxSection bizStationFluxSection){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizStationFluxSection> bizStationFluxSectionList = bizStationFluxSectionService.findByAttrBizStationFluxSection(bizStationFluxSection);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxSectionList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizStationFluxSection")
	@ResponseBody
	public JsonData saveBizStationFluxSection(BizStationFluxSection bizStationFluxSection){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxSectionService.saveBizStationFluxSection(bizStationFluxSection);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizStationFluxSection")
	@ResponseBody
	public JsonData deleteBizStationFluxSection(@RequestParam(value = "id[]") String[] id){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxSectionService.deleteBizStationFluxSection(id);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    @RequestMapping("/BizStationFluxSumm")
	public String BizStationFluxSumm(){
		return "subway/BizStationFluxSumm";
	}
	

	@Resource
	private BizStationFluxSummService bizStationFluxSummService;
	

    /**
     * 查询出所有符合条件的站点信息
     */
    @RequestMapping("/getStationInfo")
	@ResponseBody
	public JsonData getStationInfo(BizStationFluxSumm bizStationFluxSumm){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<Map> bizStationFluxSummList = bizStationFluxSummService.getStationInfo(bizStationFluxSumm);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxSummList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizStationFluxSumm")
	@ResponseBody
	public JsonData findByAttrBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizStationFluxSumm> bizStationFluxSummList = bizStationFluxSummService.findByAttrBizStationFluxSumm(bizStationFluxSumm);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxSummList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizStationFluxSumm")
	@ResponseBody
	public JsonData saveBizStationFluxSumm(BizStationFluxSumm bizStationFluxSumm){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxSummService.saveBizStationFluxSumm(bizStationFluxSumm);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizStationFluxSumm")
	@ResponseBody
	public JsonData deleteBizStationFluxSumm(@RequestParam(value = "id[]") String[] id){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxSummService.deleteBizStationFluxSumm(id);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    @RequestMapping("/BizStationFluxTransfer")
	public String BizStationFluxTransfer(){
		return "subway/BizStationFluxTransfer";
	}
	

	@Resource
	private BizStationFluxTransferService bizStationFluxTransferService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizStationFluxTransfer")
	@ResponseBody
	public JsonData findByAttrBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizStationFluxTransfer> bizStationFluxTransferList = bizStationFluxTransferService.findByAttrBizStationFluxTransfer(bizStationFluxTransfer);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxTransferList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizStationFluxTransfer")
	@ResponseBody
	public JsonData saveBizStationFluxTransfer(BizStationFluxTransfer bizStationFluxTransfer){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxTransferService.saveBizStationFluxTransfer(bizStationFluxTransfer);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizStationFluxTransfer")
	@ResponseBody
	public JsonData deleteBizStationFluxTransfer(@RequestParam(value = "id[]") String[] id){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxTransferService.deleteBizStationFluxTransfer(id);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    
    @RequestMapping("/BizStationFluxLimitWeb")
	public String BizStationFluxLimitWeb(){
		return "subway/BizStationFluxLimitWeb";
	}
	

	@Resource
	private BizStationFluxLimitWebService bizStationFluxLimitWebService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizStationFluxLimitWeb")
	@ResponseBody
	public JsonData findByAttrBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizStationFluxLimitWeb> bizStationFluxLimitWebList = bizStationFluxLimitWebService.findByAttrBizStationFluxLimitWeb(bizStationFluxLimitWeb);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxLimitWebList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizStationFluxLimitWeb")
	@ResponseBody
	public JsonData saveBizStationFluxLimitWeb(BizStationFluxLimitWeb bizStationFluxLimitWeb){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxLimitWeb.setUpdateTime(new Timestamp(new Date().getTime()));
			bizStationFluxLimitWebService.saveBizStationFluxLimitWeb(bizStationFluxLimitWeb);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizStationFluxLimitWeb")
	@ResponseBody
	public JsonData deleteBizStationFluxLimitWeb(@RequestParam(value = "id[]") String[] id){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxLimitWebService.deleteBizStationFluxLimitWeb(id);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    @RequestMapping("/BizStationFluxCardinalWeb")
	public String BizStationFluxCardinalWeb(){
		return "subway/BizStationFluxCardinalWeb";
	}
	

	@Resource
	private BizStationFluxCardinalWebService bizStationFluxCardinalWebService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizStationFluxCardinalWeb")
	@ResponseBody
	public JsonData findByAttrBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizStationFluxCardinalWeb> bizStationFluxCardinalWebList = bizStationFluxCardinalWebService.findByAttrBizStationFluxCardinalWeb(bizStationFluxCardinalWeb);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxCardinalWebList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizStationFluxCardinalWeb")
	@ResponseBody
	public JsonData saveBizStationFluxCardinalWeb(BizStationFluxCardinalWeb bizStationFluxCardinalWeb){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxCardinalWeb.setUpdateTime(new Timestamp(new Date().getTime()));
			bizStationFluxCardinalWebService.saveBizStationFluxCardinalWeb(bizStationFluxCardinalWeb);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizStationFluxCardinalWeb")
	@ResponseBody
	public JsonData deleteBizStationFluxCardinalWeb(@RequestParam(value = "id[]") String[] id){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxCardinalWebService.deleteBizStationFluxCardinalWeb(id);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    @RequestMapping("/BizStationFluxDatetransfer")
	public String BizStationFluxDatetransfer(){
    	
		return "subway/BizStationFluxDatetransfer";
	}
	

	@Resource
	private BizStationFluxDatetransferService bizStationFluxDatetransferService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizStationFluxDatetransfer")
	@ResponseBody
	public JsonData findByAttrBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizStationFluxDatetransfer> bizStationFluxDatetransferList = bizStationFluxDatetransferService.findByAttrBizStationFluxDatetransfer(bizStationFluxDatetransfer);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizStationFluxDatetransferList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizStationFluxDatetransfer")
	@ResponseBody
	public JsonData saveBizStationFluxDatetransfer(BizStationFluxDatetransfer bizStationFluxDatetransfer){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxDatetransfer.setUpdateTime(new Timestamp(new Date().getTime()));
			bizStationFluxDatetransferService.saveBizStationFluxDatetransfer(bizStationFluxDatetransfer);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizStationFluxDatetransfer")
	@ResponseBody
	public JsonData deleteBizStationFluxDatetransfer(@RequestParam(value = "id[]") String[] id){
    	JsonData jsonData=new JsonData();
		try{
			bizStationFluxDatetransferService.deleteBizStationFluxDatetransfer(id);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
}

