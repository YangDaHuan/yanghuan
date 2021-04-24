package com.solidextend.sys.takeout.service;

import java.util.List;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.takeout.vo.CoursesVO;

/**
 * TODO
 * @author 
 */
public interface CoursesService{   
    /**
     * 根据主键查询
     */
    public CoursesVO getCoursesById(String coursesId); 

    /**
     * 查询出所有记录
     */
    public List<CoursesVO> findAllCourses();  
    
    /**
     * 查询出所有符合条件的记录
     */
    JsonData findByCourses(CoursesVO courses);   
    
    /**
     * 保存
     */
    public int saveCourses(CoursesVO courses);
    
    /**
     * 根据主键删除
     */
    public int deleteCourses(String[] id);

    /*
     * 查询菜品列表
     * */
    JsonData getCoursesTypeName();

	
}

