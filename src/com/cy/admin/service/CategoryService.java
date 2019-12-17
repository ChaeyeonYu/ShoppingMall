package com.cy.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.persistence.CategoryDao;

public class CategoryService implements IShoppingMallService {
	//카테고리 전체보기
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
		
		List<CategoryVo> list = categoryDao.readCategory();
		request.setAttribute("list", list);
		page = "WEB-INF/views/admin/admin_category.jsp";
		
		return page;
	}

}
