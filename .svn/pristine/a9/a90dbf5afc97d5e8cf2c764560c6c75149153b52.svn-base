package com.solidextend.sys.sms.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.sms.vo.SmsContent;

/**
 * 短信内容DAO
 * @author songjunjie
 * @version 2014-2-11 上午11:18:26
 */
@Mapper
public interface SmsContentMapper{
	int deleteById(String id);

	int insert(SmsContent smsContent);

	SmsContent getById(String id);

	int updateById(SmsContent smsContent);
	
	/**
	 * 查询短信总数
	 * @param smsContent
	 * @return int
	 * @author 王聚金
	 * @date 2014-02-12 10:05
	 */
	int count(SmsContent smsContent);

	/**
	 * 查询短信列表（分页）
	 * @param rowBounds
	 * @param smsContent
	 * @return List<SmsContent>
	 * @author 王聚金
	 * @date 2014-02-12 10:05
	 */
	List<SmsContent> select(RowBounds rowBounds, SmsContent smsContent);
}