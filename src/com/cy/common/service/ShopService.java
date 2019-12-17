package com.cy.common.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.domain.ProductVo;
import com.cy.persistence.CategoryDao;
import com.cy.persistence.ProductDao;

public class ShopService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<CategoryVo> categoryList = categoryDao.readCategory();
		request.setAttribute("categoryList", categoryList);
		
		List<ProductVo> productList = productDao.getList();
		request.setAttribute("productList", productList);
		
		return "WEB-INF/views/shop.jsp";
	}

}
