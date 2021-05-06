package com.hmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hmall.domain.MemberVO;
import com.hmall.domain.ReviewVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.ReviewPageDTO;
import com.hmall.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review/*")
@AllArgsConstructor
public class ReviewController {

	private ReviewService reviewService; // @AllArgsConstructor : 모든 필드에 생성자메서드가 생성이되고 생성자는 어노테이션을 생략하고 자동주입이 이루어짐
	
	// 상품후기 목록(페이징기능 포함)
	@GetMapping(value = "/pages/{pdt_num}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReviewPageDTO> getReviewListPage(@PathVariable("pdt_num") long pdt_num, @PathVariable("page") int page) throws Exception {
		
		ResponseEntity<ReviewPageDTO> entity = null;
		
		Criteria cri = new Criteria(page, 5);
		
		log.info("상품번호: " + pdt_num);
		log.info("cri: " + cri);
		
		// 상품후기 개수(페이징)
		// 상품후기 목록
		
		try {
			entity = new ResponseEntity<ReviewPageDTO>(reviewService.getReviewListWithPaging(cri, pdt_num), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<ReviewPageDTO>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@PostMapping(value = "/review_register")
	@ResponseBody
	public ResponseEntity<String> review_register(ReviewVO vo, HttpSession session) throws Exception {
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		vo.setMb_id(mb_id);
		log.info("review_register: " + vo);
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewService.review_register(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 상품후기 수정하기
	@PostMapping(value = "/review_modify")
	@ResponseBody
	public ResponseEntity<String> review_modify(ReviewVO vo) throws Exception {
		
		log.info("review_register: " + vo);
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewService.review_modify(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 상품후기 삭제
	@PostMapping(value = "/review_delete")
	@ResponseBody
	public ResponseEntity<String> review_delete(int rv_num) throws Exception {
		
		log.info("review_register: " + rv_num);
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewService.review_delete(rv_num);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

}
