package com.cy.admin.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.persistence.ProductDao;
import com.cy.util.FileUploader;

public class ProductDeleteProService implements IShoppingMallService {

	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String page = IConstants.STR_REDIRECT +  "main.cy";
		String msg = "";
		
		//관리자가 맞는지 확인
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || !user_id.equals("admin")){
			session.setAttribute("msg", "not_admin");
			return page;
		}
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		String product_img = productDao.getFileName(product_num);
		
		boolean result = productDao.deleteProduct(product_num);
		if(result){
			msg = "success";
			FileUploader.deleteFile(request, product_img);
		}else{
			msg = "fail";
		}
		request.setAttribute("data", msg);
		page = "WEB-INF/views/data.jsp";
		
		return page;
	}

}
