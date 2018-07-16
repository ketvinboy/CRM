package com.sunshine.Model;

import java.io.Serializable;

public class Role implements Serializable {

	private static final long serialVersionUID = 1L;
    
	private String role_id;    //角色ID，主键，自增
	private String role_name;  //角色名 
	private String role_desc;  // 角色描述
	
	public String getRole_id() {
		return role_id;
	}
	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	public String getRole_desc() {
		return role_desc;
	}
	public void setRole_desc(String role_desc) {
		this.role_desc = role_desc;
	}
	
	
	
}
