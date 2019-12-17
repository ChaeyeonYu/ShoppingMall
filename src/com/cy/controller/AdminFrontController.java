package com.cy.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;

@WebServlet("*.admin-cy")
public class AdminFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Map<String, IShoppingMallService> commandMap = new HashMap<>();
	
	public AdminFrontController() {
        super();
    }

	@Override
	public void init() throws ServletException {
		super.init();
		System.out.println("init();");
		loadProperties();
	}

	private void loadProperties() {
		ResourceBundle bundle = ResourceBundle.getBundle("com.cy.properties.AdminCommand");
		Enumeration<String> keys = bundle.getKeys();
		
		while (keys.hasMoreElements()) {
			String commandName = keys.nextElement();
			String className = bundle.getString(commandName);
			try {
				Class<?> commandClass = Class.forName(className);
				Object obj = commandClass.newInstance();
				commandMap.put(commandName, (IShoppingMallService)obj);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} //while
//		System.out.println("commandMap: " + commandMap);
	}

	//로그인 체크
	private boolean checkLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
			
		if(user_id!=null && user_id.equals("admin")) {
			return true; //로그인 한 상태
		}
		return false;	  //로그인을 하지 않은 상태
//		return true;	  //로그인을 하지 않은 상태
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//커맨드 요청 전 로그인 상태인지 확인
		boolean isLogin = checkLogin(request);
		if(isLogin == false) {
			//로그인을 하지 않은 상태일 경우 main.cy로 redirect
			HttpSession session = request.getSession();
			session.setAttribute("msg", "not_admin");
			
			System.out.println("관리자 로그인 안함.");
			response.sendRedirect("main.cy"); 
			return;
		}
		
		String command = getCommand(request);
		System.out.println("command: " + command);
		
		IShoppingMallService service = commandMap.get(command);
		try {
			String path = service.excute(request, response);
			
			//redirect
			if(path.startsWith(IConstants.STR_REDIRECT)){
				String redirectPage = path.substring(IConstants.STR_REDIRECT.length());
				response.sendRedirect(redirectPage);
				
			//forward
			}else{
				RequestDispatcher dispatcher = request.getRequestDispatcher(path);
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	public String getCommand(HttpServletRequest request){
		String uri = request.getRequestURI();
		String path = request.getContextPath();
//		System.out.println("uri: " + uri);
//		System.out.println("path: " + path);
		
		String command = uri.substring(path.length()+1);
		return command;
	}
	
}
