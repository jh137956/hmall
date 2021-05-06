package com.hmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.CategoryVO;
import com.hmall.domain.OrderDetailListVO;
import com.hmall.domain.OrderDetailVO;
import com.hmall.domain.OrderVO;
import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.OrderSaleDTO;
import com.hmall.dto.TotalProductDTO;

public interface OrderMapper {

	// 기본 주문 정보
	public void order_add(OrderVO vo) throws Exception;
	
	// 주문 상세 정보(주문내역)
	public void orderDetail_add(@Param("mb_id") String mb_id, @Param("od_code") long od_code) throws Exception;
	
	// 바로구매
	public void orderDirect_add(OrderDetailVO vo) throws Exception;
	
	// 구매 내역
	public List<OrderVO> my_order_List(String mb_id) throws Exception;
	
	// 주문 리스트
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception;
	
	// 주문개수(페이징기능에 사용)
	public int getTotalCountOrder(Criteria cri) throws Exception;
	
	// 2차 카테고리 출력
	public List<OrderDetailListVO> order_Detail_List(long od_code) throws Exception;
	
	// 주문 선택삭제
	public void order_check_delete(List<Integer> checkArr) throws Exception;
	
	// 
	public List<OrderSaleDTO> order_sale(@Param("startDate") String startDate,@Param("endDate") String endDate) throws Exception;
}
