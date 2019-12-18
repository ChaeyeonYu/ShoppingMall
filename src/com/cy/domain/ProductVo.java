package com.cy.domain;

import java.sql.Timestamp;

public class ProductVo {
	private int product_num;
	private String product_name;
	private String category_code;
	private String category_name; //카테고리 코드 설명을 위해 추가
	private String product_content;
	private int product_price;
	private String product_img;
	private int product_stock;
	private Timestamp product_reg_date;
	
	private int product_count;
	public ProductVo() {
		super();
	}
	public ProductVo(int product_num, String product_name, String category_code, String category_name,
			String product_content, int product_price, String product_img, int product_stock,
			Timestamp product_reg_date) {
		super();
		this.product_num = product_num;
		this.product_name = product_name;
		this.category_code = category_code;
		this.category_name = category_name;
		this.product_content = product_content;
		this.product_price = product_price;
		this.product_img = product_img;
		this.product_stock = product_stock;
		this.product_reg_date = product_reg_date;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getProduct_content() {
		return product_content;
	}
	public void setProduct_content(String product_content) {
		this.product_content = product_content;
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
	public int getProduct_stock() {
		return product_stock;
	}
	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}
	public Timestamp getProduct_reg_date() {
		return product_reg_date;
	}
	public void setProduct_reg_date(Timestamp product_reg_date) {
		this.product_reg_date = product_reg_date;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	@Override
	public String toString() {
		return "ProductVo [product_num=" + product_num + ", product_name=" + product_name + ", category_code="
				+ category_code + ", category_name=" + category_name + ", product_content=" + product_content
				+ ", product_price=" + product_price + ", product_img=" + product_img + ", product_stock="
				+ product_stock + ", product_reg_date=" + product_reg_date + ", product_count=" + product_count + "]";
	}
}
