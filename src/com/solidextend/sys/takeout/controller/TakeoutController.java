
package com.solidextend.sys.takeout.controller;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.takeout.service.CoursesService;
import com.solidextend.sys.takeout.service.CoursesTypeService;
import com.solidextend.sys.takeout.vo.CoursesTypeVO;
import com.solidextend.sys.takeout.vo.CoursesVO;
import com.solidextend.sys.takeout.vo.OrderVO;
import com.solidextend.sys.takeout.service.OrderService;

/**
 * TODO
 * @author 
 */
@RequestMapping("/takeout")
@Controller
public class TakeoutController{   
	private static final Log log = LogFactory.getLog(TakeoutController.class);
	
	 @Resource
	private CoursesTypeService coursesTypeService;
	 
	 @Resource
	private CoursesService coursesService;
	 
	 @Resource
	private OrderService orderService;
	 
	@RequestMapping("/CoursesType")
	public String CoursesType(){
		log.info("CoursesType页面");
		return "takeout/CoursesType";
	}
	
	/**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByCoursesType")
	@ResponseBody
	public JsonData findByCoursesType(CoursesTypeVO coursesType){
		
		return coursesTypeService.findByCoursesType(coursesType);
    }
	
	/**
     * 保存
     */
	@RequestMapping("/saveCoursesType")
	@ResponseBody
	public JsonData save(CoursesTypeVO coursesType){
		JsonData jsonData = new JsonData();
		try {
			coursesTypeService.saveCoursesType(coursesType);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 根据id查询
	 * @param 
	 * @return
	 */
	@RequestMapping("/getCoursesTypeById")
	@ResponseBody
	public JsonData getCoursesTypeById(String coursesTypeId){
		JsonData jsonData = new JsonData ();
		try {
			CoursesTypeVO coursesType = this.coursesTypeService.getCoursesTypeById(coursesTypeId);
			jsonData.setExtData(coursesType);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
     * 删除
     */
	@RequestMapping("/deleteCoursesType")
	@ResponseBody
	public JsonData deleteCoursesType(@RequestParam String coursesTypeId){
		System.out.println(123456);
		JsonData jsonData = new JsonData();
		String[] s =coursesTypeId.split(",");
		try {
			coursesTypeService.deleteCoursesType(s);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
 /*
  * 
  * 菜品管理
  * 
  * */
 
	
	@RequestMapping("/Courses")
	public String Courses(){
		log.info("Courses页面");
		return "takeout/Courses";
	}
	
	/**
     * 查询出所有符合条件的记录
     */
    @RequestMapping("/findByCourses")
	@ResponseBody
	public JsonData findByCourses(CoursesVO courses){
		
		return coursesService.findByCourses(courses);
    }
	
	/**
     * 保存
     */
	@RequestMapping("/saveCourses")
	@ResponseBody
	public JsonData save(CoursesVO courses){
		JsonData jsonData = new JsonData();
		try {
			coursesService.saveCourses(courses);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 根据id查询
	 * @param 
	 * @return
	 */
	@RequestMapping("/getCoursesById")
	@ResponseBody
	public JsonData getCoursesById(String coursesId){
		JsonData jsonData = new JsonData ();
		try {
			CoursesVO courses = this.coursesService.getCoursesById(coursesId);
			jsonData.setExtData(courses);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
     * 删除
     */
	@RequestMapping("/deleteCourses")
	@ResponseBody
	public JsonData deleteCourses(@RequestParam String coursesId){
		System.out.println(123456);
		JsonData jsonData = new JsonData();
		String[] s =coursesId.split(",");
		try {
			coursesService.deleteCourses(s);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	
	@RequestMapping("/getCoursesTypeName")
	@ResponseBody
	public JsonData getCoursesTypeName(){
		return this.coursesService.getCoursesTypeName();
	}
	
	
	/*
	  * 
	  * 订单管理
	  * 
	  * */
	 
		
		@RequestMapping("/Order")
		public String Order(){
			log.info("Order页面");
			return "takeout/Order";
		}
		
		/**
	     * 查询出所有符合条件的记录
	     */
	    @RequestMapping("/findByOrder")
		@ResponseBody
		public JsonData findByOrder(OrderVO Order){
			
			return orderService.findByOrder(Order);
	    }
		
		/**
	     * 保存
	     */
		@RequestMapping("/saveOrder")
		@ResponseBody
		public JsonData save(OrderVO Order){
			JsonData jsonData = new JsonData();
			try {
				orderService.saveOrder(Order);
				jsonData.setSuccess(true);
			} catch (Exception e) {
				log.error("",e);
				jsonData.setSuccess(false);
				jsonData.setMsg("系统内部错误");
			}
			return jsonData;
		}
		
		/**
		 * 根据id查询
		 * @param 
		 * @return
		 */
		@RequestMapping("/getOrderById")
		@ResponseBody
		public JsonData getOrderById(String OrderId){
			JsonData jsonData = new JsonData ();
			try {
				OrderVO Order = this.orderService.getOrderById(OrderId);
				jsonData.setExtData(Order);
				jsonData.setSuccess(true);
			} catch (Exception e) {
				log.error("",e);
				jsonData.setSuccess(false);
				jsonData.setMsg("出现系统内部错误");
			}
			return jsonData;
		}
		
		/**
	     * 删除
	     */
		@RequestMapping("/deleteOrder")
		@ResponseBody
		public JsonData deleteOrder(@RequestParam String OrderId){
			System.out.println(123456);
			JsonData jsonData = new JsonData();
			String[] s =OrderId.split(",");
			try {
				orderService.deleteOrder(s);
				jsonData.setSuccess(true);
			} catch (Exception e) {
				log.error("",e);
				jsonData.setSuccess(false);
				jsonData.setMsg("系统内部错误");
			}
			return jsonData;
		}
		
}

