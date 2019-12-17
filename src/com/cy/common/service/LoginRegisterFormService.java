package com.cy.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cy.common.IShoppingMallService;

public class LoginRegisterFormService implements IShoppingMallService {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "WEB-INF/views/login-register.jsp";
	}

}
