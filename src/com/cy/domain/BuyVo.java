package com.cy.domain;

import java.sql.Timestamp;

public class BuyVo {
	private int buy_num;
	private String user_id;
	private int product_num;
	private int product_count;
	private Timestamp buy_date;
	private String user_address;
	private String user_tel;
	private String buy_receiver;
	
	private String product_name;
	private String product_img;
	private int product_price;
	
	public BuyVo() {
		super();
	}
	
	public BuyVo(int buy_num, String user_id, int product_num, int product_count, Timestamp buy_date,
			String user_address, String user_tel, String buy_receiver, String product_name, int product_price) {
		super();
		this.buy_num = buy_num;
		this.user_id = user_id;
		this.product_num = product_num;
		this.product_count = product_count;
		this.buy_date = buy_date;
		this.user_address = user_address;
		this.user_tel = user_tel;
		this.buy_receiver = buy_receiver;
		this.product_name = product_name;
		this.product_price = product_price;
	}

	public int getBuy_num() {
		return buy_num;
	}
	public void setBuy_num(int buy_num) {
		this.buy_num = buy_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	public Timestamp getBuy_date() {
		return buy_date;
	}
	public void setBuy_date(Timestamp buy_date) {
		this.buy_date = buy_date;
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
	public String getBuy_receiver() {
		return buy_receiver;
	}
	public void setBuy_receiver(String buy_receiver) {
		this.buy_receiver = buy_receiver;
	}

	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}

	@Override
	public String toString() {
		return "BuyVo [buy_num=" + buy_num + ", user_id=" + user_id + ", product_num=" + product_num
				+ ", product_count=" + product_count + ", buy_date=" + buy_date + ", user_address=" + user_address
				+ ", user_tel=" + user_tel + ", buy_receiver=" + buy_receiver + ", product_name=" + product_name
				+ ", product_img=" + product_img + ", product_price=" + product_price + "]";
	}
	
}
