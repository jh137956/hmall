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
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	private static final String LOGIN = "loginStatus";
	
	// Object handler : URL Mapping 주소에 해당하는 메서드 자체를 가리킴
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		return true;
	}

	// 컨트롤러의 맵핑주소(메서드 호출)(/member/loginPost) -> postHandle 메서드 -> 실행후 뷰(jsp)화면처리 작업이 진행됨
	// ModelAndView : (Model + View)
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		/*
		MemberVO vo = new MemberVO();	
		modelAndView.setViewName("member");
		modelAndView.addObject("memberVO", vo);
		*/
		
		// 로그인시 사용자 인증처리를 하기위한 세션객체 확보
		HttpSession session = request.getSession();
		
		// 로그인시 Model정보를 참조하는 작업
		ModelMap modelMap = modelAndView.getModelMap();
		Object memberVO = modelMap.get("memberVO");
		
		if(memberVO != null) {
			logger.info("로그인 성공");
			session.setAttribute(LOGIN, memberVO);
			
			Object targetUrl = session.getAttribute("targetUrl");
			
			response.sendRedirect(targetUrl != null ? (String) targetUrl : "/");
		}
		
		
		
	}
	
}
