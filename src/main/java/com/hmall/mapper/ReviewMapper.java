package com.hmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.ReviewVO;
import com.hmall.dto.Criteria;

public interface ReviewMapper {

	public List<ReviewVO> getReviewListWithPaging(@Param("cri") Criteria cri, @Param("pdt_num") long pdt_num) throws Exception;
	
	public int getCountByProduct_pdt_num(long pdt_num);
	
	public void review_register(ReviewVO vo) throws Exception;
	
	public void review_modify(ReviewVO vo) throws Exception;
	
	public void review_delete(int rv_num) throws Exception;

}
