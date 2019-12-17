package com.cy.admin.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;

public class UserAdministerService implements IShoppingMallService {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//관리자 기능
		//회원 전체보기
		
		String page = IConstants.STR_REDIRECT +  "main.cy";
		
		//관리자가 맞는지 확인
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || !user_id.equals("admin")){
			session.setAttribute("msg", "not_admin");
			return page;
		}
		
		page = "WEB-INF/views/admin/admin_user.jsp";
		
		return page;
	}

}
