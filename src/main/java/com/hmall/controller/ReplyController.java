package com.hmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hmall.domain.ReplyVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.ReplyPageDTO;
import com.hmall.service.AdminService;
import com.hmall.service.MemberService;
import com.hmall.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController // view(jsp)를 사용 안한다.
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	
	// consumes = "application/json" : 클라이언트에서 application/json 헤더정보 요청일경우만 작업이 진행이 됨.
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo, Model model, HttpSession session) throws Exception {
		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		model.addAttribute("vo", service.register(vo));
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value = "/pages/{bno}/{page}", 
						produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getListPage(@PathVariable("bno") Long bno, @PathVariable("page") int page) throws Exception{
		
		Criteria cri = new Criteria(page, 5);
		
		log.info("게시물 번호: " + bno);
		log.info("cri: " + cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	// 댓글 수정하기 : rest방식에서 수정작업의 요청방식은 put, patch
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{rno}", 
					consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) throws Exception {
		
		vo.setRno(rno);
		
		
		
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		
		ResponseEntity<String> entity = null;
		
		if(service.modify(vo) == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("success", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
		/*
		// 성공 : success  실패 : 500번 에러
		return service.modify(vo) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)  // 성공
									   : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR); // 오류
	    */
	}
	
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) throws Exception {
		
		log.info("댓글번호: " + rno);
		
		return service.delete(rno) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	
	}
	
	
}
