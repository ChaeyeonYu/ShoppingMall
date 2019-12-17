package com.cy.admin.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.persistence.CategoryDao;

public class CategoryUpdateProService implements IShoppingMallService {

	CategoryDao categoryDao = CategoryDao.getInstance();
	
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
		String category_name = request.getParameter("category_name");
		CategoryVo vo = new CategoryVo(category_code, category_name);
		
		boolean result = categoryDao.updateCategory(vo);
		
		if(!result){
			//추가 실패시 실패메세지 추가
		}
		page = IConstants.STR_REDIRECT + "category.admin-cy";
		
		return page;
	}

}
