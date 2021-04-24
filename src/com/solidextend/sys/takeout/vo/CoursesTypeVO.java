package com.solidextend.sys.takeout.vo;

public class CoursesTypeVO extends BaseVO {
	private Long coursesTypeId;
	
	private String coursesTypeName;
	
	private String coursesTypeDesc;
	
	private String userId;

	public Long getCoursesTypeId() {
		return coursesTypeId;
	}

	public void setCoursesTypeId(Long coursesTypeId) {
		this.coursesTypeId = coursesTypeId;
	}

	public String getCoursesTypeName() {
		return coursesTypeName;
	}

	public void setCoursesTypeName(String coursesTypeName) {
		this.coursesTypeName = coursesTypeName;
	}

	public String getCoursesTypeDesc() {
		return coursesTypeDesc;
	}

	public void setCoursesTypeDesc(String coursesTypeDesc) {
		this.coursesTypeDesc = coursesTypeDesc;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}


}
