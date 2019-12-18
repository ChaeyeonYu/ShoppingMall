package com.cy.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.BuyVo;
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
		
		String buy_receiver = request.getParameter("buy_receiver");
		String user_tel = request.getParameter("user_tel");
		String user_address = request.getParameter("user_address");
		
		//구매하기 창에서 넘어온 배송정보 받기
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("buy_receiver", buy_receiver);
		paramMap.put("user_tel", user_tel);
		paramMap.put("user_address", user_address);
		paramMap.put("user_id", user_id);
		
		//장바구니에 있는 내역 받기
		List<CartVo> cartList = cartDao.getCartList(user_id);
		
		//장바구니 내역들을 BuyDao.insert 하기
		boolean result = buyDao.order(cartList, paramMap);
		if(result){
			//주문 성공시 받아온 주소로 사용자 주소 업데이트
			buyDao.updateUserAddress(paramMap);
			
//			BuyVo buyVo = new BuyVo();
//			buyVo.setBuy_receiver(buy_receiver);
//			buyVo.setUser_tel(user_tel);
//			buyVo.setUser_address(user_address);
//			
//			request.setAttribute("buyVo", buyVo);
//			request.setAttribute("list", cartList);
			
			//성공시 성공 페이지로 이동
			
			//redirect를 해야 함..
			
		}else{
			//실패시 실패 페이지로 이동 //재고 부족
		}
		
		System.out.println("order service result: " + result);
		
		
		page = IConstants.STR_REDIRECT + "main.cy";
		return page;
	}

}
