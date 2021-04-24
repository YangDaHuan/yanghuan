
package com.solidextend.sys.ticket.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.organ.service.OrganService;
import com.solidextend.sys.organ.vo.Organ;
import com.solidextend.sys.ticket.service.BizTicketApplyService;
import com.solidextend.sys.ticket.service.BizTicketDeployService;
import com.solidextend.sys.ticket.service.BizTicketInService;
import com.solidextend.sys.ticket.service.BizTicketOutService;
import com.solidextend.sys.ticket.service.BizTicketStateService;
import com.solidextend.sys.ticket.service.BizTicketStockService;
import com.solidextend.sys.ticket.service.BizTicketStockThresholdService;
import com.solidextend.sys.ticket.service.BizTicketTypeService;
import com.solidextend.sys.ticket.vo.BizTicketApply;
import com.solidextend.sys.ticket.vo.BizTicketDeploy;
import com.solidextend.sys.ticket.vo.BizTicketIn;
import com.solidextend.sys.ticket.vo.BizTicketOut;
import com.solidextend.sys.ticket.vo.BizTicketState;
import com.solidextend.sys.ticket.vo.BizTicketStockThreshold;
import com.solidextend.sys.ticket.vo.BizTicketType;

/**
 * TODO
 * @author 
 */
@RequestMapping("/ticket")
@Controller
public class TicketController{   
	private static final Log log = LogFactory.getLog(TicketController.class);
	@Resource
	private BizTicketApplyService bizTicketApplyService;
	@Resource
	private OrganService organService;
	
	
	@RequestMapping("/isApplyCodeExist")
	@ResponseBody
	public boolean isApplyCodeExist(BizTicketApply bizTicketApply){
		List<BizTicketApply> bizTicketApplyList = this.bizTicketApplyService.findByAttrBizTicketApply(bizTicketApply, null, null, null, null);
		if(bizTicketApplyList==null)return false;
		if(bizTicketApplyList.size()==0)return false;
				return true;
	}
	@RequestMapping("/TicketApplyReceive")
	public String TicketApplyReceive(){
		return "ticket/TicketApplyReceive";
	}
	@RequestMapping("/TicketApplyReceive2")
	public String TicketApplyReceive2(){
		return "ticket/TicketApplyReceive2";
	}
	@RequestMapping("/TicketApplyPaid")
	public String TicketApplyPaid(){
 		return "ticket/TicketApplyPaid";
	}
	
	@RequestMapping("/TicketApplyPaid2")
	public String TicketApplyPaid2(){
 		return "ticket/TicketApplyPaid2";
	}
	
	@RequestMapping("/TicketRecovery")
	public String TicketRecovery(){
 		return "ticket/TicketRecovery";
	}
	
	@RequestMapping("/BizTicketType")
	public String bizTicketType(){
		return "ticket/BizTicketType";
	}
	@RequestMapping("/TicketApply")
	public String TicketApply(){
		return "ticket/TicketApply";
	}
	@RequestMapping("/TicketApplyAudit")
	public String TicketApplyAudit(){
		return "ticket/TicketApplyAudit";
	}
	@RequestMapping("/TicketApplyAudit2")
	public String TicketApplyAudit2(){
		return "ticket/TicketApplyAudit2";
	}
	@RequestMapping("/TicketApplyAudited")
	public String TicketApplyAudited(){
		return "ticket/TicketApplyAudited";
	}
	
