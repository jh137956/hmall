package com.hmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.BoardVO;
import com.hmall.dto.Criteria;

// mybatis 3.0이후 등장.
// mapper인터페이스는 XML Mapper(BoardMapper.xml)과 연결이 되어있다.
public interface BoardMapper {
	
	// 게시판 목록
//	@Select("select * from tbl_board where bno > 0")
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
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount) throws Exception;
	
	
}
