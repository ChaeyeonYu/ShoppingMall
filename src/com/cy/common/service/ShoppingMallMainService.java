package com.cy.common.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IShoppingMallService;
import com.cy.domain.CategoryVo;
import com.cy.domain.PagingDto;
import com.cy.domain.ProductVo;
import com.cy.persistence.CategoryDao;
import com.cy.persistence.ProductDao;

import javafx.scene.control.Pagination;
import oracle.net.aso.p;

public class ShoppingMallMainService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//카테고리 목록 전체
		List<CategoryVo> categoryList = categoryDao.readCategory();
		request.setAttribute("categoryList", categoryList);
		
		//페이징
		int totalCount = productDao.getCount();
		
		int nowPage = 1;
		String strPage = request.getParameter("page");
				
		if(strPage!=null && !strPage.equals("")) {
			nowPage = Integer.parseInt(strPage);
		}
		PagingDto pagingDto = new PagingDto(nowPage);
		
		//제품 목록 전체
//		List<ProductVo> productList = productDao.getList();
		List<ProductVo> productList = productDao.getList(pagingDto);
		request.setAttribute("productList", productList);
		request.setAttribute("pagingDto", pagingDto);
		request.setAttribute("totalCount", totalCount);
		
		System.out.println("totalCount: " + totalCount);
		System.out.println("pagingDto: " + pagingDto);
//		System.out.println("productList: " + productList);
		
		//화면에 띄울 로그인 정보
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		request.setAttribute("user_id", user_id);
		
		//검색
		
		return "WEB-INF/views/main.jsp";
	}

}
