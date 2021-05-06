package com.hmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.CartVO;
import com.hmall.domain.CartVOList;
import com.hmall.dto.TotalProductDTO;

public interface CartMapper {

	// 장바구니
	public void add_cart(CartVO vo) throws Exception;
	
	// 장바구니 리스트
	public List<CartVOList> list_cart(String mb_id) throws Exception;
	
	// 수량변경
	public void cart_count_update(@Param("cart_code") long cart_code, @Param("cart_count_buy") int cart_count_buy) throws Exception;
	
	// 장바구니 삭제
	public void cart_delete(long cart_code) throws Exception;
	
	// 장바구니 전체 삭제
	public void cart_Alldelete(String mb_id) throws Exception;
	
	// 장바구니 선택 삭제
	public void cart_check_delete(List<Integer> checkArr) throws Exception;
	
	// 월 상품별 판매금액
	public List<TotalProductDTO> total_product() throws Exception;
	
	
	

	
	
}
