package com.sunshine.Model;

import java.io.Serializable;
import java.sql.Date;

public class Customer implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String customer_id;     //客户ID，主键，自增
	private String cust_name;       //客户名称
	private String cust_type;       //客户类型，1—企业；—院校；3—代理
	private String cust_background; //客户背景，1—民营；2—国营；3—合资
	private String listed;          //是否上市，1—是；0—否
	private String reg_capital;     //注册资本
	private String year_sales;      //年销售额
	private String entp_scale;      //企业规模
	private String tester_no;       //测试人员
	private String url;             //公司网址
	private String zip_code;        //邮政编码
	private String address;         //公司地址
	private String main_products;   //主营产品
	private String major_services;  //主要服务
	private String status;          //客户状态，1—潜在客户；2—正式客户；3—放弃客户；4—签约客户
	private String user_id;         //指派人，外键
	private Date create_time;       //创建时间
	
	private String user_name;      //指派人
	private String role_id;    //关联用户角色
	
	public String getRole_id() {
		return role_id;
	}
	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
	public String getCust_type() {
		return cust_type;
	}
	public void setCust_type(String cust_type) {
		this.cust_type = cust_type;
	}
	public String getCust_background() {
		return cust_background;
	}
	public void setCust_background(String cust_background) {
		this.cust_background = cust_background;
	}
	public String getListed() {
		return listed;
	}
	public void setListed(String listed) {
		this.listed = listed;
	}
	public String getReg_capital() {
		return reg_capital;
	}
	public void setReg_capital(String reg_capital) {
		this.reg_capital = reg_capital;
	}
	public String getYear_sales() {
		return year_sales;
	}
	public void setYear_sales(String year_sales) {
		this.year_sales = year_sales;
	}
	public String getEntp_scale() {
		return entp_scale;
	}
	public void setEntp_scale(String entp_scale) {
		this.entp_scale = entp_scale;
	}
	public String getTester_no() {
		return tester_no;
	}
	public void setTester_no(String tester_no) {
		this.tester_no = tester_no;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMain_products() {
		return main_products;
	}
	public void setMain_products(String main_products) {
		this.main_products = main_products;
	}
	public String getMajor_services() {
		return major_services;
	}
	public void setMajor_services(String major_services) {
		this.major_services = major_services;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

}
