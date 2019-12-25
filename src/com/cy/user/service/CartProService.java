package com.cy.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IShoppingMallService;
import com.cy.domain.CartVo;
import com.cy.persistence.CartDao;

public class CartProService implements IShoppingMallService {

	private CartDao cartDao = CartDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인한 사용자인지 아닌지 확인 
		//비회원일 경우 다시 상품 상세보기 페이지로 이동 후 메세지 띄우기
		String page = "WEB-INF/views/data.jsp";
				
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || user_id.equals("")) {
			session.setAttribute("data", "not_login");
			return page;
		}
		
		//카트에 추가
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		int product_count = Integer.parseInt(request.getParameter("product_count"));
		CartVo cartVo = new CartVo(0, user_id, product_num, product_count);
		boolean result = cartDao.insertCart(cartVo);
		
		//카트에 추가 후 다시 제품 상세보기로 이동
		if(result){
			session.setAttribute("data", "success");
		}
				
		return page;
	}

}
