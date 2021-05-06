package com.hmall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.OrderDetailListVO;
import com.hmall.domain.OrderDetailVO;
import com.hmall.domain.OrderVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.OrderSaleDTO;
import com.hmall.dto.TotalProductDTO;

public interface OrderService {
	
	// 장바구니 구매
	public void order_buy(OrderVO vo, String mb_id) throws Exception;
	
	// 바로 구매
	public void orderDirect_add(OrderVO vo, OrderDetailVO vo2) throws Exception;
	
	// 구매 내역
	public List<OrderVO> my_order_List(String mb_id) throws Exception;
	
	// 주문 리스트
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception;
	
	// 주문개수(페이징기능에 사용)
	public int getTotalCountOrder(Criteria cri) throws Exception;
	
	// 2차 카테고리 출력
	public List<OrderDetailListVO> order_Detail_List(long od_code) throws Exception;
	
	public void order_check_delete(List<Integer> checkArr) throws Exception;
	

	public List<OrderSaleDTO> order_sale(String startDate, String endDate) throws Exception;
}
