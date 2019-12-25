package com.cy.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cy.common.IShoppingMallService;
import com.cy.persistence.UserDao;

public class CheckIdServiceAjax implements IShoppingMallService {

	private UserDao userDao = UserDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String check_user_id = request.getParameter("check_user_id");
		boolean result = userDao.checkId(check_user_id);
//		System.out.println("user_id_check: " + check_user_id);
		
		String data = "can_not_be_used_id";
		if(!result){
			data = "available_id";
		}
		request.setAttribute("data", data);
		
		return "WEB-INF/views/data.jsp";
	}

}
