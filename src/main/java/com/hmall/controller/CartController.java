package com.hmall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hmall.domain.CartVO;
import com.hmall.domain.MemberVO;
import com.hmall.service.CartService;
import com.hmall.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart/*")
public class CartController {

	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@PostMapping("/add")
	public ResponseEntity<String> cart_add(long pdt_num, int pdt_count_buy, HttpSession session, HttpServletResponse response) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		// 인증체크작업
		if(session.getAttribute("loginStatus") == null) {
						
			entity = new ResponseEntity<String>("LoginRequired", HttpStatus.OK);
			return entity;
		}
		
		//loginStatus
		MemberVO vo = (MemberVO) session.getAttribute("loginStatus");
		
		CartVO cart = new CartVO(0, pdt_num, vo.getMb_id(), pdt_count_buy);
		
		log.info("cart_add" + cart);
		
		try {
			cartService.add_cart(cart);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;	
	}
	
	@GetMapping("/cart_list")
	public void cart_list(HttpSession session, Model model) throws Exception {
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		model.addAttribute("cartVOList", cartService.list_cart(mb_id));
		
		log.info("cart_list");
	}
	
	// 상품 이미지 뷰
	@ResponseBody
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
	// 장바구니 개별 삭제
	@ResponseBody
	@PostMapping("/cart_delete")
	public ResponseEntity<String> cart_delete(long cart_code) throws Exception {
		
		cartService.cart_delete(cart_code);
		
		ResponseEntity<String> entity = null;
		
		try {			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e ) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	// 장바구니 수량 수정
	@ResponseBody
	@PostMapping("/cart_count_update")
	public ResponseEntity<String> cart_count_update(long cart_code, int cart_count_buy) throws Exception {
				
		ResponseEntity<String> entity = null;
		
		try {
			cartService.cart_count_update(cart_code, cart_count_buy);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e ) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}
	
	// 장바구니 비우기
	@GetMapping("/cart_all_delete")
	public String cart_all_delete(HttpSession session) throws Exception {
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		cartService.cart_Alldelete(mb_id);
		
		return "redirect:/cart/cart_list";
	}
	
	//선택 장바구니 비우기
	@ResponseBody
	@PostMapping("/cart_check_delete")
	public ResponseEntity<String> cart_check_delete(@RequestParam("checkArr[]") List<Integer> checkArr) throws Exception {
		
		log.info("cart_check_delete: " + checkArr);
		
		ResponseEntity<String> entity = null;
		
		try {
			cartService.cart_check_delete(checkArr);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception ex ) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}
	
//	@GetMapping("/chart_sample")
//	public void chart_sample(Model model) throws Exception {
//		
//		List<CartDTO> items = cartService.cart_money();
//				
////			Random random = new Random();
////			
////			for(int i=1; i<=5; i++) {
////				CartDTO cart = new CartDTO();
////				int price = random.nextInt(10000 - 1000 + 1) + 1000;
////				cart.setCount_buy(price);
////				cart.setPdt_name("전자제품" + i);
////				
////				items.add(cart);
////			}
////			
//			/*
//			 * pie chart sample data
//			 [
//	          ['상품명', '가격'],
//	          ['전자제품1', 15000],
//	          ['전자제품2', 20000],
//	          ['전자제품3', 30000],
//	          ['전자제품4', 8500],
//	          ['전자제품5', 13000]
//	        ]  
//			 */
//			int num = 0;
//			String str = "[";
//			str += "['상품명', '가격'],";
//			for(CartDTO dto : items) {
//				str += "['";
//				str += dto.getPdt_name();
//				str += "',";
//				str += dto.getCount_buy();
//				str += "]";
//				
//				num++;
//				if(num<items.size()) str += ",";
//			}
//			str += "]";
//			
//			log.info(str);
//			
//			model.addAttribute("chartData", str);
//	}
//	
	
}
