package com.solidextend.sys.prompt.service;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.prompt.vo.PromptMsg;

/**
 * 提示信息Service
 * @author songjunjie
 * @version 2013-12-19 下午2:45:44
 */
public interface PromptMsgService {
	/**
     * 删除提示信息
     * @param id 提示信息ID
     */
    int deleteById(String id);

    /**
     * @param record
     * @return
     */
    int save(PromptMsg promptMsg);

    /**
     * 根据提示信息ID，查询出提示信息
     * @param id
     * @return
     */
    PromptMsg getById(String id);
    
    /**
     * 根据提供的查询条件查询提示信息
     * @param promptMsg，对象的属性作为查询条件。
     * @return
     */
    JsonData findPromptMsg(PageParam pageParam ,PromptMsg promptMsg);
    
    
    /**
     * 根据ID更新提示信息，ID作为更新条件
     * @param promptMsg
     * @return
     */
    int updateById(PromptMsg promptMsg);
}
