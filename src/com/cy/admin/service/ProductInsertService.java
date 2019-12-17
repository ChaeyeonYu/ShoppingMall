package com.cy.admin.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.persistence.CategoryDao;

public class ProductInsertService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	
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
		
		//제품 추가 화면 보이기
		String category_code = request.getParameter("category_code");
		String category_name = categoryDao.getCategoryName(category_code);
		CategoryVo categoryVo = new CategoryVo(category_code, category_name);
		
		request.setAttribute("categoryVo", categoryVo);
		page = "WEB-INF/views/admin/admin_product_insert.jsp";
		
		return page;
	}

}
