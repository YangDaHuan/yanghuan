package com.solidextend.sys.prompt.controller;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.prompt.service.PromptMsgService;
import com.solidextend.sys.prompt.vo.PromptMsg;

/**
 * 系统提示信息Controller
 * @author songjunjie
 * @version 2013-12-20 上午10:01:30
 */
@Controller
@RequestMapping("/promptMsg")
public class PromptMsgController {
	private static final Log log = LogFactory.getLog(PromptMsgController.class);
	@Resource
	private PromptMsgService promptMsgService;
	
	/**
	 * 系统提示信息管理首页面
	 * @return
	 */
	@RequestMapping("/promptMsgIndex")
	public String index(){
		return "promptMsgIndex";
	}
	
	/**
	 * @param pageParam
	 * @param promptMsg
	 * @return
	 */
	@RequestMapping("/findPromptMsg")
	@ResponseBody
	public JsonData findPromptMsg(PageParam pageParam , PromptMsg promptMsg){
		JsonData jsonData = new JsonData();
		jsonData = this.promptMsgService.findPromptMsg(pageParam,promptMsg);
		jsonData.setSuccess(true);
		jsonData.setMsg("操作成功");
//		try {
//			jsonData = this.promptMsgService.findPromptMsg(pageParam,promptMsg);
//			jsonData.setSuccess(true);
//			jsonData.setMsg("操作成功");
//		} catch (Exception e) {
//			log.error("",e);
//			jsonData.setSuccess(false);
//			jsonData.setMsg("操作失败");
//			jsonData.setException(e);
//		}
		return jsonData;
	}
	
	/**
	 * 保存提示信息
	 * @param promptMsg
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(PromptMsg promptMsg){
		JsonData jsonData = new JsonData();
		try {
			this.promptMsgService.save(promptMsg);
			jsonData.setSuccess(true);
			jsonData.setMsg("操作成功");
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("操作失败");
			jsonData.setException(e);
		}
		return jsonData;
	}
	
	/**
	 * 更新提示信息
	 * @param promptMsg
	 * @return
	 */
	@RequestMapping("/update")
	@ResponseBody
	public JsonData update(PromptMsg promptMsg){
		JsonData jsonData = new JsonData();
		this.promptMsgService.updateById(promptMsg);
		jsonData.setSuccess(true);
		jsonData.setMsg("操作成功");
		return jsonData;
	}
	
	/**
	 * 删除提示信息
	 * @param id
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public JsonData delete(String id){
		JsonData jsonData = new JsonData();
		this.promptMsgService.deleteById(id);
		jsonData.setSuccess(true);
		jsonData.setMsg("操作成功");
		return jsonData;
	}
}
