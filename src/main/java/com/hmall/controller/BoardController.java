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

import com.hmall.domain.BoardAttachVO;
import com.hmall.domain.BoardVO;
import com.hmall.domain.MemberVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.PageDTO;
import com.hmall.service.BoardService;
import com.hmall.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor // 클래스의 모든필드를 대상으로 파라미터를 구성하여, 생성자메서드 생성
public class BoardController {

	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	/* 
	  스프링 4.3 이후 단일생성자의 묵시적 자동주입.(page 67참고)
	@AutoWired 생략됨. 
	public BoardController(BoardService service) {
		this.service = service;
	}
	*/
	@GetMapping("/index")
	public String boardIndex() {
		
		log.info("called boardIndex()");
		return "/index";
	}
	
	// 리스트. 주소? /board/list
	@GetMapping("/list")
//	@RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
	public void list(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		// 참조형 파라미터는 내부적으로 스프링에 의하여, 자동으로 기본생성자에 의하여 객체생성이된다.Criteria cri
		log.info("called list..." + cri);
//		model.addAttribute("list", service.getList());
		//1)게시물 데이타
//		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("list", service.getListWithSearchPaging(cri));
		
		int total = service.getTotalCount(cri);
		
		log.info("total: " + total);
		//2)페이징정보. [이전]1 2 3 4 5 6...[다음]
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		// View(JSP)에 전달되는 데이타는 1)게시물데이타 2)페이징정보
		// view에서 사용가능한 Model. 1)cri 2)list 3)pageMaker	
			
	}
	
	// 글쓰기 폼
	@GetMapping("/board_insert")
	public void register(Model model, HttpSession session) throws Exception {
		log.info("called register...");
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		
		model.addAttribute("vo", memberService.member_info(mb_id));
				
	}
	
	@PostMapping("/board_insert")
	public String register(BoardVO board, RedirectAttributes rttr, HttpSession session, Model model) throws Exception {
		
		log.info("called register..." + board);

		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		model.addAttribute("vo", memberService.member_info(mb_id));
		
		// 파일첨부정보 로그출력
		if(board.getAttachList() != null ) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.insertSelectKey(board);
		
		rttr.addAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("called get..." + bno);
		model.addAttribute("board", service.read(bno));
		// 게시물에 해당하는 댓글데이터를 참조
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) throws Exception {
		
		log.info("게시물 번호: " + bno);
		
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachVOList(bno), HttpStatus.OK);
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) throws Exception {
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
		
		return "redirect:/board/list"; // 주소이동
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) throws Exception {
				
		log.info("called modify..." + bno);
		service.delete(bno);
		
		rttr.addFlashAttribute("result", "remove");
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
}
