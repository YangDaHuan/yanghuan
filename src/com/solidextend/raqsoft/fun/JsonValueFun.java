package com.solidextend.raqsoft.fun;

import com.raqsoft.report.model.expression.Function;
import com.raqsoft.report.usermodel.Context;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.jayway.jsonpath.JsonPath;
import com.raqsoft.common.MessageManager;
import com.raqsoft.common.ReportError;
import com.raqsoft.report.model.expression.Expression;
import com.raqsoft.report.model.expression.Variant2;
import com.raqsoft.report.resources.EngineMessage;
public class JsonValueFun extends Function {

	@Override
	public Object calculate(Context ctx) {
		// TODO Auto-generated method stub
		//判断参数个数
		if (this.param == null || this.param.getSubSize() !=2) {
		MessageManager mm = EngineMessage.get();
		throw new ReportError("getJsonValue:" + mm.getMessage("function.missingParam"));
		}
		String json;
		String jsonPath;
		//取得第一个参数,默认为表达式，需要把该表达式算出来，结果才是函数的参数值
		Expression param1=(Expression)this.param.getSub(0).getLeafExpression();
		if (param1 == null) { //判断参数是否为空
		MessageManager mm = EngineMessage.get();
		throw new ReportError("getJsonValue:" + mm.getMessage("function.invalidParam"));
		}
		//算出第一个参数值
		Object jsonStr = Variant2.getValue(param1.calculate(ctx), false);
		//判断第一个参数值是否为空
		if (jsonStr == null) {
		return null;
		}
		//判断第一个参数值的数据类型
		if (! (jsonStr instanceof String)) {
		MessageManager mm = EngineMessage.get();
		throw new ReportError("getJsonValue:" + mm.getMessage("function.paramTypeError"));
		}else{
			json=(String)jsonStr;
		}
		
		//取得第二个参数,默认为表达式，需要把该表达式算出来，结果才是函数的参数值
		Expression param2=(Expression)this.param.getSub(1).getLeafExpression();
		if (param2 == null) { //判断参数是否为空
		MessageManager mm = EngineMessage.get();
		throw new ReportError("getJsonValue:" + mm.getMessage("function.invalidParam"));
		}
		//算出第二个参数值
		Object path = Variant2.getValue(param2.calculate(ctx), false);
		//判断第二个参数值是否为空
		if (path == null) {
		return null;
		}
		//判断第二个参数值的数据类型
		if (! (path instanceof String)) {
		MessageManager mm = EngineMessage.get();
		throw new ReportError("getJsonValue:" + mm.getMessage("function.paramTypeError"));
		}else{
			jsonPath=(String)path;
		}
		//获得jsonPath的值
		Object obj=JsonPath.read(json, jsonPath);
		if(obj instanceof java.util.List){
			java.util.ArrayList<Object> newList=new java.util.ArrayList<Object>();
			@SuppressWarnings("unchecked")
			java.util.List<Object> list=(java.util.List<Object>)obj;
			for(Object o :list){
				newList.add(getJsonString(o));
			}
			return newList;
		}else{
			
			return getJsonString(obj);
		}
		
		
	}
	private Object getJsonString(Object obj){
		ObjectMapper objectMapper = new ObjectMapper();
		Object value=null;
		if(obj instanceof java.util.Map || obj instanceof java.util.List){
			
			
		try {
			value=objectMapper.writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}else{
			value=obj;
		}
		return value;
	}
	public static void main(String args[]){
		String json="{ \"store\": {    \"book\": [       { \"category\": \"reference\",        \"author\": \"Nigel Rees\",        \"title\": \"Sayings of the Century\",        \"price\": 8.95      },      { \"category\": \"fiction\",        \"author\": \"Evelyn Waugh\",        \"title\": \"Sword of Honour\",        \"price\": 12.99,        \"isbn\": \"0-553-21311-3\"      }    ],    \"bicycle\": {      \"color\": \"red\",      \"price\": 19.95    }  }}";		
		Object obj = JsonPath.read(json, "$.store.book[?(@.price > 10)].price");
		ObjectMapper objectMapper = new ObjectMapper();
		String value=null;
		try {
			value=objectMapper.writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(value);
	}
}
