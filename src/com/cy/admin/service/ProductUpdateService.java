package com.cy.admin.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.ProductVo;
import com.cy.persistence.CategoryDao;
import com.cy.persistence.ProductDao;

public class ProductUpdateService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String page = IConstants.STR_REDIRECT +  "main.cy";
		
		//관리자가 맞는지 확인
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || !user_id.equals("admin")){
			session.setAttribute("msg", "not_admin");
			return page;
		}
		
		String category_code = request.getParameter("category_code");
		String category_name = categoryDao.getCategoryName(category_code);
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		ProductVo productVo = productDao.getProductInfoByProductNum(product_num);
		productVo.setCategory_code(category_code);
		productVo.setCategory_name(category_name);
		request.setAttribute("productVo", productVo);
		page = "WEB-INF/views/admin/admin_product_update.jsp";
		
		return page;
	}

}
