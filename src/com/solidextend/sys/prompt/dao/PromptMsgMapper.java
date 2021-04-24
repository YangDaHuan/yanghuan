package com.solidextend.sys.prompt.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.prompt.vo.PromptMsg;

/**
 * 提示信息DAO
 * @author songjunjie
 * @version 2013-12-19 下午2:45:26
 */
@Mapper
public interface PromptMsgMapper {
   

    /**
     * 删除提示信息
     * @param id 提示信息ID
     */
    int deleteById(String id);

    /**
     * @param record
     * @return
     */
    int insert(PromptMsg promptMsg);

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
    List<PromptMsg> findPromptMsg(RowBounds rowBounds ,PromptMsg promptMsg);
    
    Integer  findPromptMsgCount(PromptMsg promptMsg);
    
    /**
     * 根据ID更新提示信息，ID作为更新条件
     * @param promptMsg
     * @return
     */
    int updateById(PromptMsg promptMsg);
}