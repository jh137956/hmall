package com.hmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	private static final String LOGIN = "loginStatus";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		// 인증체크작업
		if(session.getAttribute(LOGIN) == null) {
			
			logger.info("로그인을 해주세요");
			
			targetSave(request);
			
			response.sendRedirect("/member/login");
			return false; // controller로 제어가 넘어가지 않음
			
		}

		return true; // controller로 제어가 넘어감
	}

	// 사용자가 세션이 소멸된상태, 비로그인시 요청한 주소저장
	// 사용자가 로그인이 진행이되면 요청한 주소가 있으면 그곳으로 이동, 없으면 / 로 이동
	private void targetSave(HttpServletRequest request) {
		
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
