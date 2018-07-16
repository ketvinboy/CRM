package com.sunshine.Model;

import java.io.Serializable;
import java.sql.Date;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private  String   user_id;  //用户ID,主键,自增
	private  String user_name;  //用户名，唯一键 
	private  String  password;  //密码
	private  String       sex;  //性别，1—男；0—女
	private  Date    birthday;  //出生日期
	private  String   role_id;  //用户角色，1—系统管理员；2—业务经理；3—销售
	private  String    status;  //状态，1—正常；0—禁用
	private Date star_tdate;
	private Date end_date;
	private String user_qq;    //用户qq
	
	public String getUser_qq() {
		return user_qq;
	}
	public void setUser_qq(String user_qq) {
		this.user_qq = user_qq;
	}
	public Date getStar_tdate() {
		return star_tdate;
	}
	public void setStar_tdate(Date star_tdate) {
		this.star_tdate = star_tdate;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getRole_id() {
		return role_id;
	}
	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
