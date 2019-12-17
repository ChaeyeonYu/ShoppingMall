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

import com.cy.common.IConstants;
import com.cy.common.IShoppingMallService;

@WebServlet("*.cy")
public class ShoppingMallFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Map<String, IShoppingMallService> commandMap = new HashMap<>();
	
	public ShoppingMallFrontController() {
        super();
    }

	@Override
	public void init() throws ServletException {
		super.init();
		System.out.println("init();");
		loadProperties();
	}

	private void loadProperties() {
		ResourceBundle bundle = ResourceBundle.getBundle("com.cy.properties.PublicCommand");
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
