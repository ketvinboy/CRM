package com.sunshine.Model;

import java.io.Serializable;
import java.sql.Date;

public class Bookinfo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String book_id;       //预订ID，主键，自增
	private String title;         //标题
	private String destine_desc;          //描述
	private Date book_time;       //预订日期
	private Date create_time;     //创建日期
	private String customer_id;   //客户id,外键关联
	private String cust_name;     //客户名称
	private Date Yuding_star_date;
	private Date Yuding_end_date;
	private String    deal_state;//预约处理状态 1-预约时间还没有到  0-预约时间临近
	private String user_qq;//用户qq
	private String user_id;//创建者ID
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_qq() {
		return user_qq;
	}
	public void setUser_qq(String user_qq) {
		this.user_qq = user_qq;
	}
	public String getDeal_state() {
		return deal_state;
	}
	public void setDeal_state(String deal_state) {
		this.deal_state = deal_state;
	}
	public Date getYuding_star_date() {
		return Yuding_star_date;
	}
	public void setYuding_star_date(Date yuding_star_date) {
		Yuding_star_date = yuding_star_date;
	}
	public Date getYuding_end_date() {
		return Yuding_end_date;
	}
	public void setYuding_end_date(Date yuding_end_date) {
		Yuding_end_date = yuding_end_date;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getCust_name() {
		return cust_name;
	}
	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}
	public String getBook_id() {
		return book_id;
	}
	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDestine_desc() {
		return destine_desc;
	}
	public void setDestine_desc(String destine_desc) {
		this.destine_desc = destine_desc;
	}
	public Date getBook_time() {
		return book_time;
	}
	public void setBook_time(Date book_time) {
		this.book_time = book_time;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
	
	

}
