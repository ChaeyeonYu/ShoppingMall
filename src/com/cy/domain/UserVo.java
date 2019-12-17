package com.cy.domain;

public class UserVo {
	private String user_id;
	private String user_name;
	private String user_passwd;
	private String user_address;
	private String user_tel;
	
	public UserVo() {
		super();
	}
	public UserVo(String user_id, String user_name, String user_passwd, String user_address, String user_tel) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_passwd = user_passwd;
		this.user_address = user_address;
		this.user_tel = user_tel;
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
	public String getUser_passwd() {
		return user_passwd;
	}
	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	
	@Override
	public String toString() {
		return "UserVo [user_id=" + user_id + ", user_name=" + user_name + ", user_passwd=" + user_passwd
				+ ", user_address=" + user_address + ", user_tel=" + user_tel + "]";
	}
}
