package com.solidextend.sys.takeout.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.core.web.JsonData;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.takeout.dao.CoursesTypeMapper;
import com.solidextend.sys.takeout.vo.CoursesTypeVO;

/**
 * TODO
 * @author 
 */
@Service
public class CoursesTypeServiceImpl implements CoursesTypeService{   

	@Resource
	private CoursesTypeMapper coursesTypeMapper;
	
	/**
     * 根据主键查询
     */
    @Override
    public CoursesTypeVO getCoursesTypeById(String coursesTypeId){
    	return coursesTypeMapper.getCoursesTypeById(coursesTypeId);
    } 

    /**
     * 查询出所有记录
     */
    @Override
    public List<CoursesTypeVO> findAllCoursesType(){
    	return coursesTypeMapper.findAllCoursesType();
	}  
    
    /**
     * 查询出所有符合条件的记录
     */
    @Override
    public JsonData findByCoursesType(CoursesTypeVO CoursesType){
    	List<CoursesTypeVO> list =  coursesTypeMapper.findByCoursesType(CoursesType);
		int total = coursesTypeMapper.findByCoursesTypeCount(CoursesType);
		JsonData jsonData = new JsonData();
		jsonData.setTotal(total);
		jsonData.setRows(list);
		return jsonData;
    }    
    
    /**
     * 保存
     */
    @Override
    public int saveCoursesType(CoursesTypeVO coursesType){
    	boolean isInsert=false;
            if(coursesType.getCoursesTypeId()==null||coursesType.getCoursesTypeId()==0){
            	isInsert=true;
            }
        
        if(isInsert){
        	
        	return coursesTypeMapper.saveCoursesType(coursesType);
        }else{
        	return coursesTypeMapper.updateCoursesType(coursesType);
        }
    	
    }
    
    /**
     * 根据主键删除
     */
    @Override
    public int deleteCoursesType(String[] coursesTypeId){
    	int i;
    	for(i=0;i<coursesTypeId.length;i++){
    		coursesTypeMapper.deleteCoursesType(coursesTypeId[i]);
    	}
    	return i;
    }
}

