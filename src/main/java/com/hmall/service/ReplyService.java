package com.hmall.service;

import java.util.List;

import com.hmall.dto.Criteria;
import com.hmall.dto.ReplyPageDTO;
import com.hmall.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo) throws Exception;
	
	public List<ReplyVO> getList(Criteria cri, Long bno) throws Exception;
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno) throws Exception;
	
	public int modify(ReplyVO reply) throws Exception;
	
	public int delete(Long rno) throws Exception;
}
