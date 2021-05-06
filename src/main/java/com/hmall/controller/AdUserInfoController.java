package com.hmall.controller;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hmall.domain.MemberVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.PageDTO;
import com.hmall.service.AdminService;
import com.hmall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/member/*")
public class AdUserInfoController {


	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private AdminService adservice;
	
	@Inject
	private BCryptPasswordEncoder cryPassEnc;
	
	
	@GetMapping("/userInfo_list")
	public void userInfo_list(Model model, @ModelAttribute("cri") Criteria cri) throws Exception {
		
		
		model.addAttribute("user_List", adservice.userInfo_list(cri));
		
		int totalCount = adservice.getUsertotalCount(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
	}
	
	@GetMapping("/userInfo_modify")
	public String userInfo_modify(@RequestParam("mb_id") String mb_id, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		MemberVO vo = service.member_info(mb_id);
		
		
		model.addAttribute("vo", vo);
		log.info("userInfo_modify");
		
		return "/admin/member/userInfo_modify";
	}
	
	@PostMapping("/userInfo_modify")
	public String userInfo_modify(MemberVO vo, Criteria cri, RedirectAttributes rttr) throws Exception {
		
		vo.setMb_pw(cryPassEnc.encode(vo.getMb_pw()));
		
		service.modifyPost(vo);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/member/userInfo_list";
	}
	
	@GetMapping("/user_delete")
	public String user_delete(String mb_id, Criteria cri, RedirectAttributes rttr) throws Exception {
		
		service.delete_member(mb_id);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/member/userInfo_list";
	}
	
}
