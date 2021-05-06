package com.hmall.service;

import com.hmall.domain.ReviewVO;
import com.hmall.dto.Criteria;
import com.hmall.dto.ReviewPageDTO;

public interface ReviewService {

	public ReviewPageDTO getReviewListWithPaging(Criteria cri, long pdt_num) throws Exception;
	
	public void review_register(ReviewVO vo) throws Exception;
	
	public void review_modify(ReviewVO vo) throws Exception;
	
	public void review_delete(int rv_num) throws Exception;
}
