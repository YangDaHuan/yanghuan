package com.solidextend.core.mybatis.dialect;

public abstract class Dialect {

	public static enum Type{
		MYSQL,
		ORACLE,
		SQLSERVER
	}
	
	/**
	 * 转换成分页sql
	 * @param sql
	 * @param skipResults
	 * @param maxResults
	 * @return
	 */
	public abstract String getLimitString(String sql, int skipResults, int maxResults);
	
}
