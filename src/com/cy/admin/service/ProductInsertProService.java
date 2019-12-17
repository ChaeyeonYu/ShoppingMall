package com.cy.admin.service;

import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;
import com.cy.domain.ProductVo;
import com.cy.persistence.ProductDao;
import com.cy.util.FileUploader;
import com.oreilly.servlet.MultipartRequest;
import com.sun.org.apache.bcel.internal.generic.ICONST;

public class ProductInsertProService implements IShoppingMallService {

	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//제품 추가 후 해당 카테고리의 제품 목록 리스트로 리다이렉트
		String page = IConstants.STR_REDIRECT +  "main.cy";
		
		//관리자가 맞는지 확인
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || !user_id.equals("admin")){
			session.setAttribute("msg", "not_admin");
			return page;
		}
		
		MultipartRequest multi = FileUploader.upload(request);
		String category_code = multi.getParameter("category_code");
		String product_name = multi.getParameter("product_name");
		int product_price = Integer.parseInt(multi.getParameter("product_price"));
		int product_stock = Integer.parseInt(multi.getParameter("product_stock"));
		String product_content = multi.getParameter("product_content");
		
		Enumeration<?> enumer = multi.getFileNames();
		String filename = (String)enumer.nextElement();
		String fileSystemName = multi.getFilesystemName(filename);
		String product_img = fileSystemName;
		
		ProductVo productVo = new ProductVo(0, product_name, category_code, null, product_content, product_price, 
											product_img, product_stock, null);
		
		boolean result = productDao.insertProduct(productVo);
		if(!result){
			String msg = "fail";
			System.out.println(msg);
		}
		page = IConstants.STR_REDIRECT +  "product.admin-cy?category_code=" + category_code;
		
		return page;
	}

}
