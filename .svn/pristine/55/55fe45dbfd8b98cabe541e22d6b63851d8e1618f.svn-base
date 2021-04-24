package com.solidextend.sys.dict.dao;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.dict.vo.Dict;

import java.util.List;

/**
 * 字典管理	
 * @author 王聚金 songjunjie
 * @date 2013-12-31
 */
@Mapper
public interface DictMapper {

    /**
     * 删除字典信息
     * @param id
     * @return int
     */
    int deleteById(String id);

    /**
     * 保存字典信息
     * @param record
     * @return int
     */
    int insert(Dict dict);

    /**
     * 根据ID查询
     * @param id
     * @return
     */
    Dict getById(String id);

    /**
     * 根据条件查询。remark作为条件
     * @param dict
     * @return
     */
    List<Dict> findDict(Dict dict);
   
    /**
     * 更新字典信息
     * @param record
     * @return int
     */
    int updateById(Dict dict);

}