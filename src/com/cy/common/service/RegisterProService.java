package com.cy.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.Icon;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.UserVo;
import com.cy.persistence.UserDao;

public class RegisterProService implements IShoppingMallService {

	private UserDao userDao = UserDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_id = request.getParameter("user_id"); 
		String user_passwd = request.getParameter("user_passwd"); 
		String user_name = request.getParameter("user_name"); 
		
		UserVo userVo = new UserVo();
		userVo.setUser_id(user_id);
		userVo.setUser_passwd(user_passwd);
		userVo.setUser_name(user_name);
		
		HttpSession session = request.getSession(); 
		boolean result = userDao.insertUser(userVo);
		String path = IConstants.STR_REDIRECT + "login-register.cy";
		
		if (result == true){
			path = IConstants.STR_REDIRECT + "main.cy";
			session.setAttribute("user_id", user_id);
			session.setAttribute("msg", "user_regist_success");
		}else{
			session.setAttribute("msg", "user_regist_fail");
		}
		
		return path;
	}

}
