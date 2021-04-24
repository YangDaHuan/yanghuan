package com.solidextend.sys.takeout.service;

import java.util.List;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.takeout.vo.CoursesTypeVO;

/**
 * TODO
 * @author 
 */
public interface CoursesTypeService{   
    /**
     * 根据主键查询
     */
    public CoursesTypeVO getCoursesTypeById(String coursesTypeId); 

    /**
     * 查询出所有记录
     */
    public List<CoursesTypeVO> findAllCoursesType();  
    
    /**
     * 查询出所有符合条件的记录
     */
    JsonData findByCoursesType(CoursesTypeVO CoursesType);   
    
    /**
     * 保存
     */
    public int saveCoursesType(CoursesTypeVO CoursesType);
    
    /**
     * 根据主键删除
     */
    public int deleteCoursesType(String[] id);

	
}

