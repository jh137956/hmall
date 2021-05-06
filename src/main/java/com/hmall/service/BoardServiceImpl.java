package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hmall.domain.BoardAttachVO;
import com.hmall.domain.BoardVO;
import com.hmall.dto.Criteria;
import com.hmall.mapper.BoardAttachMapper;
import com.hmall.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	// setter메서드를 통한 bean 주입.
	// 게시판 테이블 mapper
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	// 파일첨부 테이블 mapper
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	/*
	@Autowired
	public void setMapper(BoardMapper mapper) {
		this.mapper = mapper;
	}
	*/
	
	
	@Override
	public List<BoardVO> getList() throws Exception {
		// TODO Auto-generated method stub
		return mapper.getList();
	}

	// 게시판 글쓰기(파일첨부기능 포함)
	@Transactional
	@Override
	public void insertSelectKey(BoardVO board) throws Exception {
		
		log.info("insert..." + board);
		
		// 게시판 등록. board안에 bno필드값이 시퀀스로 채워져있다
		mapper.insertSelectKey(board);
		
		// 파일첨부등록
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		// attach파라미터 안에 boardAttachVO가 전달이 된다
		board.getAttachList().forEach(attach -> {
			
			// 파일첨부 등록시 게시물 번호작업
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
	}

	
	@Override
	public BoardVO read(Long bno) throws Exception {
		// TODO Auto-generated method stub
		return mapper.read(bno);
	}

	@Override
	public int update(BoardVO board) throws Exception {
		// 파일첨부테이블에서 게시물번호에 해당하는 모든 파일정보를 삭제
		attachMapper.deleteAll(board.getBno());
		
		// 게시물 데이터 수정작업
		boolean modifyResult = mapper.update(board) == 1;
		
		// 파일첨부테이블에 화면에서 보이는 파일첨부목록을 참조하여 파일정보를 삽입
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			
			// 람다식 문법
			board.getAttachList().forEach(attach -> {
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return mapper.update(board);
	}

	@Override
	public int delete(Long bno) throws Exception {
		// TODO Auto-generated method stub
		return mapper.delete(bno);
	}
	

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<BoardVO> getListWithSearchPaging(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getListWithSearchPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachVOList(Long bno) throws Exception {
		// TODO Auto-generated method stub
		return attachMapper.findByBno(bno);
	}

	

	

	

}
