package com.cy.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IShoppingMallService;
import com.cy.domain.BuyVo;
import com.cy.persistence.BuyDao;

public class BuyResultService implements IShoppingMallService {

	private BuyDao buyDao = BuyDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String page = "WEB-INF/views/buy_fail.jsp";
		
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		
		int buy_num = Integer.parseInt(request.getParameter("buy_num"));
		if(buy_num != 0) {
			
			List<BuyVo> list = buyDao.getOrder(user_id, buy_num);
			request.setAttribute("list", list);
			page = "WEB-INF/views/buy_success.jsp";
		}
		
		return page;
	}

}
