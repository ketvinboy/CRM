package com.sunshine.Model;

import java.io.Serializable;
import java.sql.Date;

public class Document implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String doc_id;//文档id，自动增长，主键
	private String doc_title;//文档标题
	private String doc_type;//文档类型
	private Date create_time;//创建日期
	private int customer_id;//客户ID，外键
	private String user_id;//指派人Id，外键（指派人上传会话文档）
	private Date doc_start_date;//开始日期
	private Date doc_end_date;//结束日期
	private String cust_name;//客户名称
	private String doc_path;//文档上传的相对路径
	private String doc_describe;//文档描述
	private String doc_name;//文档名称
	
	public String getDoc_name() {
		return doc_name;
	}
	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}
	public String getDoc_describe() {
		return doc_describe;
	}
	public void setDoc_describe(String doc_describe) {
		this.doc_describe = doc_describe;
	}
	public String getDoc_id() {
		return doc_id;
	}
	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}
	public String getDoc_title() {
		return doc_title;
	}
	public void setDoc_title(String doc_title) {
		this.doc_title = doc_title;
	}
	public String getDoc_type() {
		return doc_type;
	}
	public void setDoc_type(String doc_type) {
		this.doc_type = doc_type;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getDoc_start_date() {
		return doc_start_date;
	}
	public void setDoc_start_date(Date doc_start_date) {
		this.doc_start_date = doc_start_date;
	}
	public Date getDoc_end_date() {
		return doc_end_date;
	}
	public void setDoc_end_date(Date doc_end_date) {
		this.doc_end_date = doc_end_date;
	}
	public String getCust_name() {
		return cust_name;
	}
	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}
	public String getDoc_path() {
		return doc_path;
	}
	public void setDoc_path(String doc_path) {
		this.doc_path = doc_path;
	}
}