	/**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizTicketApply")
	@ResponseBody
	public JsonData findByAttrBizTicketApply(BizTicketApply bizTicketApply){
    	
    	JsonData jsonData=new JsonData();
		try{
			//bizTicketApply.setAuditingState(3);//只查询审核通过的申请单
			
			List<BizTicketApply> bizTicketApplyList = bizTicketApplyService.findByAttrBizTicketApply(bizTicketApply,null,null,null, null);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketApplyList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByOrgandGroupName")
	@ResponseBody
	public JsonData findByOrgandGroupName(@Param("toOrg") String toOrg,@Param("groupName") String groupName,
			@Param("auditingState") int auditingState,@Param("applyType") int applyType){
    	
     	JsonData jsonData=new JsonData();
		try{
			List<BizTicketApply> bizTicketApplyList = bizTicketApplyService.findByOrgandGroupName(toOrg,groupName,auditingState,applyType);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketApplyList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    /**
     * 查询出有权限审核的记录
     */
    @RequestMapping("/findByAuditBizTicketApply") 
	@ResponseBody
	public JsonData findByAuditBizTicketApply(BizTicketApply bizTicketApply,String auditingStates,@RequestParam(required=false,value="groupName") String groupName){
    	
    	JsonData jsonData=new JsonData();
    	String id=new String(bizTicketApply.getAuditingOrg());
    	bizTicketApply.setAuditingOrg(null);
    	List<Organ> parentOrgs=organService.findParentOrgan(id);
    	List<Organ> subOrgs=organService.findSubOrgan(id, null, null);
    	String[] parentOrgArray=new String[parentOrgs.size()];
    	String[] subOrgArray=new String[subOrgs.size()];
    	for(int i=0;i< parentOrgs.size();i++){
    		parentOrgArray[i]=parentOrgs.get(i).getId();
    		
    	}
    	for(int i=0;i< subOrgs.size();i++){
    		subOrgArray[i]=subOrgs.get(i).getId();
    		
    	}
		try{
			String [] auditingStateArray=null;
			if(auditingStates!=null)auditingStateArray=auditingStates.split(",");
			
			List<BizTicketApply> bizTicketApplyList = bizTicketApplyService.findByAuditBizTicketApply(subOrgArray,parentOrgArray,auditingStateArray, parentOrgArray,groupName);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketApplyList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    } 
    /**
     * 查询出有权限审核的记录
     */
    @RequestMapping("/findByAuditedBizTicketApply") 
	@ResponseBody
	public JsonData findByAuditedBizTicketApply(BizTicketApply bizTicketApply,String auditingStates){
    	
    	JsonData jsonData=new JsonData();
    	String id=new String(bizTicketApply.getAuditingOrg());
    	bizTicketApply.setAuditingOrg(null);
    	List<Organ> parentOrgs=organService.findParentOrgan(id);
    	List<Organ> subOrgs=organService.findSubOrgan(id, null, null);
    	String[] parentOrgArray=new String[parentOrgs.size()];
    	String[] subOrgArray=new String[subOrgs.size()];
    	for(int i=0;i< parentOrgs.size();i++){
    		parentOrgArray[i]=parentOrgs.get(i).getId();
    		
    	}
    	for(int i=0;i< subOrgs.size();i++){
    		subOrgArray[i]=subOrgs.get(i).getId();
    		
    	}
		try{
			String [] auditingStateArray=null;
			if(auditingStates!=null)auditingStateArray=auditingStates.split(",");
			
			List<BizTicketApply> bizTicketApplyList = bizTicketApplyService.findByAuditedBizTicketApply(subOrgArray,parentOrgArray,auditingStateArray, parentOrgArray);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketApplyList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }   
    /**
     * 审核保存
     */
    @RequestMapping("/auditBizTicketApply")
	@ResponseBody
	public JsonData auditBizTicketApply(@RequestParam(value = "applyIds[]") String[] applyIds,@RequestParam(value = "toOrgs[]") String[] toOrgs,@RequestParam(value = "auditingState") int auditingState,@RequestParam(value = "auditingOrg") String auditingOrg){
    	
    	JsonData jsonData=new JsonData();
    	
		try{
			for(int i=0;i<applyIds.length;i++){
				String applyId = applyIds[i];
				BizTicketApply bizTicketApply = new BizTicketApply();
				bizTicketApply.setApplyId(applyId);
				if(auditingOrg.equals(toOrgs[i])){
					bizTicketApply.setAuditingState(auditingState);
				}else{
					if(3==auditingState){
						bizTicketApply.setAuditingState(2);
					}else{
						bizTicketApply.setAuditingState(auditingState);
					}
				}
				bizTicketApply.setAuditingOrg(auditingOrg);
				bizTicketApplyService.saveBizTicketApply(bizTicketApply,false);
				
			}
			jsonData.setSuccess(true);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }  
    /**
     * 保存
     */
    @RequestMapping("/saveBizTicketApply")
	@ResponseBody
	public JsonData saveBizTicketApply(String jsonStr){
    	JsonData jsonData = new JsonData();
		try {
			 ObjectMapper objectMapper = new ObjectMapper();
				String datePattern="YYYY-MM-DD";
				objectMapper.setDateFormat(new SimpleDateFormat(datePattern));
		        //允许字段名字不使用引号
		        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
		        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		        //允许单引号
		        objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
		        // 忽略未识别的参数(解决json串中多属性，而类中又未定义的情况)
		        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		        //将对象转换成string时，json的key是否按照对象的field的自然顺序排列
		        objectMapper.configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, false);
			 BizTicketApply bizTicketApply=objectMapper.readValue(jsonStr, BizTicketApply.class);
			 String applyCode = this.bizTicketApplyService.saveBizTicketApply(bizTicketApply,true);
			jsonData.setSuccess(true);
			jsonData.setExtData(null);
			jsonData.setMsg(applyCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("", e);
			jsonData.setSuccess(false);
			jsonData.setMsg("提交数据时出现内部错误");
		}
		
		
		
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizTicketApply")
	@ResponseBody
	public JsonData deleteBizTicketApply(@RequestParam(value = "applyId[]") String[] applyId){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketApplyService.deleteBizTicketApply(applyId);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    
    @Resource
	private BizTicketTypeService bizTicketTypeService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizTicketType")
	@ResponseBody
	public JsonData findByAttrBizTicketType(BizTicketType bizTicketType){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizTicketType> bizTicketTypeList = bizTicketTypeService.findByAttrBizTicketType(bizTicketType);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketTypeList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizTicketType")
	@ResponseBody
	public JsonData saveBizTicketType(BizTicketType bizTicketType){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketTypeService.saveBizTicketType(bizTicketType);
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
    @RequestMapping("/deleteBizTicketType")
	@ResponseBody
	public JsonData deleteBizTicketType(@RequestParam(value = "ticketTypeId[]") String[] ticketTypeId){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketTypeService.deleteBizTicketType(ticketTypeId);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    
    @RequestMapping("/BizTicketState")
	public String BizTicketState(){
		return "ticket/BizTicketState";
	}
	

	@Resource
	private BizTicketStateService bizTicketStateService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizTicketState")
	@ResponseBody
	public JsonData findByAttrBizTicketState(BizTicketState bizTicketState){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizTicketState> bizTicketStateList = bizTicketStateService.findByAttrBizTicketState(bizTicketState);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketStateList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizTicketState")
	@ResponseBody
	public JsonData saveBizTicketState(BizTicketState bizTicketState){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketStateService.saveBizTicketState(bizTicketState);
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
    @RequestMapping("/deleteBizTicketState")
	@ResponseBody
	public JsonData deleteBizTicketState(@RequestParam(value = "ticketStateId[]") String[] ticketStateId){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketStateService.deleteBizTicketState(ticketStateId);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    
    
    @RequestMapping("/TicketDeployAbout")
	public String TicketDeployAbout(){
		return "ticket/TicketDeployAbout";
	}
    @RequestMapping("/TicketDeploy")
	public String TicketDeploy(Map<String, String> map){
    			return "ticket/TicketDeploy";
	}
    @RequestMapping("/TicketDeploy2")
   	public String TicketDeploy2(Map<String, String> map){
       			return "ticket/TicketDeploy2";
   	}
    
	@Resource
	private BizTicketDeployService bizTicketDeployService;
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizTicketDeploy")
	@ResponseBody
	public JsonData findByAttrBizTicketDeploy(BizTicketDeploy bizTicketDeploy){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizTicketDeploy> bizTicketDeployList = bizTicketDeployService.findByAttrBizTicketDeploy(bizTicketDeploy);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketDeployList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    /**
     * 
     * 查询调配单号和申请上交单号
     * @return
     */
    @RequestMapping("/findByAttrBizTicketDeployAndApply")
   	@ResponseBody
   	public JsonData findByAttrBizTicketDeployAndApply(BizTicketDeploy bizTicketDeploy,@RequestParam(required=false,value="auditingState") Integer auditingState,
   						@RequestParam(required=false,value="groupName") String groupName){
       	
       	JsonData jsonData=new JsonData();
   		try{
   			List<BizTicketDeploy> bizTicketDeployList = bizTicketDeployService.findByAttrBizTicketDeployAndApply(bizTicketDeploy,auditingState,groupName);
   			jsonData.setSuccess(true);
   			jsonData.setExtData(bizTicketDeployList);
   		}catch(Exception e){
   			jsonData.setSuccess(false);
   			jsonData.setMsg(e.getMessage());
   		}
   		return jsonData;
       }    
    /**
     * 查询出所有和调配部门相关的记录
     */
    @RequestMapping("/findByAboutBizTicketDeploy")
	@ResponseBody
	public JsonData findByAboutBizTicketDeploy(BizTicketDeploy bizTicketDeploy){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizTicketDeploy> bizTicketDeployList = bizTicketDeployService.findByAboutBizTicketDeploy(bizTicketDeploy);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketDeployList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    /**
     * 保存
     */
    @RequestMapping("/saveBizTicketDeploy")
	@ResponseBody
	public JsonData saveBizTicketDeploy(String jsonStr){
    	JsonData jsonData=new JsonData();
		try{
			ObjectMapper objectMapper = new ObjectMapper();
			String datePattern="YYYY-MM-DD";
			objectMapper.setDateFormat(new SimpleDateFormat(datePattern));
	        //允许字段名字不使用引号
	        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
	        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
	        //允许单引号
	        objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
	        // 忽略未识别的参数(解决json串中多属性，而类中又未定义的情况)
	        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	        //将对象转换成string时，json的key是否按照对象的field的自然顺序排列
	        objectMapper.configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, false);
			BizTicketDeploy bizTicketDeploy=objectMapper.readValue(jsonStr, BizTicketDeploy.class);
			 String deployCode = bizTicketDeployService.saveBizTicketDeploy(bizTicketDeploy,true);
			jsonData.setSuccess(true);
			jsonData.setMsg(deployCode);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
			log.error(e);
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizTicketDeploy")
	@ResponseBody
	public JsonData deleteBizTicketDeploy(@RequestParam(value = "deployId[]") String[] deployId){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketDeployService.deleteBizTicketDeploy(deployId);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    
    /**
     * 票卡入库单
     */
    @Resource
    private BizTicketInService bizTicketInService;
    
    @RequestMapping("/TicketIn")// 票卡入库 * 杨欢
   	public String TicketIn(Map<String, String> map){
    	String newTicketInCode = bizTicketInService.getNewBizTicketInCode();
    	map.put("newTicketInCode", newTicketInCode);
   		return "ticket/TicketIn";
   	}
    
    @RequestMapping("/TicketIn2")// 票卡出库单  杨欢
   	public String TicketIn2(){
   		return "ticket/TicketIn2";
   	}
    
    @RequestMapping("/TicketInAdjustment")// 票卡调整入库 * 杨欢
   	public String TicketInAdjustment(Map<String, String> map){
    	String newTicketInCode = bizTicketInService.getNewBizTicketInCode();
    	map.put("newTicketInCode", newTicketInCode);
   		return "ticket/TicketInAdjustment";
   	}
    
    @RequestMapping("/TicketInAdjustment2")// 票卡调整入库 * 杨欢
   	public String TicketInAdjustment2(){
   		return "ticket/TicketInAdjustment2";
   	}
    
    @ResponseBody
    @RequestMapping("/isInCodeExist")
    public Boolean isInCodeExist(BizTicketIn bizTicketIn) {
    	Long count = bizTicketInService.getCountByCode(bizTicketIn.getInCode());
    	if(count>=1) return true;
    	if(count==null) return false;
    	return false;
    }
    
    @RequestMapping("/saveTicketIn")
    @ResponseBody
    @Transactional
    public JsonData saveBizTicketIN(String jsonStr) {
    	JsonData jsonData=new JsonData();
    	
		try{
			ObjectMapper objectMapper = new ObjectMapper();
			String datePattern="YYYY-MM-DD";
			objectMapper.setDateFormat(new SimpleDateFormat(datePattern));
	        //允许字段名字不使用引号
	        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
	        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
	        //允许单引号
	        objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
	        // 忽略未识别的参数(解决json串中多属性，而类中又未定义的情况)
	        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	        //将对象转换成string时，json的key是否按照对象的field的自然顺序排列
	        objectMapper.configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, false);
			BizTicketIn bizTicketIn=objectMapper.readValue(jsonStr, BizTicketIn.class);
			String inCode=bizTicketInService.saveBizTicketIn(bizTicketIn,true);
			jsonData.setSuccess(true);
			jsonData.setMsg(inCode);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
			log.error(e);
		}
		return jsonData;
		}
    
    
    /**
     * 票卡出库单
     */
    @Resource
    private BizTicketOutService bizTicketOutService;
    
    @Resource
    private BizTicketStockService bizTicketStockService;
    
    @RequestMapping("/TicketOut")// 票卡出库单  杨欢
   	public String TicketOut(Map<String, String> map){
    	String newTicketOutCode = bizTicketOutService.getNewBizTicketOutCode();
    	map.put("newTicketOutCode", newTicketOutCode);
   		return "ticket/TicketOut";
   	}
    
    @RequestMapping("/TicketOut2")// 票卡出库单  杨欢
   	public String TicketOut2(){
   		return "ticket/TicketOut2";
   	}
    
    @RequestMapping("/TicketOutAdjustment")// 票卡调整出库 * 杨欢
   	public String TicketOutAdjustment(Map<String, String> map){
    	String newTicketOutCode = bizTicketOutService.getNewBizTicketOutCode();
    	map.put("newTicketOutCode", newTicketOutCode);
   		return "ticket/TicketOutAdjustment";
   	}
    
    @RequestMapping("/TicketOutAdjustment2")// 票卡调整出库 * 杨欢
   	public String TicketOutAdjustment2(){
   		return "ticket/TicketOutAdjustment2";
   	}
    
    @RequestMapping("/saveTicketOut")
    @ResponseBody
    public JsonData saveBizTicketOut(String jsonStr) {
    	JsonData jsonData=new JsonData();
    	
		try{
			ObjectMapper objectMapper = new ObjectMapper();
			String datePattern="YYYY-MM-DD";
			objectMapper.setDateFormat(new SimpleDateFormat(datePattern));
	        //允许字段名字不使用引号
	        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
	        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
	        //允许单引号
	        objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
	        // 忽略未识别的参数(解决json串中多属性，而类中又未定义的情况)
	        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	        //将对象转换成string时，json的key是否按照对象的field的自然顺序排列
	        objectMapper.configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, false);
			BizTicketOut bizTicketOut=objectMapper.readValue(jsonStr, BizTicketOut.class);
			
			String outCode = bizTicketOutService.saveBizTicketOut(bizTicketOut,true);
			if(outCode.equals("")) {
				jsonData.setMsg("库存不足");
			}
			jsonData.setSuccess(true);
			jsonData.setMsg(outCode);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
			log.error(e);
		}
		return jsonData;
		}
    
    @ResponseBody
    @RequestMapping("/isOutCodeExist")
    public Boolean isOutCodeExist(BizTicketOut bizTicketOut) {
    	Long count = bizTicketOutService.getCountByCode(bizTicketOut.getOutCode());
    	if(count>=1) return true;
    	if(count==null) return false;
    	return false;
    }
    
    /**
     * 库存阀值
     * @return
     */
    @RequestMapping("/bizTicketStockThreshold")
	public String bizTicketStockThreshold(){
		return "ticket/BizTicketStockThreshold";
	}

    
    
	@Resource
	private BizTicketStockThresholdService bizTicketStockThresholdService;
	
    
    /**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByAttrBizTicketStockThreshold")
	@ResponseBody
	public JsonData findByAttrBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold){
    	
    	JsonData jsonData=new JsonData();
		try{
			List<BizTicketStockThreshold> bizTicketStockThresholdList = bizTicketStockThresholdService.findByAttrBizTicketStockThreshold(bizTicketStockThreshold);
			jsonData.setSuccess(true);
			jsonData.setExtData(bizTicketStockThresholdList);
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @RequestMapping("/saveBizTicketStockThreshold")
	@ResponseBody
	public JsonData saveBizTicketStockThreshold(BizTicketStockThreshold bizTicketStockThreshold){
    	JsonData jsonData=new JsonData();
		try{
			long i = bizTicketStockThresholdService.hasTicketStockThreshold(bizTicketStockThreshold);
			if(i!=0) {
				jsonData.setMsg("该票种阀值已存在！");
				jsonData.setSuccess(true);
			}else {
			bizTicketStockThresholdService.saveBizTicketStockThreshold(bizTicketStockThreshold);
			jsonData.setSuccess(true);
			}
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    	
    }
    
    /**
     * 根据主键删除
     */
    @RequestMapping("/deleteBizTicketStockThreshold")
	@ResponseBody
	public JsonData deleteBizTicketStockThreshold(@RequestParam(value = "stockId[]") String[] stockId){
    	JsonData jsonData=new JsonData();
		try{
			bizTicketStockThresholdService.deleteBizTicketStockThreshold(stockId);
			jsonData.setSuccess(true);
			
		}catch(Exception e){
			jsonData.setSuccess(false);
			jsonData.setMsg(e.getMessage());
		}
		return jsonData;
    }
    
}

