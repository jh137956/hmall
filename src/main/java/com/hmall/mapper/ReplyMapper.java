package com.hmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.dto.Criteria;
import com.hmall.domain.ReplyVO;

// 내부적으로 매퍼 인터페이스 기반으로 프록시 클래스객체가 생성이 됨. 
// root-context.xml에서 <mybatis-spring:scan base-package="com.demo.mapper"/> 설정해야 한다.
public interface ReplyMapper {

	public int insert(ReplyVO vo) throws Exception; // 테이블에 데이터 입력
	
	public ReplyVO read(Long rno) throws Exception; // 댓글번호
	
	public int delete(Long rno) throws Exception; // 댓글삭제
	
	public int update(ReplyVO reply) throws Exception;
	
	
	// 작업1>댓글내용
	// 1)cri : 페이징번호(pageNum), 게시물출력건수(amount), 2) bno : tbl_board테이블의 글번호
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno) throws Exception;
	// 작업2>댓글페이징
	public int getCountByBno(Long bno) throws Exception;
}
