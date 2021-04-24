package com.solidextend.sys.security;

import java.util.List;

import com.solidextend.sys.role.vo.Role;


/**
 * 登录人员信息。
 * 
 * @author 宋俊杰
 * 
 */
public class UserDetails {
	private String id;

	private String loginName;

	private String password;

	private String fullname;

	private String sex;
	
	private String birthday;

	private String organId;

	private String organCode;

	private String position;

	private String post;

	private String tel;

	private String mobile;

	private Object remark;

	private String email;

	private String enable;

	private String deleted;

	private Short orderNo;

	private String enabledDatetime;

	private String disableDateTime;
	
	private String expirationDatetime;
	
	private String ip;
	
	/**
	 * 登陆日志ID。用户登陆后，记录登陆日志，记录成功后，保存此ID，以便
	 * 在用户退出后根据此id更新登录日志的退出时间
	 */
	private String loginLogId;
	
	private List<Role> roles;

	/**
	 * 用户ID
	 * @return
	 */
	public String getId() {
		return id;
	}

	/**
	 * 用户ID
	 * @return
	 */
	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	/**
	 * 登录名
	 * @return
	 */
	public String getLoginName() {
		return loginName;
	}

	/**
	 * 登录名
	 * @return
	 */
	public void setLoginName(String loginName) {
		this.loginName = loginName == null ? null : loginName.trim();
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password == null ? null : password.trim();
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex == null ? null : sex.trim();
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId == null ? null : organId.trim();
	}

	/**
	 * 职务
	 * @return
	 */
	public String getPosition() {
		return position;
	}

	/**
	 * 职务
	 * @return
	 */
	public void setPosition(String position) {
		this.position = position == null ? null : position.trim();
	}

	/**
	 * 岗位
	 * @return
	 */
	public String getPost() {
		return post;
	}

	/**
	 * 岗位
	 * @return
	 */
	public void setPost(String post) {
		this.post = post == null ? null : post.trim();
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel == null ? null : tel.trim();
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile == null ? null : mobile.trim();
	}

	public Object getRemark() {
		return remark;
	}

	public void setRemark(Object remark) {
		this.remark = remark;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	/**
	 * 是否启用
	 * @return
	 */
	public String getEnable() {
		return enable;
	}

	/**
	 * 是否启用
	 * @return
	 */
	public void setEnable(String enable) {
		this.enable = enable == null ? null : enable.trim();
	}

	/**
	 * 是否删除
	 * @return
	 */
	public String getDeleted() {
		return deleted;
	}

	/**
	 * 是否删除
	 * @return
	 */
	public void setDeleted(String deleted) {
		this.deleted = deleted == null ? null : deleted.trim();
	}

	public Short getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Short orderNo) {
		this.orderNo = orderNo;
	}

	/**
	 * 启用时间
	 * @return
	 */
	public String getEnabledDatetime() {
		return enabledDatetime;
	}

	/**
	 * 启用时间
	 * @return
	 */
	public void setEnabledDatetime(String enabledDatetime) {
		this.enabledDatetime = enabledDatetime == null ? null : enabledDatetime
				.trim();
	}

	/**
	 * 停用时间
	 * @return
	 */
	public String getDisableDateTime() {
		return disableDateTime;
	}

	/**
	 * 停用时间
	 * @return
	 */
	public void setDisableDateTime(String disableDateTime) {
		this.disableDateTime = disableDateTime == null ? null : disableDateTime
				.trim();
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	public String getLoginLogId() {
		return loginLogId;
	}

	public void setLoginLogId(String loginLogId) {
		this.loginLogId = loginLogId;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public String getExpirationDatetime() {
		return expirationDatetime;
	}

	public void setExpirationDatetime(String expirationDatetime) {
		this.expirationDatetime = expirationDatetime;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}
	
}
