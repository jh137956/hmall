package com.hmall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hmall.domain.MemberVO;
import com.hmall.dto.EmailDTO;
import com.hmall.dto.LoginDTO;
import com.hmall.service.EmailService;
import com.hmall.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private EmailService mailService;
	
	@Inject
	private BCryptPasswordEncoder cryPassEnc;
	
	@GetMapping("/login")
	public void login() {
	
		log.info("로그인 페이지 진입");
	}
	
	// 로그인 인증 작업
	@PostMapping(value = "/loginPost")
	public void login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session, Model model) throws Exception{
		
		MemberVO vo = service.login_ok(dto);
		
		if(vo == null) return;
		
		String result = "login_id_fail"; //1 : 성공, 2 : 아이디틀림, 3 : 비번틀림
		
		if(vo != null) {

			if(cryPassEnc.matches(dto.getMb_pw(), vo.getMb_pw())) {
				//vo.setMb_pw(""); 보안
//				session.setAttribute("loginStatus", vo); // session정보로 인증상태를 저장
				
				// 인터셉터에서 참조할 모델작업
				model.addAttribute("memberVO", vo);
				
				result = "login_success";
			}else if(dto.getMb_id().equals(vo.getMb_id())) {
				result = "login_password_fail";
				return;
			}
		}
	
		rttr.addFlashAttribute("status", result);
		
//		return "redirect:/";
	}
	
	// 로그아웃 기능
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		log.info("logout");
		
		session.invalidate();
		
		String result = "logout";
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	
	// 회원가입 폼
	@GetMapping("/join")
	public void join() {
	
		log.info("회원가입 페이지 진입");
	}
	
	// 회원가입 작업
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception {
		
		vo.setMb_pw(cryPassEnc.encode(vo.getMb_pw()));
		
		String result ="";
		
		service.memberJoin(vo);
		
		result = "joinMember";
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "checkIdDuplicate", method=RequestMethod.POST)
	public ResponseEntity<String> checkIdDuplicate(@RequestParam("mb_id") String mb_id) throws Exception {
		
		log.info("=====checkIdDuplicate execute()...");
		ResponseEntity<String> entity = null;
		try {
			int count = service.checkIdDuplicate(mb_id);
			// count 가 0이면 아이디 사용가능, 1d 이면 사용 불가능.

			if(count != 0) {
				// 아이디가 존재해서 사용이 불가능.
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			} else {
				// 사용가능한 아이디
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST); // 요청이 문제가 있다.
		}
		
		return entity;
	}
	
	
	@GetMapping("/mypage")
	public void memberPage(HttpSession session, Model model) throws Exception{
		
		log.info("회원 페이지 진입");
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		
		model.addAttribute("vo", service.member_info(mb_id));
	}
	
	// 회원 수정폼 : db에서 회원정보를 가져와서 출력
	@GetMapping("/modify")
	public void modifyMember(HttpSession session, Model model) throws Exception {
	
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		
		/*
		MemberVO vo = service.member_info(mb_id);	
		model.addAttribute("vo", vo);
		*/
		
//		model.addAttribute(service.member_info(mb_id)); // jsp에 전달되는 데이터의 키: memberVO 키생략가능
		model.addAttribute("vo", service.member_info(mb_id)); // 키 생략하지 않은 스타일
	}
	
	// 회원 수정
	@PostMapping("/modify")
	public String modifyPost(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		String result = "";
		
//		if(service.modifyPost(vo) == true) {
//			result = "modifysuccess";
//		}else {
//			result = "modifyfail";
//		}
		// 로그인시 세션참고 기능
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		vo.setMb_id(mb_id);
		vo.setMb_pw(cryPassEnc.encode(vo.getMb_pw()));
		
		service.modifyPost(vo); //위에 처리를 하지 않을경우 한줄로 가능하다
		result = "modifysuccess";
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 회원 삭제
	@GetMapping("/delete")
	public String delete_member(HttpSession session, RedirectAttributes rttr) throws Exception {
		log.info("회원탈퇴 페이지 진입");
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		
		service.delete_member(mb_id);
		session.invalidate();
		
		String result = "deleteMember";
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	
	// 아이디 찾기 폼
	@GetMapping("/find_id")
	public void find_id() {
	
		log.info("아이디찾기 페이지 진입");
		
	}
	
	// 아이디 찾기(ajax적용)
	@ResponseBody
	@PostMapping("/find_id")
	public ResponseEntity<String> find_id(@RequestParam("mb_name") String mb_name, @RequestParam("mb_email") String mb_email) throws Exception {
		
		log.info("이름" + mb_name);
		log.info("이메일" + mb_email);
		
		ResponseEntity<String> entity = null;
		
		String mb_id = service.find_id(mb_name, mb_email);
		
		if(mb_id != null) {
			entity = new ResponseEntity<String>(mb_id, HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}
		
		return entity;
		
	}
	
	
	// 비밀번호 찾기 폼
	@GetMapping("/find_password")
	public void find_password() {
	
		log.info("비밀번호찾기 페이지 진입");
		
	}
	
	// 비밀번호 찾기 기능(ajax적용)
	@ResponseBody
	@PostMapping("/find_password")
	public ResponseEntity<String> find_password(@RequestParam("mb_id") String mb_id, @RequestParam("mb_name") String mb_name, EmailDTO dto) throws Exception {
		
		log.info("아이디" + mb_id);
		log.info("이름" + mb_name);
		
		ResponseEntity<String> entity = null;
		
		MemberVO vo = service.find_password(mb_id, mb_name);
			
		if(vo != null) {
			
			String pw = "";
			for(int i=0; i<6; i++) {
				pw += String.valueOf((int)(Math.random()*10));
			}
					
			vo.setMb_pw(pw);
			vo.setMb_pw(cryPassEnc.encode(vo.getMb_pw()));
			service.updatePw(vo);
			
			// 메일전송작업
			dto.setReceiveMail(vo.getMb_email());
			dto.setSubject("요청하신 비밀번호는 : ");
			dto.setMessage(mb_id + " 님의 비밀번호 입니다");
			
			mailService.sendMail(dto, pw);
			
			
			

			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}
		
		return entity;
		
	}	
	
	// 이메일 인증코드 작업
//	@ResponseBody
//	@RequestMapping(value = "checkAuthcode", method=RequestMethod.POST)
//	public ResponseEntity<String> checkAuthcode(@RequestParam("mb_authcode") String mb_authcode, HttpSession session){
//		
//		ResponseEntity<String> entity = null;
//		
//		try {
//			if(mb_authcode.equals(session.getAttribute("authcode"))) {
//				// 인증코드 일치
//				entity= new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
//				
//				session.removeAttribute("authcode");
//				
//			} else {
//				// 인증코드 불일치
//				entity= new ResponseEntity<String>("FAIL", HttpStatus.OK);
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			entity= new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
//		}
//		
//		return entity;
//	}
	
}
