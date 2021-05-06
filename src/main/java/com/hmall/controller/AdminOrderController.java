package com.hmall.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hmall.domain.OrderDetailListVO;
import com.hmall.domain.OrderDetailVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.PageDTO;
import com.hmall.service.CartService;
import com.hmall.service.OrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order/*")
public class AdminOrderController {

	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	
//	@RequestMapping(value = {"/order_list", "/order_detail_list"}, method = {RequestMethod.GET, RequestMethod.POST})
	@RequestMapping(value = "/order_list", method = {RequestMethod.GET, RequestMethod.POST})
	public void order_list(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		log.info("order_list: " + cri);
		
		model.addAttribute("order_list", orderService.orderInfo_list(cri));
		
		int total = orderService.getTotalCountOrder(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// ajax에서 넘어온 주문번호 파라미터를 가지고 주문상세테이블 쿼리를 구성
	// 2차 카테고리 정보
	@ResponseBody
	@GetMapping("/order_Detail_List")
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
	
	@ResponseBody
	@PostMapping("/order_check_delete")
	public ResponseEntity<String> order_check_delete(@RequestParam("checkArr[]") List<Integer> checkArr) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		try {
			orderService.order_check_delete(checkArr);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 매출통계
	@GetMapping("/order_sale")
	public void order_sale(Model model, @RequestParam(required = false) Integer year, @RequestParam(required = false) Integer month) throws Exception {
		
		log.info("order_sale");
		
		// 월별 시작일, 말일 구하기
		Calendar cal = Calendar.getInstance();
		log.info(cal);
		
		int cur_year;
		int cur_month;
		
		if(year != null && month != null) {
			cur_year = (int) year;
			cur_month = ((int) month) -1;
		}else {
			cur_year = cal.get(Calendar.YEAR);
			cur_month = cal.get(Calendar.MONTH);
		}
		
		model.addAttribute("sel_year", cur_year);
		model.addAttribute("sel_month", cur_month + 1);
		
		log.info("sel_year" + cur_year);
		log.info("sel_year" + cur_month+1);
		
		cal.set(cur_year, cur_month, 1);
		
		log.info("기준날짜" + cal);
		
		int start_day = cal.getActualMinimum(Calendar.DAY_OF_MONTH);
		int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		cal.set(cur_year, cur_month, start_day);
		
		String startDate = dateFormat.format(cal.getTime());
		cal.set(cur_year, cur_month, end_day);
		String endDate = dateFormat.format(cal.getTime());
		
		log.info("시작일" + startDate);
		log.info("말일" + endDate);
		
		model.addAttribute("order_salelist", orderService.order_sale(startDate, endDate));
		
	}
	
}
