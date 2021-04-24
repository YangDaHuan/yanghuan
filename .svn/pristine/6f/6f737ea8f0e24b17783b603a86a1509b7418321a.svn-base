package com.solidextend.sys.user.vo;

import org.springframework.context.ApplicationContext;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.input.MongoDBConfig;
import com.solidextend.sys.security.ShiroDataBaseRealm;

/**
 * 系统用信息
 * @author songjunjie
 * @version 2013-12-25 下午4:20:59
 */
public class User {

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
	
	private String ip;
	
	private String leader;
	
	private String expirationDatetime;
	
	private String secret;
	
	private String homeModule;
	
	public String getId() {
		return id;
	}

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

		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		ShiroDataBaseRealm shiroDataBaseRealm = appContext.getBean("shiroDataBaseRealm",ShiroDataBaseRealm.class);
		if(shiroDataBaseRealm.isUserNametoUpperCase()){
			this.loginName = loginName == null ? null : loginName.trim().toUpperCase();
		}else{
			this.loginName = loginName == null ? null : loginName.trim();
		}
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

	/**
	 * ip
	 * @return
	 */
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * 是否领导
	 * @return
	 */
	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}

	/**
	 * 失效时间
	 * @return
	 */
	public String getExpirationDatetime() {
		return expirationDatetime;
	}

	public void setExpirationDatetime(String expirationDatetime) {
		this.expirationDatetime = expirationDatetime;
	}

	/**
	 * 是否保密
	 * @return
	 */
	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getHomeModule() {
		return homeModule;
	}

	public void setHomeModule(String homeModule) {
		this.homeModule = homeModule;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}
	
	
	
}