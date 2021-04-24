package com.solidextend.sys.sms.vo;

public class SmsContent {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.ID
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.CONTENT
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String content;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.SENDER_ID
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String senderId;
    
    private String senderName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.MODULE_NAME
     *sms_module_id
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String smsModuleId;
    
    private String smsModuleName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.SEND_TIME
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String sendTime;
    
    private String startTime;
    private String endTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.SMS_TYPE
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String smsType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SYS_SMS_CONTENT.MOBILE_NUM
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    private String mobileNum;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SYS_SMS_CONTENT.ID
     *
     * @return the value of SYS_SMS_CONTENT.ID
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SYS_SMS_CONTENT.ID
     *
     * @param id the value for SYS_SMS_CONTENT.ID
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SYS_SMS_CONTENT.CONTENT
     *
     * @return the value of SYS_SMS_CONTENT.CONTENT
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SYS_SMS_CONTENT.CONTENT
     *
     * @param content the value for SYS_SMS_CONTENT.CONTENT
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SYS_SMS_CONTENT.SENDER_ID
     *
     * @return the value of SYS_SMS_CONTENT.SENDER_ID
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public String getSenderId() {
        return senderId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SYS_SMS_CONTENT.SENDER_ID
     *
     * @param senderId the value for SYS_SMS_CONTENT.SENDER_ID
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public void setSenderId(String senderId) {
        this.senderId = senderId == null ? null : senderId.trim();
    }


    public String getSmsModuleId() {
		return smsModuleId;
	}

	public void setSmsModuleId(String smsModuleId) {
		this.smsModuleId = smsModuleId;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SYS_SMS_CONTENT.SEND_TIME
     *
     * @return the value of SYS_SMS_CONTENT.SEND_TIME
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public String getSendTime() {
        return sendTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SYS_SMS_CONTENT.SEND_TIME
     *
     * @param sendTime the value for SYS_SMS_CONTENT.SEND_TIME
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public void setSendTime(String sendTime) {
        this.sendTime = sendTime == null ? null : sendTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SYS_SMS_CONTENT.SMS_TYPE
     *
     * @return the value of SYS_SMS_CONTENT.SMS_TYPE
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public String getSmsType() {
        return smsType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SYS_SMS_CONTENT.SMS_TYPE
     *
     * @param smsType the value for SYS_SMS_CONTENT.SMS_TYPE
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public void setSmsType(String smsType) {
        this.smsType = smsType == null ? null : smsType.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SYS_SMS_CONTENT.MOBILE_NUM
     *
     * @return the value of SYS_SMS_CONTENT.MOBILE_NUM
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public String getMobileNum() {
        return mobileNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SYS_SMS_CONTENT.MOBILE_NUM
     *
     * @param mobileNum the value for SYS_SMS_CONTENT.MOBILE_NUM
     *
     * @mbggenerated Wed Feb 12 09:06:00 CST 2014
     */
    public void setMobileNum(String mobileNum) {
        this.mobileNum = mobileNum == null ? null : mobileNum.trim();
    }

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getSmsModuleName() {
		return smsModuleName;
	}

	public void setSmsModuleName(String smsModuleName) {
		this.smsModuleName = smsModuleName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime; 
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}