package com.hmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.ReviewVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.ReviewPageDTO;
import com.hmall.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = @Autowired)
	private ReviewMapper reviewMapper;
	
	@Override
	public ReviewPageDTO getReviewListWithPaging(Criteria cri, long pdt_num) throws Exception {
		
		return new ReviewPageDTO(reviewMapper.getCountByProduct_pdt_num(pdt_num), reviewMapper.getReviewListWithPaging(cri, pdt_num));
	}

	@Override
	public void review_register(ReviewVO vo) throws Exception {
		
		reviewMapper.review_register(vo);
	}

	@Override
	public void review_modify(ReviewVO vo) throws Exception {
		
		reviewMapper.review_modify(vo);
	}

	@Override
	public void review_delete(int rv_num) throws Exception {
		
		reviewMapper.review_delete(rv_num);
	}

}
