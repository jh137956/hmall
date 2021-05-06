package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.CategoryVO;
import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;
import com.hmall.mapper.UserProductMapper;

import lombok.Setter;

@Service
public class UserProductServiceImpl implements UserProductService {

	@Setter(onMethod_ = @Autowired)
	private UserProductMapper userProductMapper;
	
	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> getCategoryList() throws Exception {
		
		return userProductMapper.getCategoryList();
	}

	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception {
		
		return userProductMapper.getSubCategoryList(cg_code);
	}

	// 2차 카테고리에 해당하는 상품 목록
	@Override
	public List<ProductVO> getProductListBysubCate(Criteria cri, String cg_code) throws Exception {
		
		return userProductMapper.getProductListBysubCate(cri, cg_code);
	}

	@Override
	public int getTotalCountProductBysubCate(String cg_code) throws Exception {

		return userProductMapper.getTotalCountProductBysubCate(cg_code);
	}

	// 상품 상세설명
	@Override
	public ProductVO getProductByNum(Long pdt_num) throws Exception {
		
		return userProductMapper.getProductByNum(pdt_num);
	}

}
