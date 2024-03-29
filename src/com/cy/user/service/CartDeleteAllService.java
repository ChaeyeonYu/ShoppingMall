package com.cy.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cy.common.IShoppingMallService;
import com.cy.persistence.CartDao;

public class CartDeleteAllService implements IShoppingMallService {

	private CartDao cartDao = CartDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_id = request.getParameter("user_id");
		boolean result = cartDao.deleteAllCart(user_id);
		
		if(result){
			request.setAttribute("data", "success");
		}
		
		return "WEB-INF/views/data.jsp";
	}

}
