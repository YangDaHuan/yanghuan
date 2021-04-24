package com.solidextend.sys.takeout.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.takeout.dao.CoursesMapper;
import com.solidextend.sys.takeout.vo.CoursesTypeVO;
import com.solidextend.sys.takeout.vo.CoursesVO;

/**
 * TODO
 * @author 
 */
@Service
public class CoursesServiceImpl implements CoursesService{   

	@Resource
	private CoursesMapper coursesMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public CoursesVO getCoursesById(String coursesId){
    	return coursesMapper.getCoursesById(coursesId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<CoursesVO> findAllCourses(){
    	return coursesMapper.findAllCourses();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public JsonData findByCourses(CoursesVO courses){
    	List<CoursesVO> list =  coursesMapper.findByCourses(courses);
		int total = coursesMapper.findByCoursesCount(courses);
		JsonData jsonData = new JsonData();
		jsonData.setTotal(total);
		jsonData.setRows(list);
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveCourses(CoursesVO courses){
    	boolean isInsert=false;
            if(courses.getCoursesId()==null||courses.getCoursesId()==0){
            	isInsert=true;
            }
        
        if(isInsert){
        	
        	return coursesMapper.saveCourses(courses);
        }else{
        	return coursesMapper.updateCourses(courses);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteCourses(String[] coursesId){
    	int i;
    	for(i=0;i<coursesId.length;i++){
    		coursesMapper.delete(coursesId[i]);
    	}
    	return i;
    }

	@Override
	public JsonData getCoursesTypeName() {
		// TODO Auto-generated method stub
		JsonData jsonData = new JsonData ();
		List<CoursesTypeVO> list = coursesMapper.getCoursesTypeName();
		jsonData.setRows(list);
		return jsonData;
	}
}

