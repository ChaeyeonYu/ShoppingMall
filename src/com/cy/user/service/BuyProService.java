package com.cy.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.CartVo;
import com.cy.persistence.BuyDao;
import com.cy.persistence.CartDao;

public class BuyProService implements IShoppingMallService {

	private CartDao cartDao = CartDao.getInstance();
	private BuyDao buyDao = BuyDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인한 사용자인지 아닌지 확인 
		//비회원일 경우 main 페이지로 리다이렉트
		String page = IConstants.STR_REDIRECT +  "main.cy";
				
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || user_id.equals("")) {
			session.setAttribute("msg", "not_login");
			return page;
		}
		
		String user_tel = request.getParameter("user_tel");
		String user_address = request.getParameter("user_address");
		System.out.println(user_tel);
		System.out.println(user_address);
		
		//장바구니에 있는 내역 받기
		List<CartVo> cartList = cartDao.getCartList(user_id);
		
		//장바구니 내역들을 BuyDao.insert 하기
//		boolean result = buyDao.order(cartList);
//		System.out.println("order service result: " + result);
		
		//성공시 성공 페이지로 이동
		//실패시 실패 페이지로 이동
		
		return null;
	}

}
