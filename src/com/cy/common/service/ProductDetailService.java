package com.cy.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cy.common.IShoppingMallService;
import com.cy.domain.ProductVo;
import com.cy.persistence.ProductDao;

public class ProductDetailService implements IShoppingMallService {

	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int product_num = Integer.parseInt(request.getParameter("product_num"));
		ProductVo productVo = productDao.getProductInfoByProductNum(product_num);
		
		request.setAttribute("productVo", productVo);
		
		return "WEB-INF/views/product_detail.jsp";
	}

}
