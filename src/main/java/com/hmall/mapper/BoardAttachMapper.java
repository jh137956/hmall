package com.hmall.mapper;

import java.util.List;

import com.hmall.domain.BoardAttachVO;

public interface BoardAttachMapper {

	// 첨부파일 테이블 등록작업
	
	// 파일등록
	public void insert(BoardAttachVO vo);
	
	// 파일삭제
	public void delete(String uuid);
	
	// 파일 목록
	public List<BoardAttachVO> findByBno(Long bno);
	
	// 파일모두삭제
	public void deleteAll(Long bno);
	
	// 오래된 파일
	public List<BoardAttachVO> getOldFiles();
	
}
