package com.hmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


// 인증처리 작업 : HttpSession 로그인 생성
public class AdminInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);
	private static final String LOGIN = "adLoginStatus";
	
	// Object handler : URL Mapping 주소에 해당하는 메서드 자체를 가리킴
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) == null) {
			logger.info("로그인 성공");
			
			logger.info("로그인이 안되어있습니다");
			
			targetSave(request);
			
			response.sendRedirect("/admin/");
			return false;
		}
		
		return true;
	}

	
	// 세션이 소멸된 상태이거나 비로그인시 요청한 주소를 저장
		// 사용자가 로그인이 진행이되면, 요청한 주소가 있으면 그곳으로 이동. 없으면 루트로 이동. 
	private void targetSave(HttpServletRequest request) {
		
		// /member/modify?userid=doccomsa
		String uri = request.getRequestURI();
		String queryString = request.getQueryString(); 
		
		if(queryString == null || queryString.equals("null")) {
			queryString = "";
		}else {
			queryString = "?" + queryString;
		}
		
		if(request.getMethod().equals("GET")) {
			logger.info("targetSave: " + (uri + queryString));
			request.getSession().setAttribute("targetUrl", uri + queryString);
		}
		
	}	
	
	
}
