package com.cy.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.Icon;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.UserVo;
import com.cy.persistence.UserDao;

public class PerSonalInformationProService implements IShoppingMallService {

	private UserDao userDao = UserDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인한 사용자인지 아닌지 확인 
		//비회원일 경우 다시 상품 상세보기 페이지로 이동 후 메세지 띄우기
		String page = "WEB-INF/views/data.jsp";
						
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || user_id.equals("")) {
			session.setAttribute("data", "not_login");
			return page;
		}
		
		String user_name = request.getParameter("user_name");
		String user_tel = request.getParameter("user_tel");
		String user_address = request.getParameter("user_address");
		String user_passwd = request.getParameter("user_passwd");
		
		UserVo vo = new UserVo(user_id, user_name, user_passwd, user_address, user_tel);
		
		boolean result = userDao.updateUserInfo(vo);
		if(!result) {
			session.setAttribute("msg", "fail");
		}else {
			session.setAttribute("msg", "success");
		}
		page =  IConstants.STR_REDIRECT +  "personal-information.user-cy";
		
		
		return page;
	}

}
