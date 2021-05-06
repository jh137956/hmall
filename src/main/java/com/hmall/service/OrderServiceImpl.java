package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hmall.domain.CartVOList;
import com.hmall.domain.OrderDetailListVO;
import com.hmall.domain.OrderDetailVO;
import com.hmall.domain.OrderVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.OrderSaleDTO;
import com.hmall.dto.TotalProductDTO;
import com.hmall.mapper.CartMapper;
import com.hmall.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = @Autowired)
	private OrderMapper orderMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CartMapper cartMapper;
	
	@Transactional
	@Override
	public void order_buy(OrderVO vo, String mb_id) throws Exception {
		
		orderMapper.order_add(vo);
		orderMapper.orderDetail_add(mb_id, vo.getOd_code());
		cartMapper.cart_Alldelete(mb_id);
	}
	

	@Transactional
	@Override
	public void orderDirect_add(OrderVO vo, OrderDetailVO vo2) throws Exception {
		
		orderMapper.order_add(vo);
		vo2.setOd_code(vo.getOd_code());
		orderMapper.orderDirect_add(vo2);
	}

	// 구매 내역
	@Override
	public List<OrderVO> my_order_List(String mb_id) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.my_order_List(mb_id);
	}
	
	// 주문 리스트
	@Override
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception {
		
		return orderMapper.orderInfo_list(cri);
	}

	// 주문개수(페이징기능에 사용)
	@Override
	public int getTotalCountOrder(Criteria cri) throws Exception {
		
		return orderMapper.getTotalCountOrder(cri);
	}

	// 주문 상세
	@Override
	public List<OrderDetailListVO> order_Detail_List(long od_code) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_Detail_List(od_code);
	}

	// 선택 주문 삭제
	@Override
	public void order_check_delete(List<Integer> checkArr) throws Exception {
		
		orderMapper.order_check_delete(checkArr);
	}


	@Override
	public List<OrderSaleDTO> order_sale(String startDate, String endDate) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_sale(startDate, endDate);
	}



	

	

}
