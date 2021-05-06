package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hmall.dto.Criteria;
import com.hmall.dto.ReplyPageDTO;
import com.hmall.domain.ReplyVO;
import com.hmall.mapper.BoardMapper;
import com.hmall.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor //  생성자메서드는 스프링4.3에서부터 자동주입이 된다.
public class ReplyServiceImpl implements ReplyService {
// root-context.xml에 <context:component-scan base-package="com.demo.service"></context:component-scan>
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) throws Exception {
		
		return new ReplyPageDTO(mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}

	@Override
	public int modify(ReplyVO reply) throws Exception {
		// TODO Auto-generated method stub
		return mapper.update(reply);
	}

	@Transactional
	@Override
	public int delete(Long rno) throws Exception {

		// tbl_board테이블에 댓글카운트 증가/감소 : 직접적으로는 불가능
		// 참고> 처음부터 controller, view에서 게시물번호를 확보하는 방안을 생각해볼수있다
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

}
