package com.cy.user.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cy.common.IShoppingMallService;
import com.cy.persistence.CartDao;

public class CartUpdateService implements IShoppingMallService {

	private CartDao cartDao = CartDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int cart_num = Integer.parseInt(request.getParameter("cart_num"));
		int product_count = Integer.parseInt(request.getParameter("product_count"));
		String user_id = request.getParameter("user_id");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cart_num", cart_num);
		paramMap.put("product_count", product_count);
		paramMap.put("user_id", user_id);
		
		cartDao.updateCart(paramMap);
//		boolean result = cartDao.updateCart(paramMap);
		
//		if(result){
//			request.setAttribute("data", "success");
//		}
		
		return "WEB-INF/views/data.jsp";
	}

}
