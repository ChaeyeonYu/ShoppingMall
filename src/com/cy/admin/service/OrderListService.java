package com.cy.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.BuyVo;
import com.cy.persistence.BuyDao;

public class OrderListService implements IShoppingMallService {

	private BuyDao buyDao = BuyDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//관리자 기능
		//주문목록 전체보기
		
		String page = IConstants.STR_REDIRECT +  "main.cy";
		
		//관리자가 맞는지 확인
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || !user_id.equals("admin")){
			session.setAttribute("msg", "not_admin");
			return page;
		}
		
		List<BuyVo> list = buyDao.getOrderListAllAdmin();
		request.setAttribute("list", list);
		
		page = "WEB-INF/views/admin/admin_order_list.jsp";
		
		return page;
	}

}
