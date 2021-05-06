package com.hmall.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.hmall.service.CartService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/chart/*")
public class ChartController {

	private CartService cartService;
	
	/*
	@ResponseBody
	@GetMapping("/chart_example")
	public ResponseEntity<String[][]> getChartDate() {
		
		ResponseEntity<String[][]> entity = null;
		
		String[][] charData = null;
		
		try {
			// 장바구니 더미데이터 준비해서 실행
			//List<CartDTO> items = cartService.cart_money();
			List<CartDTO> items = new ArrayList<CartDTO>();
			
			Random random = new Random();
			
			for(int i=0; i<5; i++) {
				CartDTO cart = new CartDTO();
				int price = random.nextInt(10000 - 1000 + 1) + 1000;
				cart.setCount_buy(price);
				cart.setPdt_name("전자제품" + i);
				
				items.add(cart);
			}
			
			JSONArray row = new JSONArray();
			
			// 제목작업
			JSONObject name = new JSONObject();
			name.put("상품", "가격");
			row.add(name);
			
			// 데이터 작업
			for(CartDTO dto : items) {
				JSONObject cell = new JSONObject();
				cell.put(dto.getPdt_name(), dto.getCount_buy());
				
				row.add(cell);
			}
			
			for(int i=0; i<row.size(); i++) {
				
			}
			
			
			entity = new ResponseEntity<String[][]>(charData, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String[][]>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	*/
	
	// 차트에 필요한 데이터를 2차원 배열형태로 작업하여 string 변수에 저장
//	@GetMapping("/chart_example")
//	public ResponseEntity<String> getChartDate2() {
//		
//		ResponseEntity<String> entity = null;
//		
//		List<CartDTO> items = new ArrayList<CartDTO>();
//		
//		Random random = new Random();
//		
//		for(int i=1; i<=5; i++) {
//			CartDTO cart = new CartDTO();
//			int price = random.nextInt(10000 - 1000 + 1) + 1000;
//			cart.setCount_buy(price);
//			cart.setPdt_name("전자제품" + i);
//			
//			items.add(cart);
//		}
//
//		String str = "[";
//		str += "['상품명', '가격']";
//		for(CartDTO dto : items) {
//			str += "['";
//			str += dto.getPdt_name();
//			str += "',";
//			str += dto.getCount_buy();
//			str += "]";
//		}
//		str += "]";
//		
//		log.info(str);
//		
//		entity = new ResponseEntity<String>(str, HttpStatus.OK);
//		
//		return entity;
//	}
	

	
	@GetMapping("/chartTotalData")
	public ResponseEntity<JSONObject> total_product() throws Exception{
		
		ResponseEntity<JSONObject> entity = null;
		
		try{
			 entity = new ResponseEntity<JSONObject>(cartService.total_product(), HttpStatus.OK);
		}catch (Exception e) {
			System.out.println(" 에러            -- ");
			entity =new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	@GetMapping("/chart_product_total") // /chart/chart (뷰)
	public ModelAndView chart() {
		
		/*
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsp파일명"); // 뷰
		mv.addObject("memberVO", "db에서 불러온 데이타"); // 모델작업
		
		return mv;
		*/
		return new ModelAndView("/chart/chart_product_total");
	}
	
	
}
