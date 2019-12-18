package com.cy.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IShoppingMallService;
import com.cy.persistence.CartDao;

public class CartDeleteService implements IShoppingMallService {

	private CartDao cartDao = CartDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int cart_num = Integer.parseInt(request.getParameter("cart_num"));
		String user_id = request.getParameter("user_id");
		boolean result = cartDao.deleteCart(cart_num, user_id);
		
		if(result){
			request.setAttribute("data", "success");
		}
		
		return "WEB-INF/views/data.jsp";
	}

}
