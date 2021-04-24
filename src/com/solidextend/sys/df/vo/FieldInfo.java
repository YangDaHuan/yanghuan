package com.solidextend.sys.df.vo;

public class FieldInfo {

	private String id;
	private String no;
	private String name;
	private String type;
	private String desc;
	private int primary = 0;
	private int unique = 0;
	private int fieldNull = 1;
	private String dictId;
	private String length;
	private String defaultValue;
	private String formId;
	/*************数据源配置*************/
	private int dsType = 0;//数据源类型
	private String dsValue;//数据源值/字典值/表单ID
	private String dsUrlId;//字典描述/关联字段ID
	private String dsUrlText;//关联描述字段ID
	/********** 数据库表属性 *******************/
	private String dbId;//字段名
	private String dbType; //字段类型
	private int dbLength; //字段长度
	private int dbNull = 1; //是否与数据库表字段绑定
	/**************校验属性******************/
	private String fieldEquals;//字段验证
	private int minLen;//最小长度
	private int maxLen;//最大长度
	/*************Grid属性**************/
	private int gridQuery = 0; //支持查询
	private int gridHide = 0; //列表隐藏
	private int gridWidth=100; //列表宽度	
	/*************操作设置**************/
	private int allowAdd = 1; //允许添加
	private int allowUpdate = 1;//允许修改
	private String allowValue; //如果不允许新建，那么此值为保存数据库时的默认值
	/** 字段排序 */
	private int orderBy;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getPrimary() {
		return primary;
	}
	public void setPrimary(int primary) {
		this.primary = primary;
	}
	public int getUnique() {
		return unique;
	}
	public void setUnique(int unique) {
		this.unique = unique;
	}
	public int getFieldNull() {
		return fieldNull;
	}
	public void setFieldNull(int fieldNull) {
		this.fieldNull = fieldNull;
	}
	public String getDictId() {
		return dictId;
	}
	public void setDictId(String dictId) {
		this.dictId = dictId;
	}
	public String getLength() {
		return length;
	}
	public void setLength(String length) {
		this.length = length;
	}
	public String getDefaultValue() {
		return defaultValue;
	}
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public String getDbId() {
		return dbId;
	}
	public void setDbId(String dbId) {
		this.dbId = dbId;
	}
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
	}

	public int getDbLength() {
		return dbLength;
	}
	public void setDbLength(int dbLength) {
		this.dbLength = dbLength;
	}
	public int getDsType() {
		return dsType;
	}
	public void setDsType(int dsType) {
		this.dsType = dsType;
	}
	public String getDsValue() {
		return dsValue;
	}
	public void setDsValue(String dsValue) {
		this.dsValue = dsValue;
	}
	public String getDsUrlId() {
		return dsUrlId;
	}
	public void setDsUrlId(String dsUrlId) {
		this.dsUrlId = dsUrlId;
	}
	public String getDsUrlText() {
		return dsUrlText;
	}
	public void setDsUrlText(String dsUrlText) {
		this.dsUrlText = dsUrlText;
	}
	public int getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(int orderBy) {
		this.orderBy = orderBy;
	}
	public String getFieldEquals() {
		return fieldEquals;
	}
	public void setFieldEquals(String fieldEquals) {
		this.fieldEquals = fieldEquals;
	}
	public int getMinLen() {
		return minLen;
	}
	public void setMinLen(int minLen) {
		this.minLen = minLen;
	}
	public int getMaxLen() {
		return maxLen;
	}
	public void setMaxLen(int maxLen) {
		this.maxLen = maxLen;
	}
	public int getGridQuery() {
		return gridQuery;
	}
	public void setGridQuery(int gridQuery) {
		this.gridQuery = gridQuery;
	}
	public int getGridHide() {
		return gridHide;
	}
	public void setGridHide(int gridHide) {
		this.gridHide = gridHide;
	}
	public int getGridWidth() {
		return gridWidth;
	}
	public void setGridWidth(int gridWidth) {
		this.gridWidth = gridWidth;
	}
	public int getDbNull() {
		return dbNull;
	}
	public void setDbNull(int dbNull) {
		this.dbNull = dbNull;
	}
	public int getAllowAdd() {
		return allowAdd;
	}
	public void setAllowAdd(int allowAdd) {
		this.allowAdd = allowAdd;
	}
	public int getAllowUpdate() {
		return allowUpdate;
	}
	public void setAllowUpdate(int allowUpdate) {
		this.allowUpdate = allowUpdate;
	}
	public String getAllowValue() {
		return allowValue;
	}
	public void setAllowValue(String allowValue) {
		this.allowValue = allowValue;
	}
}
