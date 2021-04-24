package com.solidextend.sys.dataset.service;

import java.util.List;

import com.solidextend.sys.dataset.vo.Params;

/**
 * 数据查询
 * @author changxiaoxue
 * @date 2015-2-8 12:25
 */
public interface DataSetService {

	/**
     * 查询
     * @param params
     * @return List
     */
    public List select(String dsId,Params params);

   
}
