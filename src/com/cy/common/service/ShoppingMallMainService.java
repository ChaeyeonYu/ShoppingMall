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

public class ShoppingMallMainService implements IShoppingMallService {

	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//카테고리 목록 전체
		List<CategoryVo> categoryList = categoryDao.readCategory();
		request.setAttribute("categoryList", categoryList);
		
		//검색
		String keyword = "";
//		if(keyword!=null && !keyword.equals("")){
		if(keyword!=null){
			keyword = request.getParameter("keyword");
		}
//		System.out.println("검색한 키워드: " + keyword);
		
		//페이징
		int nowPage = 1;
		String strPage = request.getParameter("page");
				
		if(strPage!=null && !strPage.equals("")) {
			nowPage = Integer.parseInt(strPage);
		}
		//검색 추가ver pagingDto
		PagingDto pagingDto = new PagingDto(keyword, nowPage);
		
		//제품 목록 전체
		List<ProductVo> productList = productDao.getList(pagingDto, keyword);
		request.setAttribute("productList", productList);
		request.setAttribute("pagingDto", pagingDto);
		request.setAttribute("keyword", keyword);
		
//		System.out.println("pagingDto: " + pagingDto);
//		System.out.println("productList: " + productList);
		
		//화면에 띄울 로그인 정보
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		request.setAttribute("user_id", user_id);
		
		return "WEB-INF/views/main.jsp";
	}

}
