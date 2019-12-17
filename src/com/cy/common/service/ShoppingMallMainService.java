package com.cy.common.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.domain.ProductVo;
import com.cy.persistence.CategoryDao;
import com.cy.persistence.ProductDao;

import oracle.net.aso.p;

public class ShoppingMallMainService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<CategoryVo> categoryList = categoryDao.readCategory();
		request.setAttribute("categoryList", categoryList);
		
		List<ProductVo> productList = productDao.getList();
		request.setAttribute("productList", productList);
		
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		request.setAttribute("user_id", user_id);
		
		return "WEB-INF/views/main.jsp";
	}

}
