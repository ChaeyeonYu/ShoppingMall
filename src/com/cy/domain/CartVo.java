package com.cy.domain;

public class CartVo {
	private int cart_num;
	private String user_id;
	private int product_num;
	private int product_count;
	
	private String product_name;
	private String category_code;
	private String category_name;
	private String product_img;
	private int product_price;
	private int product_stock;
	
	public CartVo() {
		super();
	}
	public CartVo(int cart_num, String user_id, int product_num, int product_count) {
		super();
		this.cart_num = cart_num;
		this.user_id = user_id;
		this.product_num = product_num;
		this.product_count = product_count;
	}
	public CartVo(int cart_num, String user_id, int product_num, int product_count, String product_name,
			String category_code, String category_name, String product_img, int product_price, int product_stock) {
		super();
		this.cart_num = cart_num;
		this.user_id = user_id;
		this.product_num = product_num;
		this.product_count = product_count;
		this.product_name = product_name;
		this.category_code = category_code;
		this.category_name = category_name;
		this.product_img = product_img;
		this.product_price = product_price;
		this.product_stock = product_stock;
	}
	
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
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
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_stock() {
		return product_stock;
	}
	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}
	@Override
	public String toString() {
		return "CartVo [cart_num=" + cart_num + ", user_id=" + user_id + ", product_num=" + product_num
				+ ", product_count=" + product_count + ", product_name=" + product_name + ", category_code="
				+ category_code + ", category_name=" + category_name + ", product_img=" + product_img
				+ ", product_price=" + product_price + ", product_stock=" + product_stock + "]";
	}
}
