package com.solidextend.sys.prompt.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.prompt.dao.PromptMsgMapper;
import com.solidextend.sys.prompt.vo.PromptMsg;

/**
 * 提示信息Service
 * @author songjunjie
 * @version 2013-12-19 下午2:45:44
 */
@Service("promptMsgService")
public class PromptMsgServiceImpl implements PromptMsgService{
	@Resource
	PromptMsgMapper promptMsgMapper;
	/**
     * 删除提示信息
     * @param id 提示信息ID
     */
    public int deleteById(String id){
    	return promptMsgMapper.deleteById(id);
    }

    /**
     * 保存提示信息
     * @param record
     * @return
     */
    public int save(PromptMsg promptMsg){
    	return this.save(promptMsg);
    }

    /**
     * 根据提示信息ID，查询出提示信息
     * @param id
     * @return
     */
    public PromptMsg getById(String id){
    	return this.promptMsgMapper.getById(id);
    }
    
    /**
     * 根据提供的查询条件查询提示信息
     * @param pageParam , 分页参数
     * @param promptMsg, 对象的属性作为查询条件。 如果为null，查询全部
     * @return 分页数据
     */
    public JsonData findPromptMsg(PageParam pageParam ,PromptMsg promptMsg){
    	if(promptMsg == null){
    		promptMsg =  new PromptMsg();
    	}
    	Object content=promptMsg.getContent();
    	if(content!=null&&!StringUtils.isEmpty(String.valueOf(content))){
    		content="%"+content+"%";
    		promptMsg.setContent(content);
    	}
    	 List<PromptMsg> list =  this.promptMsgMapper.findPromptMsg(pageParam.getRowBounds(), promptMsg);
    	 int total = this.promptMsgMapper.findPromptMsgCount(promptMsg);
    	 JsonData jsonData = new JsonData();
    	 jsonData.setTotal(total);
    	 jsonData.setRows(list);
    	 return jsonData;
    }
    
    /**
     * 根据ID更新提示信息，ID作为更新条件
     * @param promptMsg
     * @return
     */
    public int updateById(PromptMsg promptMsg){
    	return this.updateById(promptMsg);
    }
}
