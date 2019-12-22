package com.cy.common.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cy.common.IShoppingMallService;
import com.cy.domain.PagingDto;

public class ShopPagingServiceAjax implements IShoppingMallService {
	
	@SuppressWarnings("unchecked")
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//카테고리
		String category_code = request.getParameter("category_code");
		
		//페이징
		int nowPage = 1;
		String strPage = request.getParameter("page");
								
		if(strPage!=null && !strPage.equals("")) {
			nowPage = Integer.parseInt(strPage);
		}
		PagingDto pagingDto = new PagingDto(nowPage, category_code);
		
		System.out.println("ajax paging dto: " + pagingDto);
		
		JSONObject jObj = new JSONObject();
		jObj.put("startPage", pagingDto.getStartPage());
		jObj.put("endPage", pagingDto.getEndPage());
		jObj.put("nowPage", pagingDto.getNowPage());
		jObj.put("totalPage", pagingDto.getTotalPage());
		jObj.put("totalCountByCategory", pagingDto.getTotalCountByCategory());
		
		String data = jObj.toJSONString();
		request.setAttribute("data", data);
		
		return "WEB-INF/views/data.jsp";
	}

}
