package com.hmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hmall.domain.AdminVO;
import com.hmall.domain.BoardAttachVO;
import com.hmall.domain.BoardVO;
import com.hmall.domain.MemberVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.PageDTO;
import com.hmall.service.AdminService;
import com.hmall.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/board")
public class AdBoardController {

	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private AdminService adminService;
	
	@GetMapping("/adlist")
	public void adboard(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		model.addAttribute("list", service.getListWithSearchPaging(cri));
		
		int total = service.getTotalCount(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 글쓰기 폼
	@GetMapping("/adinsert")
	public void register(Model model, HttpSession session) throws Exception {
		log.info("called register...");
		
		String admin_id = ((AdminVO) session.getAttribute("adLoginStatus")).getAdmin_id();
		
		model.addAttribute("vo", adminService.admin_info(admin_id));
				
	}
	
	@PostMapping("/adinsert")
	public String register(BoardVO board, RedirectAttributes rttr, HttpSession session, Model model) throws Exception {
		
		log.info("called register..." + board);

		String admin_id = ((AdminVO) session.getAttribute("adLoginStatus")).getAdmin_id();
		model.addAttribute("vo", adminService.admin_info(admin_id));
		
		// 파일첨부정보 로그출력
		if(board.getAttachList() != null ) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.insertSelectKey(board);
		
		rttr.addAttribute("result", board.getBno());
		
		return "redirect:/admin/board/adlist";
	}
	
	@GetMapping({"/adget", "/admodify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("called get..." + bno);
		model.addAttribute("board", service.read(bno));
		// 게시물에 해당하는 댓글데이터를 참조
	}
	
	@GetMapping(value = "/adgetAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) throws Exception {
		
		log.info("게시물 번호: " + bno);
		
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachVOList(bno), HttpStatus.OK);
	}
	
	@PostMapping("/admodify")
	public String admodify(BoardVO board, Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("called modify..." + board);
		service.update(board);
		
		
		// 1)rttr.addFlashAttribute("msg", 값) : 
		// 설명> /board/list 주소에서 사용하는 View(JSP)에 데이터 전달. 
		// 내부적으로 세션으로 저장했다가 뷰에서 사용하고 즉시 소멸되는 정보.(일회성).
		
		rttr.addFlashAttribute("result", "modify"); // list.jsp에서 참조
		
		// 2)rttr.addAttribute("msg", 값)
		// 설명> /board/list 주소에 파라미터형태로 전달.
		
		// /board/list 주소의 메서드에서 참조.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/admin/board/adlist"; // 주소이동
	}
	
	@PostMapping("/adremove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) throws Exception {
				
		log.info("called modify..." + bno);
		service.delete(bno);
		
		rttr.addFlashAttribute("result", "remove");
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/admin/board/adlist";
	}
}
