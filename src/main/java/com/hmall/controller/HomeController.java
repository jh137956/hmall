package com.hmall.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hmall.dto.Criteria;
import com.hmall.dto.PageDTO;
import com.hmall.service.AdProductService;
import com.hmall.service.UserProductService;
import com.hmall.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Setter(onMethod_ = @Autowired)
	private AdProductService service;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "main";
//	}
	
	// 상품 리스트
	@GetMapping("/")
	public String product_list(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		model.addAttribute("productVOList", service.product_list(cri));
		
		int totalCount = service.getTotalCountProduct(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		return "/main";
	}
		
//		// 상품 이미지 뷰
//		@ResponseBody
//		@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
//		public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
//			
//			return FileUploadUtils.getFile(uploadPath, fileName);
//		}
	
	
}
