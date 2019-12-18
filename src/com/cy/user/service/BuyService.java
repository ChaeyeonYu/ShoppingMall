package com.cy.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.CartVo;
import com.cy.domain.UserVo;
import com.cy.persistence.CartDao;
import com.cy.persistence.UserDao;

public class BuyService implements IShoppingMallService {

	private CartDao cartDao = CartDao.getInstance();
	private UserDao userDao = UserDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인한 사용자인지 아닌지 확인 
		//비회원일 경우 main 페이지로 리다이렉트
		String page = IConstants.STR_REDIRECT +  "main.cy";
						
		HttpSession session = request.getSession();
		String session_user_id = (String)session.getAttribute("user_id");
		if(session_user_id == null || session_user_id.equals("")) {
			session.setAttribute("msg", "not_login");
			return page;
		}
		
		String user_id = request.getParameter("user_id");
		request.setAttribute("user_id", user_id);
		
		List<CartVo> list = cartDao.getCartList(user_id);
		request.setAttribute("list", list);
		
		UserVo userVo = userDao.getUserInfo(user_id);
		request.setAttribute("userVo", userVo);
		
		page = "WEB-INF/views/buy.jsp";
		
		return page;
	}

}
