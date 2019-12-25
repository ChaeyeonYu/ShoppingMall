package com.cy.admin.service;

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

public class ProductUpdateProService implements IShoppingMallService {

	private ProductDao productDao = ProductDao.getInstance();
	
	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String page = IConstants.STR_REDIRECT +  "main.cy";
		
		//관리자가 맞는지 확인
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null || !user_id.equals("admin")){
			session.setAttribute("msg", "not_admin");
			return page;
		}
		
		String isBinary = request.getParameter("isBinary");
		String category_code = "";
		int product_num = 0;
		ProductVo productVo = new ProductVo();
		
		if(isBinary!=null && isBinary.equals("N")){
			//변경할 파일이 없는 경우
			category_code = request.getParameter("category_code");
			product_num = Integer.parseInt(request.getParameter("product_num"));
			String product_name = request.getParameter("product_name");
			String product_content = request.getParameter("product_content");
			int product_stock = Integer.parseInt(request.getParameter("product_stock"));
			int product_price = Integer.parseInt(request.getParameter("product_price"));
			
			productVo.setProduct_num(product_num);
			productVo.setProduct_name(product_name);
			productVo.setProduct_content(product_content);
			productVo.setProduct_stock(product_stock);
			productVo.setProduct_price(product_price);
		}else{
			//변경할 파일이 없는 경우
			MultipartRequest multi = FileUploader.upload(request);
			String product_img = multi.getParameter("product_img");
			FileUploader.deleteFile(request, product_img);
			
			category_code = multi.getParameter("category_code");
			product_num = Integer.parseInt(multi.getParameter("product_num"));
			String product_name = multi.getParameter("product_name");
			String product_content = multi.getParameter("product_content");
			int product_stock = Integer.parseInt(multi.getParameter("product_stock"));
			int product_price = Integer.parseInt(multi.getParameter("product_price"));
			
			Enumeration<?> enumer = multi.getFileNames();
			String filename = (String)enumer.nextElement();
			String new_product_img = multi.getFilesystemName(filename);
			
			productVo.setProduct_num(product_num);
			productVo.setProduct_name(product_name);
			productVo.setProduct_content(product_content);
			productVo.setProduct_stock(product_stock);
			productVo.setProduct_price(product_price);
			productVo.setProduct_img(new_product_img);
		}
		
		productDao.updateProduct(productVo);
		page = IConstants.STR_REDIRECT +  "product.admin-cy?category_code=" + category_code;
		
		return page;
	}

}
