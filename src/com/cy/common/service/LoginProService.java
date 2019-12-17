package com.cy.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.persistence.UserDao;

public class LoginProService implements IShoppingMallService {

	private UserDao userDao = UserDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_id = request.getParameter("user_id"); 
		String user_passwd = request.getParameter("user_passwd"); 

		HttpSession session = request.getSession(); 
		int result = userDao.userCheck(user_id, user_passwd);

		String path = IConstants.STR_REDIRECT + "main.cy";
		
		switch (result) {
		case UserDao.LOGIN_SUCCESS:
			session.setAttribute("user_id", user_id);
			break;
		case UserDao.INCORRECT_PASSWD:
			session.setAttribute("msg", "login_incorrect_passwd");
			path = IConstants.STR_REDIRECT + "login-register.cy";
			break;
		case UserDao.ID_NOT_FOUND:
			session.setAttribute("msg", "login_id_not_found");
			path = IConstants.STR_REDIRECT + "login-register.cy";
			break;
		}
		return path;
	}
}
