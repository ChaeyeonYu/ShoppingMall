package com.cy.common.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cy.common.IShoppingMallService;
import com.cy.domain.ProductVo;
import com.cy.persistence.ProductDao;

public class ShopServiceAjax implements IShoppingMallService {

	private ProductDao productDao = ProductDao.getInstance();
	
	@SuppressWarnings("unchecked")
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//제품 카테고리 클릭시 카테고리에 해당하는 제품들만 조회
		
		String category_code = request.getParameter("category_code");
		List<ProductVo> productList = productDao.getListByCategoryCode(category_code);
		
		JSONArray jArr = new JSONArray();
		for(ProductVo productVo : productList) {
			JSONObject jObj = new JSONObject();
			jObj.put("product_num", productVo.getProduct_num());
			jObj.put("product_name", productVo.getProduct_name());
			jObj.put("product_img", productVo.getProduct_img());
			jArr.add(jObj);
		}
		String data = jArr.toJSONString();
		request.setAttribute("data", data);
		
		return "WEB-INF/views/data.jsp";
	}

}
