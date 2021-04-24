package com.solidextend.sys.input.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.bson.Document;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.input.MongoDBConfig;
import com.solidextend.core.util.Identities;
import com.solidextend.sys.input.dao.SysInputTaskInstanceMapper;
import com.solidextend.sys.input.dao.SysInputTaskMapper;
import com.solidextend.sys.input.vo.SysInputTask;
import com.solidextend.sys.input.vo.SysInputTaskInstance;
import com.solidextend.sys.security.UserDetails;

@Service
public class InputTaskServiceImpl implements InputTaskService {

	@Resource
	private SysInputTaskMapper inputTaskMapper;
	@Resource
	private SysInputTaskInstanceMapper inputTaskInstanceMapper;
	@Override
	public void saveInputTask(SysInputTask inputTask) {
		// TODO Auto-generated method stub
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		inputTask.setTaskAuthor(userDetails.getId());
		Date today=new Date();
		inputTask.setLastUpdateTime(today);
		
		// ID不为空，说明是修改
		if (StringUtils.isNotBlank(inputTask.getTaskId())) {
			this.inputTaskMapper.updateSysInputTask(inputTask);
		} else {
			inputTask.setCreateTime(today);
			String id = Identities.uuid();
			inputTask.setTaskId(id);
			this.inputTaskMapper.saveSysInputTask(inputTask);
		}
	}

	@Override
	public List<SysInputTask> getInputTaskList(SysInputTask inputTask) {
		// TODO Auto-generated method stub
		return this.inputTaskMapper.findByAttrSysInputTask(inputTask);
	}

	@Override
	public int deleteInputTask(String taskId) {
		// TODO Auto-generated method stub
		return this.inputTaskMapper.deleteSysInputTask(taskId);
	}

	@Override
	public void saveInputTaskInstance(SysInputTaskInstance inputTaskInstance, Document doc,int inputType) {
		// TODO Auto-generated method stub
		
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		Date today=new Date();
		if(inputType==1){
			//填报
			inputTaskInstance.setInputUserid(userDetails.getId());
			inputTaskInstance.setInputDepartment(userDetails.getOrganId());
			inputTaskInstance.setInputTime(today);
			// ID不为空，说明是修改
			if (StringUtils.isNotBlank(inputTaskInstance.getTaskInstanceId())) {
				this.inputTaskInstanceMapper.updateSysInputTaskInstance(inputTaskInstance);
				this.updateMongoDB(inputTaskInstance.getTaskId(), doc, inputTaskInstance.getTaskInstanceId());
			} else {
				String id = Identities.uuid();
				inputTaskInstance.setTaskInstanceId(id);
				this.inputTaskInstanceMapper.saveSysInputTaskInstance(inputTaskInstance);
				this.saveMongoDB(inputTaskInstance.getTaskId(), doc, id);
			}
		}else{
			//审核
			inputTaskInstance.setAuditUserid(userDetails.getId());
			inputTaskInstance.setAuditDepartment(userDetails.getOrganId());
			inputTaskInstance.setAuditTime(today);
			this.inputTaskInstanceMapper.updateSysInputTaskInstance(inputTaskInstance);
			
		}
		
		
	}
	private void saveMongoDB(String collectionName,Document doc,String taskInstanceId){
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		MongoDBConfig mongoDBConfig = appContext.getBean("mongoDBConfig",MongoDBConfig.class);
		
		// 连接到 mongodb 服务
        MongoClient mongoClient = new MongoClient( mongoDBConfig.getIp(), mongoDBConfig.getPort() );
        
        // 连接到数据库
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBConfig.getDbname());  
        
        MongoCollection<Document> collection = mongoDatabase.getCollection(collectionName);
        doc.append("taskInstanceId", taskInstanceId);
        collection.insertOne(doc);
	}
	
	private void updateMongoDB(String collectionName,Document doc,String taskInstanceId){
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		MongoDBConfig mongoDBConfig = appContext.getBean("mongoDBConfig",MongoDBConfig.class);
		
		// 连接到 mongodb 服务
        MongoClient mongoClient = new MongoClient( mongoDBConfig.getIp(), mongoDBConfig.getPort() );
        
        // 连接到数据库
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBConfig.getDbname()); 
        
        MongoCollection<Document> collection = mongoDatabase.getCollection(collectionName);
        Document document1 = new Document();
        document1.append("taskInstanceId", taskInstanceId);
        Document document2 = new Document();
        document2.append("$set", doc);
        Document query = collection.findOneAndUpdate(document1,document2); 
        
	}
	private Document queryMongoDB(String collectionName,String taskInstanceId){
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		MongoDBConfig mongoDBConfig = appContext.getBean("mongoDBConfig",MongoDBConfig.class);
		
		// 连接到 mongodb 服务
        MongoClient mongoClient = new MongoClient( mongoDBConfig.getIp(), mongoDBConfig.getPort() );
        
        // 连接到数据库
        MongoDatabase mongoDatabase = mongoClient.getDatabase(mongoDBConfig.getDbname()); 
        
        MongoCollection<Document> collection = mongoDatabase.getCollection(collectionName);
        
        FindIterable<Document> query = collection.find(new BasicDBObject().append("taskInstanceId", taskInstanceId)); 
        return query.first();
	}
	@Override
	public List<SysInputTaskInstance> getInputTaskInstanceList(SysInputTaskInstance inputTaskInstance) {
		// TODO Auto-generated method stub
		return this.inputTaskInstanceMapper.findByAttrSysInputTaskInstance(inputTaskInstance);
	}

	@Override
	public Document getInputTaskInstanceData(String taskId, String taskInstanceId) {
		// TODO Auto-generated method stub
		return this.queryMongoDB(taskId, taskInstanceId);
	}

}
