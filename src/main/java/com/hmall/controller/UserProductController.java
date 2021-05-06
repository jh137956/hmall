package com.hmall.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hmall.domain.CategoryVO;
import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;
import com.hmall.service.UserProductService;
import com.hmall.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/*")
public class UserProductController {

	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@GetMapping("/subCategoryList/{cg_code}")
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cg_code") String cg_code) throws Exception {
		
		log.info("subCategoryList: " + cg_code);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(userProductService.getSubCategoryList(cg_code), HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 2차 카테고리에 의한 상품목록
	@GetMapping("/product_list")
	public String productListBysubCate(@ModelAttribute("cri") Criteria cri, String cg_code, Model model)	throws Exception {
		
		log.info("productListBysubCate: " + cg_code);
		
		cri.setAmount(9);
		
		model.addAttribute("productVOList", userProductService.getProductListBysubCate(cri, cg_code));
		
		return "/product/product_list";
	}
	
	// 상품 이미지 뷰
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
	// 상품상세설명(상품조회)
	@GetMapping("/product_read")
	public void product_read(@RequestParam("pdt_num") long pdt_num, Model model) throws Exception {
		
		log.info("product_read: " + pdt_num);
		
		ProductVO vo = userProductService.getProductByNum(pdt_num);
		
		// 기본이미지 설정작업
		vo.setPdt_img(FileUploadUtils.thumbToOriginName(vo.getPdt_img()));
		
		model.addAttribute("productVO", vo);
	}
	
}
