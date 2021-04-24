package com.solidextend.core.web;

import java.util.ArrayList;
import java.util.List;

/**
 * Tree的Json对象，用于处理前端Tree的传值
 * @author 王聚金
 * @date 2014-01-02
 */
public class JsonTree {

	private String id;
	private String text;
	private String state = "closed";
	private int type;
	private String iconCls;
	private String parentId;
	private boolean leaf = false;
	private boolean publish = false;
	private List<JsonTree> children = new ArrayList<JsonTree>();
	
	public JsonTree(){}
	
	public JsonTree(String id, String text){
		this.id = id;
		this.text = text;			
	}
	public JsonTree(String id, String text, String iconCls){
		this.id = id;
		this.text = text;			
		this.iconCls = iconCls;
	}
	
	/**
	 * @param id 
	 * @param text 显示名称
	 * @param iconCls 图标
	 * @param bool 节点是否打开
	 */
	public JsonTree(String id, String text, String iconCls, boolean bool){
		this.id = id;
		this.text = text;
		this.iconCls = iconCls;
		this.state = bool?"open":"closed";
		this.type = bool?1:2;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

	public List<JsonTree> getChildren() {
		return children;
	}

	public void setChildren(List<JsonTree> children) {
		this.children = children;
	}
	
	public void addChildren(JsonTree jsonTree){
		this.children.add(jsonTree);
	}

	public String getState() {
		return state;
	}

	/**
	 * 节点状态, 'open' or 'closed'.
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public boolean isLeaf() {
		return leaf;
	}

	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}

	public boolean isPublish() {
		return publish;
	}

	public void setPublish(boolean publish) {
		this.publish = publish;
	}
}
