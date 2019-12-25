package com.cy.domain;

public class CategoryVo {
	private String category_code;
	private String category_name;
	private int cnt; //카테고리에 해당하는 제품 수를 보이기 위해 만든 공간
	
	public CategoryVo() {
		super();
	}
	public CategoryVo(String category_code, String category_name) {
		super();
		this.category_code = category_code;
		this.category_name = category_name;
	}
	public CategoryVo(String category_code, String category_name, int cnt) {
		super();
		this.category_code = category_code;
		this.category_name = category_name;
		this.cnt = cnt;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	@Override
	public String toString() {
		return "CategoryVo [category_code=" + category_code + ", category_name=" + category_name + ", cnt=" + cnt + "]";
	}
}
