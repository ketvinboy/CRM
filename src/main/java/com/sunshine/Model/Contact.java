package com.sunshine.Model;

import java.io.Serializable;
import java.sql.Date;


public class Contact implements Serializable{

	private static final long serialVersionUID = 1L;
    
	private String cont_id;           //联络ID，主键，自增
	private String cust_id;           //客户ID，外键
	private String cont_name;         //客户姓名
	private String cont_dept;         //客户部门
	private String cont_position;     //客户职位
	private String cont_telephone;    //客户电话
	private String cont_mobile;       //客户手机
	private String cont_email;        //客户邮箱
	private String cont_qq;           //客户QQ
	private String tech_degree;       //技术程度
	private String more_info;         //其他信息
	private Date create_time;         //创建日期
	private String cust_name;
	private Date  start_date;
	private Date   end_date;
	
	public String getCust_name() {
		return cust_name;
	}
	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}
	public String getCont_id() {
		return cont_id;
	}
	public void setCont_id(String cont_id) {
		this.cont_id = cont_id;
	}
	public String getCust_id() {
		return cust_id;
	}
	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}
	public String getCont_name() {
		return cont_name;
	}
	public void setCont_name(String cont_name) {
		this.cont_name = cont_name;
	}
	public String getCont_dept() {
		return cont_dept;
	}
	public void setCont_dept(String cont_dept) {
		this.cont_dept = cont_dept;
	}
	public String getCont_position() {
		return cont_position;
	}
	public void setCont_position(String cont_position) {
		this.cont_position = cont_position;
	}
	public String getCont_telephone() {
		return cont_telephone;
	}
	public void setCont_telephone(String cont_telephone) {
		this.cont_telephone = cont_telephone;
	}
	public String getCont_mobile() {
		return cont_mobile;
	}
	public void setCont_mobile(String cont_mobile) {
		this.cont_mobile = cont_mobile;
	}
	public String getCont_email() {
		return cont_email;
	}
	public void setCont_email(String cont_email) {
		this.cont_email = cont_email;
	}
	public String getCont_qq() {
		return cont_qq;
	}
	public void setCont_qq(String cont_qq) {
		this.cont_qq = cont_qq;
	}
	public String getTech_degree() {
		return tech_degree;
	}
	public void setTech_degree(String tech_degree) {
		this.tech_degree = tech_degree;
	}
	public String getMore_info() {
		return more_info;
	}
	public void setMore_info(String more_info) {
		this.more_info = more_info;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	
}
