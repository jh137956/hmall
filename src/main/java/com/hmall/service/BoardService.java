package com.hmall.service;

import java.util.List;

import com.hmall.domain.BoardAttachVO;
import com.hmall.domain.BoardVO;
import com.hmall.dto.Criteria;

public interface BoardService {
	
	public List<BoardVO> getList() throws Exception;
	
	// 게시물 등록(첨부파일 포함)
	public void insertSelectKey(BoardVO board) throws Exception;
	
	public BoardVO read(Long bno) throws Exception;
	
	public int update(BoardVO board) throws Exception;
	
	public int delete(Long bno) throws Exception;
	
	public List<BoardVO> getListWithPaging(Criteria cri) throws Exception;
	
	// 책에없는 부분 추가
	public List<BoardVO> getListWithSearchPaging(Criteria cri) throws Exception;
	
	public int getTotalCount(Criteria cri) throws Exception;
	
	// 파일 첨부 기능 추가
	public List<BoardAttachVO> getAttachVOList(Long bno) throws Exception;
	
	
}
