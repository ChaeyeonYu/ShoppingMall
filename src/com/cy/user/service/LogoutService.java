package com.cy.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;

public class LogoutService implements IShoppingMallService {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그아웃
		HttpSession session = request.getSession();
		session.invalidate(); 
		
		return IConstants.STR_REDIRECT +  "main.cy";
	}

}
