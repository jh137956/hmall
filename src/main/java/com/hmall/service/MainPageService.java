package com.hmall.service;

import java.util.List;

import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;

public interface MainPageService {

	// 상품 리스트
	public List<ProductVO> product_list(Criteria cri) throws Exception;
	
	// 상품개수(페이징기능에 사용)
	public int getTotalCountProduct(Criteria cri) throws Exception;
}
