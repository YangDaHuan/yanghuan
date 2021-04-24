package com.solidextend.sys.mongodb.service;

import java.util.ArrayList;
import java.util.List;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class MongodbServiceImpl implements MongodbService {

	@Override
	public void insertMany(String collection1, List<Document> docs) {
		// TODO Auto-generated method stub
		try{   
	         // 连接到 mongodb 服务
	         MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	         
	         // 连接到数据库
	         MongoDatabase mongoDatabase = mongoClient.getDatabase("custForm");  
	         System.out.println("Connect to database successfully");
	         
	         MongoCollection<Document> collection = mongoDatabase.getCollection("users");
	         System.out.println("集合 test 选择成功");
	         //插入文档  
	         /** 
	         * 1. 创建文档 org.bson.Document 参数为key-value的格式 
	         * 2. 创建文档集合List<Document> 
	         * 3. 将文档集合插入数据库集合中 mongoCollection.insertMany(List<Document>) 插入单个文档可以用 mongoCollection.insertOne(Document) 
	         * */
	         Document document = new Document("title", "MongoDB").  
	         append("name", "snow").  
	         append("sex", 1).  
	         append("age", 35);  
	         List<Document> documents = new ArrayList<Document>();  
	         documents.add(document);  
	         collection.insertMany(documents);  
	         System.out.println("文档插入成功");  
	      }catch(Exception e){
	         System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	      }
	}

	@Override
	public void deleteMany(Filters f) {
		// TODO Auto-generated method stub

	}

	public static void main(String args[]){
		MongodbServiceImpl obj= new MongodbServiceImpl();
		obj.insertMany(null, null);
	}
}
