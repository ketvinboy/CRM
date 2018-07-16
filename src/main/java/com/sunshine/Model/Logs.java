package com.sunshine.Model;

import java.io.Serializable;
import java.sql.Date;

public class Logs implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String log_id;        //日志ID，主键，自增
	private String log_title;         //日志标题
	private String log_desc;      //日志描述
	private String cust_id;       //客户ID，外键
	private Date create_time;     //创建日期
	private String cust_name;    //客户名称
	private String user_name;    //指派人名称
	private Date log_start_date;
	private Date log_end_date;
	private String user_id;//用户ID，外键
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getLog_start_date() {
		return log_start_date;
	}
	public void setLog_start_date(Date log_start_date) {
		this.log_start_date = log_start_date;
	}
	public Date getLog_end_date() {
		return log_end_date;
	}
	public void setLog_end_date(Date log_end_date) {
		this.log_end_date = log_end_date;
	}
	public String getLog_id() {
		return log_id;
	}
	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}
	public String getLog_title() {
		return log_title;
	}
	public void setLog_title(String log_title) {
		this.log_title = log_title;
	}
	public String getLog_desc() {
		return log_desc;
	}
	public void setLog_desc(String log_desc) {
		this.log_desc = log_desc;
	}
	public String getCust_id() {
		return cust_id;
	}
	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getCust_name() {
		return cust_name;
	}
	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
}
