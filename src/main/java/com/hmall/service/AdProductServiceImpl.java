package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.CategoryVO;
import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.TotalProductDTO;
import com.hmall.mapper.AdProductMapper;

import lombok.Setter;

@Service
public class AdProductServiceImpl implements AdProductService {

	@Setter(onMethod_ = @Autowired)
	private AdProductMapper pro_mapper;

	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> getCategoryList() throws Exception {
		
		return pro_mapper.getCategoryList();
	}

	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception {
		
		return pro_mapper.getSubCategoryList(cg_code);
	}

	// 상품등록
	@Override
	public void product_insert(ProductVO vo) throws Exception {
		
		pro_mapper.product_insert(vo);
	}

	// 상품 리스트
	@Override
	public List<ProductVO> product_list(Criteria cri) throws Exception {
		
		return pro_mapper.product_list(cri);
	}

	// 상품개수(페이징기능에 사용)
	@Override
	public int getTotalCountProduct(Criteria cri) throws Exception {
		
		return pro_mapper.getTotalCountProduct(cri);
	}

	// 상품수정
	@Override
	public ProductVO product_modify(Long pdt_num) throws Exception {
		
		return pro_mapper.product_modify(pdt_num);
	}

	// 상품수정하기
	@Override
	public void product_modifyOk(ProductVO vo) throws Exception {
		
		pro_mapper.product_modifyOk(vo);
	}

	// 상품 삭제
	@Override
	public void product_delete(long pdt_num) throws Exception {
		
		pro_mapper.product_delete(pdt_num);
	}

	


}
