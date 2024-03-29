package com.cy.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		String buy_receiver = request.getParameter("buy_receiver");
		String user_tel = request.getParameter("user_tel");
		String user_address = request.getParameter("user_address");
		
		//구매하기 창에서 넘어온 배송정보 받기
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("buy_receiver", buy_receiver);
		paramMap.put("user_tel", user_tel);
		paramMap.put("user_address", user_address);
		paramMap.put("user_id", user_id);
		
		List<CartVo> cartList = new ArrayList<>();
		
		//바로 구매인지 장바구니에 있는 내역을 구매한건지 확인
		String buy_now = request.getParameter("buy_now");
		if(buy_now!=null && buy_now.equals("Y")){
			//바로 구매 폼의 내역을 받기
			int product_num = Integer.parseInt(request.getParameter("product_num"));
			int product_count = Integer.parseInt(request.getParameter("product_count"));
			CartVo vo = new CartVo();
			vo.setProduct_num(product_num);
			vo.setProduct_count(product_count);
			cartList.add(vo);
		}else{
			//장바구니에 있는 내역 받기
			cartList = cartDao.getCartList(user_id);
		}
		
		//주문 내역들을 BuyDao.insert 하기
		boolean result = buyDao.order(cartList, paramMap);
		int buy_num = 0;
		if(result){
			//주문 성공시 받아온 주소로 사용자 주소 업데이트
			buyDao.updateUserAddress(paramMap);
			
			//주문 성공시 사용자의 장바구니 비우기
			cartDao.deleteAllCart(user_id);
			
			//성공시 주문 번호를 가지고 성공 페이지로 이동
			buy_num = buyDao.getBuyNum();
		}
//		else{
//			//실패시 실패 페이지로 이동 //재고 부족
//		}
		
		System.out.println("order service result: " + result);
		
		page = IConstants.STR_REDIRECT + "buy-result.user-cy?buy_num="+buy_num;
//		page = IConstants.STR_REDIRECT + "main.cy";
		return page;
	}

}
