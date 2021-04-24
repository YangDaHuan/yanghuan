package com.solidextend.sys.takeout.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.takeout.vo.CoursesTypeVO;

@Mapper
public interface CoursesTypeMapper {

	public CoursesTypeVO getCoursesTypeById(@Param("coursesTypeId")String coursesTypeId);

	public List<CoursesTypeVO> findAllCoursesType();

	public List<CoursesTypeVO> findByCoursesType(CoursesTypeVO coursesType);
	
	public int findByCoursesTypeCount(CoursesTypeVO coursesType);

	public int updateCoursesType(CoursesTypeVO coursesType);

	public void deleteCoursesType(@Param("coursesTypeId")String coursesTypeId);

	public int saveCoursesType(CoursesTypeVO coursesTypeVO);

	
	
}
