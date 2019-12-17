package com.cy.util;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileUploader {
	
	private static final String SAVE_DIR = "upload";
	private static final int MAX_SIZE = 1024 * 1024 * 10; //10MB
	
	//file upload
	public static MultipartRequest upload(HttpServletRequest request){
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");
		String saveDir = realPath + SAVE_DIR;
		
		File f = new File(saveDir);
		if(!f.exists()){
			f.mkdir();
		}
		System.out.println("path:" + realPath);
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request, saveDir, MAX_SIZE, "UTF-8", new DefaultFileRenamePolicy());
			return multi;
		} catch (Exception e) {
			e.printStackTrace();
		} return null;
	}
	
	//delete file
	public static void deleteFile(HttpServletRequest request, String product_img){
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");
		String savedDir = realPath + SAVE_DIR + File.separator + product_img;
		
		File f = new File(savedDir);
		if(f.exists()){
			f.delete();
		}
	}
}
