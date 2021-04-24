package com.solidextend.sys.takeout.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.takeout.vo.CoursesTypeVO;
import com.solidextend.sys.takeout.vo.CoursesVO;

@Mapper
public interface CoursesMapper {

	public CoursesVO getCoursesById(@Param("coursesId")String coursesId);

	public List<CoursesVO> findAllCourses();

	public List<CoursesVO> findByCourses(CoursesVO courses);
	
	public int findByCoursesCount(CoursesVO courses);

	public int updateCourses(CoursesVO courses);

	public void deleteCourses(@Param("coursesId")String coursesId);

	public int saveCourses(CoursesVO courses);

	public List<CoursesTypeVO> getCoursesTypeName();

	public void delete(String string);

	
	
}
