package com.solidextend.core.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 * json 工具类
 * @author 宋俊杰
 */
public class JsonUtil {
    /**
     * json转对象的mapper，前台一般默认只传年月日
     */
	private static ObjectMapper parseObjectMapper = getObjectMapper("yyyyMMddHHmmss");
	
	/**
	 * 对象转json的mapper，后台默认返回的日期格式
	 */
	private static ObjectMapper formatObjectMapper = getObjectMapper("yyyyMMddHHmmss");
	
	private static ObjectMapper getObjectMapper(String dateStyle) {
	    ObjectMapper objectMapper = new ObjectMapper();
	    objectMapper.setDateFormat(new SimpleDateFormat(dateStyle));
	    //允许字段名字不使用引号
	    objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
	    //允许单引号
	    objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true); 
        // 忽略未识别的参数(解决json串中多属性，而类中又未定义的情况)
	    objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	    objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);  
        return objectMapper;
	}
	
	/** 
	 * 将规定对象转换成json字符串。日期类型按照 yyyyMMddHHmmss 的格式转换成字符串
	 * @param obj 对象
	 * @return json字符串
	 */
	public static String writeValueAsString(Object obj){
		try {
			return formatObjectMapper.writeValueAsString(obj);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 将规定对象转换成json字符串。日期类型按照给定的样式转换
	 * @param obj 对象
	 * @param dateStyle 日期格式
	 * @return json字符串
	 */
	public static String writeValueAsString(Object obj, String dateStyle){
		ObjectMapper objectMapper = getObjectMapper(dateStyle);
		try {
			return objectMapper.writeValueAsString(obj);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将json字符串转为对象
	 * 
	 * @param <T> 返回类型
	 * @param content json字符串
	 * @param valueType 返回类型
	 * @return 对象
	 */
	public static <T> T readValue(String content, Class<T> valueType) {
		try {
			return parseObjectMapper.readValue(content, valueType);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 将json转换成对象
	 * @param content
	 * @param valueTypeRef
	 * @return
	 */
	public static <T> T readValue(String content, TypeReference<T> valueTypeRef){
		try {
			return parseObjectMapper.readValue(content, valueTypeRef);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
     * 将json转换成对象
     * @param content
     * @param valueTypeRef
     * @param dateStyle
     * @return
     */
    public static <T> T readValue(String content, TypeReference<T> valueTypeRef, String dateStyle){
        try {
            ObjectMapper objectMapper = getObjectMapper(dateStyle);
            return objectMapper.readValue(content, valueTypeRef);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
	
	/**
     * 将json字符串转为对象，日期类型按照给定的样式转换
     * 
     * @param <T> 返回类型
     * @param content json字符串
     * @param valueType 返回类型
     * @param dateStyle 日期格式
     * @return 对象
     */
    public static <T> T readValue(String content, Class<T> valueType, String dateStyle) {
        try {
            ObjectMapper objectMapper = getObjectMapper(dateStyle);
            return objectMapper.readValue(content, valueType);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public static <T> T readValue(JsonNode jsonNode , Class<T> valueType){
    	try {
			return parseObjectMapper.readValue(jsonNode, valueType);
		}  catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public static <T> T readValue(JsonNode jsonNode , TypeReference<T> valueTypeRef){
    	try {
			return parseObjectMapper.readValue(jsonNode, valueTypeRef);
		}  catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public static <T> T readValue(JsonNode jsonNode,TypeReference<T> valueTypeRef,String dateStyle){
    	ObjectMapper objectMapper = getObjectMapper(dateStyle);
    	try {
			return objectMapper.readValue(jsonNode, valueTypeRef);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
    }
    
    /**
     * 根据所给的json字符串转换 JsonNode 对象
     * @param content
     * @return
     */
    public static JsonNode readTree(String content){
    	try {
			return parseObjectMapper.readTree(content);
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
    	
    }
    
	/**
	 * 根据给定的路径，返回对应的 JsonNode对象
	 * @param jsonNode
	 * @param path 路径表达式。 例如：对于{param:{transCode:"123"}} 中的transCode可以这样表达,getJsonNode(jsonNode,"param.transCode")
	 * @return
	 */
	public static JsonNode getJsonNode(JsonNode jsonNode , String path){
		String[] pathArr = path.split("\\.");
		JsonNode temp = jsonNode; 
		for(String filed : pathArr){
			temp = temp.get(filed);
		}
		return temp;
	}
	
	/**
	 * 根据给定的路径，返回对应的 JsonNode对象
	 * @param json
	 * @param path
	 * @return
	 */
	public static JsonNode getJsonNode(String json , String path){
		JsonNode root = JsonUtil.readTree(json);
		return getJsonNode(root,path);
	}	
    
	/**
	 * 得到给定属性的值
	 * @param jsonNode
	 * @param path
	 * @return
	 */
	public static String getFieldValue(JsonNode jsonNode,String path){
		JsonNode node = getJsonNode(jsonNode,path);
		if(node==null){
			return null;
		}
		return node.asText();
	}
	
	public static String getFieldValue(String json , String path){
		JsonNode jsonNode = readTree(json);
		return getFieldValue(jsonNode,path);
	}
	
	public static void main(String[] args){
//		Map map = new HashMap();
//		map.put("name", "张三");
//		map.put("age", 50);
//		map.put("生日", new Date());
//		System.out.println(writeValueAsString(map));
//		System.out.println(writeValueAsString(map,"yyyy年MM月dd日HH时mm分"));
		
		String str = "{'username':'admin',password:'000000'}";
		
//		String str = "{ \"name\" : \"萧远山\", \"sex\" : \"男\", \"age\" : \"23\",\"address\" : \"河南郑州\"}";
		Map<?,?> map = readValue(str,HashMap.class);
		System.out.println(map);
	}
}
