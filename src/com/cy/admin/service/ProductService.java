package com.cy.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.domain.ProductVo;
import com.cy.persistence.CategoryDao;
import com.cy.persistence.ProductDao;

public class ProductService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//관리자 기능
		//제품 전체보기 //수정, 삭제, 등록 할 수 있도록
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
		CategoryVo categoryVo = new CategoryVo(category_code, category_name);
		request.setAttribute("categoryVo", categoryVo);
		
		List<ProductVo> list = productDao.getListByCategoryCode(category_code);
		request.setAttribute("list", list);
		page = "WEB-INF/views/admin/admin_product.jsp";
		
		return page;
	}

}
