package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.ProductVO;
import com.hmall.dto.Criteria;
import com.hmall.mapper.AdProductMapper;

import lombok.Setter;

@Service
public class MainPageServiceImpl implements MainPageService {
	
	@Setter(onMethod_ = @Autowired)
	private AdProductMapper pro_mapper;

	@Override
	public List<ProductVO> product_list(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return pro_mapper.product_list(cri);
	}

	@Override
	public int getTotalCountProduct(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return pro_mapper.getTotalCountProduct(cri);
	}

}
