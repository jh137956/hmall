package com.hmall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hmall.domain.AdminVO;
import com.hmall.domain.MemberVO;
import com.hmall.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService adminService;
	
	@Inject
	private BCryptPasswordEncoder cryPassEnc;

	@GetMapping("")
	public String admin_main() {
		
		return "/admin/admin_login";
	}
	
	// 로그인 페이지
	@GetMapping("/admin_login")
	public void admin_login() {
		
		log.info("admin_login");
	}
	
	// 로그인 인증
	@PostMapping(value = "/adminPost")
	public String login(AdminVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		AdminVO adVO = null;
		
		adVO = adminService.login(vo); //1 : 성공, 2 : 아이디틀림, 3 : 비번틀림	
		
		if(adVO == null) {
			
			rttr.addFlashAttribute("msg", "login id fail");
			return "redirect:/admin/";
		}
		rttr.addFlashAttribute("msg", "login success");
		session.setAttribute("adLoginStatus", adVO);
		
//		if(adVO == null) return "redirect:/admin/admin_login";
//		
//		if(adVO != null) {
//			if(cryPassEnc.matches(vo.getAdmin_pw(), adVO.getAdmin_pw())) {
//				session.setAttribute("adLoginStatus", adVO);	
//				rttr.addFlashAttribute("msg", "login success");
//			}else {
//				//vo.setMb_pw(""); 보안		
//				rttr.addFlashAttribute("msg", "login id fail");
//				return "redirect:/admin/admin_login";
//			}
//			
//		}
		
		
		
		return "/admin/admin";
	}
	
	@GetMapping("/admin")
	public String admin_process(HttpSession session) {
		
		log.info("admin_process");
		
		String url = "";
		
		if(session.getAttribute("adLoginStatus") == null) {
			url = "redirect:/admin/admin_login"; // 관리자로그인 주소
		}else {
			url = "/admin/admin"; // 관리자 메뉴진입주소
		}
		
		return url; // redirect가 사용하면 주소의미, 사용하지않으면 jsp파일명
	
	}

	
	// 로그아웃 기능
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		log.info("logout");
		
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "logout");
		
		return "redirect:/admin/";
	}
	
	// 관리자 수정 페이지
	@GetMapping("/admin_modify")
	public void admin_modify(HttpSession session, Model model) throws Exception{
		
		String admin_id = ((AdminVO) session.getAttribute("adLoginStatus")).getAdmin_id();
		
		
		
		model.addAttribute("advo", adminService.admin_info(admin_id));
		
	}
	
	// 관리자 수정
	@PostMapping("/admin_modify")
	public String admin_modify(AdminVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
	
		String admin_id = ((AdminVO) session.getAttribute("adLoginStatus")).getAdmin_id();
		vo.setAdmin_id(admin_id);
		
		vo.setAdmin_pw(cryPassEnc.encode(vo.getAdmin_pw()));
		
		adminService.admin_modifyPost(vo);
		
		return "redirect:/admin/admin";
	}
	
}
