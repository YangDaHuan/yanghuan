package com.solidextend.core.mybatis.dialect;

import com.solidextend.core.util.SqlStringUtil;



/**
 * 
 * @author tony.li
 *
 */

public class OracleDialect extends Dialect {

	public String getLimitString(String sql, int offset, int limit) {

		sql = sql.trim();
		boolean isForUpdate = false;
		if (sql.toLowerCase().endsWith(" for update")) {
			sql = sql.substring(0, sql.length() - 11);
			isForUpdate = true;
		}

		StringBuffer pagingSelect = new StringBuffer(sql.length() + 100);
		
		//pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");
		sql=sql.trim();
		int index=SqlStringUtil.getWithEndIndex(sql);
		if(index>=0){
			pagingSelect.append(sql.substring(0,index+1));
			pagingSelect.append(", row_ as (");
			pagingSelect.append(sql.substring(index+1));
			pagingSelect.append("), row1_ as (select rownum,row_.* from row_) select * from row1_ where rownum > "+offset+" and rownum <= "+(offset + limit));
			
			
		}else{
			pagingSelect.append("with row_ as (");
			pagingSelect.append(sql);
			pagingSelect.append("), row1_ as (select rownum,row_.* from row_) select * from row1_ where rownum > "+offset+" and rownum <= "+(offset + limit));
		}
		
		
		//pagingSelect.append(" ) row_ ) where rownum_ > "+offset+" and rownum_ <= "+(offset + limit));

		if (isForUpdate) {
			pagingSelect.append(" for update");
		}
		
		return pagingSelect.toString();
	}
}
