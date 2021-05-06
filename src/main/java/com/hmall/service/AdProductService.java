package com.hmall.service;

import java.util.List;

import com.hmall.domain.CategoryVO;
import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.TotalProductDTO;

public interface AdProductService {

	// 1차 카테고리 출력
	public List<CategoryVO> getCategoryList() throws Exception;
	
	// 2차 카테고리 출력
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception;
	
	// 상품등록
	public void product_insert(ProductVO vo) throws Exception;
	
	// 상품 리스트
	public List<ProductVO> product_list(Criteria cri) throws Exception;
	
	// 상품개수(페이징기능에 사용)
	public int getTotalCountProduct(Criteria cri) throws Exception;
	
	// 상품수정
	public ProductVO product_modify(Long pdt_num) throws Exception;
	
	// 상품 수정하기
	public void product_modifyOk(ProductVO vo) throws Exception;
	
	// 상품 삭제
	public void product_delete(long pdt_num) throws Exception;
	
	
}
