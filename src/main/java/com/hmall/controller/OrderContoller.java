package com.hmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hmall.domain.CartVOList;
import com.hmall.domain.MemberVO;
import com.hmall.domain.OrderDetailListVO;
import com.hmall.domain.OrderDetailVO;
import com.hmall.domain.OrderVO;
import com.hmall.domain.ProductVO;
import com.hmall.service.CartService;
import com.hmall.service.OrderService;
import com.hmall.service.UserProductService;
import com.hmall.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
public class OrderContoller {
	
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	@Resource(name="uploadPath")
	private String uploadPath;

	// @RequestParam(required = false) : get요청에 의한 해당 쿼리스트링이 존재하지않아도 처리하고자 할때 사용(예외발생 안됨)
	
	@RequestMapping(value = "/order", method = {RequestMethod.GET, RequestMethod.POST})
	public void order(HttpSession session, @ModelAttribute("type") String type, @RequestParam(required = false) Long pdt_num, @RequestParam(required = false) Integer od_amount, Model model) throws Exception {
		
		// type : 1) 장바구니 기반으로 주문  2) 즉시구매
		
		// 사용자별 장바구니 내역
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		
		
		
		if(type.equals("1")) {
			// 즉시구매
			ProductVO vo = userProductService.getProductByNum((long)pdt_num);
			// 즉시구매시 상품상세정보 화면 폼에 삽입하기위한 model작업
			model.addAttribute("pdt_num", pdt_num);
			model.addAttribute("od_amount", od_amount);
			model.addAttribute("od_price", vo.getPdt_price());
			model.addAttribute("pdt_discount", vo.getPdt_discount());
			
			CartVOList cartvo = new CartVOList(0, vo.getPdt_img(), vo.getPdt_name(), (int) od_amount, vo.getPdt_price(), vo.getPdt_discount());
			
			List<CartVOList> cartvoList = new ArrayList<CartVOList>();
			cartvoList.add(cartvo);
			
			model.addAttribute("cartVOList", cartvoList);
			
		}else if(type.equals("2")) {
			// 장바구니 기반으로 주문
			
			model.addAttribute("cartVOList", cartService.list_cart(mb_id));
			
			// 사용하지 않는 값이지만 에러발생때문에 형식만 유지
			model.addAttribute("pdt_num", 0);
			model.addAttribute("od_amount", 0);
			model.addAttribute("od_price", 0);
			model.addAttribute("pdt_discount", 0);
		}
		
		// 주문입력 폼 구성작업
	}
	
	// 상품 이미지 뷰
	@ResponseBody
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
	@PostMapping("/order_buy")
	public String order_buy(OrderVO vo, OrderDetailVO vo2, String type, HttpSession session) throws Exception {
		
		log.info(vo);
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		vo.setMb_id(mb_id);
		
		if(type.equals("1")) {
			log.info("order: " + vo);
			log.info("OrderDetail: " + vo2);
			
			// 장바구니 테이블 제외 (장바구니에 상품을 저장안함)
			orderService.orderDirect_add(vo, vo2); // 즉시구매한 상품 구성
		}else if(type.equals("2")) {
				
			orderService.order_buy(vo, mb_id);
			
		}
		return "redirect:/";
	}
	
	@GetMapping("/my_order_list")
	public void cart_list(HttpSession session, Model model) throws Exception {
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		model.addAttribute("myOrderVO", orderService.my_order_List(mb_id));
		
		log.info("cart_list");
	}
	
	@ResponseBody
	@GetMapping("/my_order_Detail_List")
	public ResponseEntity<List<OrderDetailListVO>> order_Detail_List(long od_code) throws Exception {
		
		ResponseEntity<List<OrderDetailListVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<OrderDetailListVO>>(orderService.order_Detail_List(od_code), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<OrderDetailListVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
	
	
	
	
	
	
	
}
