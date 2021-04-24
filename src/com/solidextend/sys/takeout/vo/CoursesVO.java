package com.solidextend.sys.takeout.vo;

public class CoursesVO extends BaseVO {
	
	//菜品id
	private Long coursesId;
	
	//菜品名称
	private String coursesName;
	
	//菜品类型
	private String coursesTypeId;
	
	//菜品类型名称
	private String coursesTypeName;
	
	//菜品描述
	private String coursesDesc;
	
	//商家id
	private String userId;
	
	//商品教师价
	private double coursesPriceT;

	//商品学生价
	private double coursesPriceS;
	
	//
	private String tejia;
	
	//商品折扣
	private double rat;
	
	//是否删除
	private String isDelete;     

	public Long getCoursesId() {
		return coursesId;
	}

	public void setCoursesId(Long coursesId) {
		this.coursesId = coursesId;
	}

	public String getCoursesName() {
		return coursesName;
	}

	public void setCoursesName(String coursesName) {
		this.coursesName = coursesName;
	}

	public String getCoursesTypeId() {
		return coursesTypeId;
	}

	public void setCoursesTypeId(String coursesTypeId) {
		this.coursesTypeId = coursesTypeId;
	}

	public String getCoursesDesc() {
		return coursesDesc;
	}

	public void setCoursesDesc(String coursesDesc) {
		this.coursesDesc = coursesDesc;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	public double getCoursesPriceT() {
		return coursesPriceT;
	}

	public void setCoursesPriceT(double coursesPriceT) {
		this.coursesPriceT = coursesPriceT;
	}

	public double getCoursesPriceS() {
		return coursesPriceS;
	}

	public void setCoursesPriceS(double coursesPriceS) {
		this.coursesPriceS = coursesPriceS;
	}

	public String getTejia() {
		return tejia;
	}

	public void setTejia(String tejia) {
		this.tejia = tejia;
	}

	public double getRat() {
		return rat;
	}

	public void setRat(double rat) {
		this.rat = rat;
	}

	public String getCoursesTypeName() {
		return coursesTypeName;
	}

	public void setCoursesTypeName(String coursesTypeName) {
		this.coursesTypeName = coursesTypeName;
	}

}
