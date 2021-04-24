package com.solidextend.sys.mongodb.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.bson.BsonDocument;
import org.bson.BsonValue;
import org.bson.Document;
import org.bson.codecs.BsonValueCodec;
import org.bson.conversions.Bson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.solidextend.core.web.JsonData;
import com.solidextend.sys.authorize.service.AuthorizeService;
import com.solidextend.sys.dict.vo.Dict;
import com.solidextend.sys.dict.vo.DictItem;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.moduleFun.service.ModuleFunService;
import com.solidextend.sys.moduleFun.vo.ModuleFun;
import com.solidextend.sys.moduleFun.vo.ModuleFunGroup;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.security.UserDetails;
import com.mongodb.util.JSON;

/**
 * @author changxiaoxue
 * @version 2015-1-20 上午10:29:00
 */
@Controller
@RequestMapping("/mongodb")
public class MongodbController {
	private static final Log log = LogFactory.getLog(MongodbController.class);
	
	/**
	 * 保存表单数据
	 * 
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(String data,String rpx) {
		Object json = JSON.parse(data);
		JsonData jsonData = new JsonData();
		
		try {
			// 连接到 mongodb 服务
	         MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	         
	         // 连接到数据库
	         MongoDatabase mongoDatabase = mongoClient.getDatabase("custForm");  
	         System.out.println("Connect to database successfully");
	         
	         MongoCollection<Document> collection = mongoDatabase.getCollection(rpx);
	         System.out.println("集合 test 选择成功");
	         //插入文档  
	         /** 
	         * 1. 创建文档 org.bson.Document 参数为key-value的格式 
	         * 2. 创建文档集合List<Document> 
	         * 3. 将文档集合插入数据库集合中 mongoCollection.insertMany(List<Document>) 插入单个文档可以用 mongoCollection.insertOne(Document) 
	         * */
	         Document document = new Document();
	        
	         document.put("data", json);
	         /*Enumeration paramNames = request.getParameterNames();
	         if(paramNames!=null){
	         	while(paramNames.hasMoreElements()){
	         		String paramName = (String) paramNames.nextElement();
	         		String paramValue=URLDecoder.decode(request.getParameter(paramName),"utf-8");
	         		System.out.println(paramName+"="+paramValue);
	         		if(paramValue!=null){
	         			document.put(paramName, paramValue);
	         		}
	         	}
	         }*/
	         List<Document> documents = new ArrayList<Document>();  
	         documents.add(document);  
	         System.out.println("插入前总记录数>>"+collection.count()); 
	         collection.insertMany(documents);
	         System.out.println("插入后总记录数>>"+collection.count());  
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
		
	}

	/**
	 * 保存表单数据
	 * 
	 * @return
	 */
	@RequestMapping("/find")
	@ResponseBody
	public JsonData find(HttpServletRequest request,String rpx) {
JsonData jsonData = new JsonData();
		if(rpx == null){
			jsonData.setSuccess(false);
			jsonData.setMsg("collection name is null");
			return jsonData;
		}
		try {
			// 连接到 mongodb 服务
	         MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	         
	         // 连接到数据库
	         MongoDatabase mongoDatabase = mongoClient.getDatabase("custForm");  
	         System.out.println("Connect to database successfully");
	         
	         MongoCollection<Document> collection = mongoDatabase.getCollection(rpx);
	         BsonDocument where = new BsonDocument();
	         //BsonValue v=BsonValueCodec();
	         //where.append("name", "23的撒");
	         FindIterable<Document> docs=collection.find(where);
	         List list = new ArrayList();
	         for (Document document : docs) {  
	        	 System.out.println(document);
	        	 list.add(document);  
	         }
	         jsonData.setRows(list);
		}catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
		}
		return jsonData;
	}

	
}
