package com.solidextend.core.util;

import java.util.HashMap;
import java.util.Map;

public class SqlStringUtil {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String sql=" with a as  (select sum(1) as myNumber from myTable where left(ID,3)='2)3') b as (select * from a) select * from b";
		String startMark="(";
		String endMark=")";
		int startIndex=sql.indexOf("(s");
		int endIndex=SqlStringUtil.getMatchingEndIndex(sql, startMark, endMark,startIndex);
		System.out.println(endIndex);
		if(endIndex>=0){
			System.out.println(sql.substring(endIndex));
		}else{
			System.out.println("error");
		}
		System.out.println(SqlStringUtil.replaceStringValue(sql));
		int index=SqlStringUtil.getWithEndIndex(sql);
		if(index>=0){
			System.out.println("+++"+sql.substring(index+1));
		}else{
			System.out.println("+++no with");
		}
		

	}
	public static int getWithEndIndex(String sql){
		int index=-1;
		int tempIndex;
		String newSql=sql.trim().toUpperCase();
		
		String tempStr="";
		if(newSql.startsWith("WITH ")){
			while(true){
				tempIndex=newSql.indexOf("(",index+1);
				if(tempIndex<0){
					return index;
				}
				tempStr=newSql.substring(0,tempIndex).trim();
				if(tempStr.endsWith(" AS")){
					index=sql.indexOf("(",index+1);
					index=getMatchingEndIndex(sql,"(",")",index);
					if(index<0){
						return -1;
					}
				}else{
					return index;
				}
				
			}
			
		}
		return index;
	}
	public static int getMatchingEndIndex(String sql,String startMark,String endMark,int startIndex){
		int endIndex=startIndex;
		String newSql=SqlStringUtil.replaceStringValue(sql);
		while(true){
			startIndex=newSql.indexOf(startMark,startIndex+startMark.length());
			if(startIndex < 0){
				return newSql.indexOf(endMark,endIndex+endMark.length());
			}
			endIndex=newSql.indexOf(endMark,endIndex+endMark.length());
			if(endIndex >=0){
				if(startIndex > endIndex){
					return endIndex;
				}
				
			}else{
				return -1;
			}
			
		}
	}
	public static String replaceStringValue(String sql){
		String flag="'";
		String replace="+";
		int startIndex=-1;
		int endIndex;
		//先将转义字符单引号替换为加号，长度要一样
		String newSql=sql.replaceAll("''", "++");
		while(true){
			startIndex++;
			startIndex=newSql.indexOf(flag,startIndex);
			endIndex=newSql.indexOf(flag,startIndex+1);
			if(startIndex>=0&&endIndex>=0){
				String prefix=newSql.substring(0,startIndex);
				String suffix=newSql.substring(endIndex+1,newSql.length());
				String replaceStr="";
				for(int i=0;i<endIndex+1-startIndex;i++){
					replaceStr+=replace;
				}
				newSql=prefix+replaceStr+suffix;
			}else{
				return newSql;
			}
		}
	}

}
