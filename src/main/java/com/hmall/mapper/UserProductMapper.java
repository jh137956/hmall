package com.hmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.CategoryVO;
import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;

public interface UserProductMapper {

	// 1차 카테고리 출력
	public List<CategoryVO> getCategoryList() throws Exception;
	
	// 2차 카테고리 출력
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception;
	
	// 2차 카테고리에 해당하는 상품 목록
	public List<ProductVO> getProductListBysubCate(@Param("cri") Criteria cri, @Param("cg_code") String cg_code) throws Exception;
	
	public int getTotalCountProductBysubCate(String cg_code) throws Exception;
	
	// 상품 상세설명
	public ProductVO getProductByNum(Long pdt_num) throws Exception;
}
