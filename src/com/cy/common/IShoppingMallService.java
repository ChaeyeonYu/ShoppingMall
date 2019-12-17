package com.cy.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract interface IShoppingMallService {
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
