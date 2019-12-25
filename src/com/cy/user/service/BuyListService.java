package com.cy.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.BuyVo;
import com.cy.persistence.BuyDao;

public class BuyListService implements IShoppingMallService {

	private BuyDao buyDao = BuyDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인한 사용자인지 아닌지 확인 
		//비회원일 경우 main 페이지로 리다이렉트
		String page = IConstants.STR_REDIRECT +  "main.cy";
						
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || user_id.equals("")) {
			session.setAttribute("msg", "not_login");
			return page;
		}
		
		List<BuyVo> list = buyDao.getOrderListAll(user_id);
		request.setAttribute("list", list);
		
		page = "WEB-INF/views/buy_list.jsp";
		
		return page;
	}

}
