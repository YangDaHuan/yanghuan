package com.solidextend.sys.sms.dao;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.sms.vo.SmsReceiver;

/**
 * 短信接收人DAO
 * @author songjunjie
 * @version 2014-2-11 上午11:18:52
 */
@Mapper
public interface SmsReceiverMapper {
   
    int deleteById(String id);

    int insert(SmsReceiver smsReceiver);
    
    SmsReceiver getById(String id);

    int updateById(SmsReceiver smsReceiver);

}