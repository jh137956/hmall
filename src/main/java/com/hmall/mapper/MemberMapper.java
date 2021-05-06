package com.hmall.mapper;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.MemberVO;
import com.hmall.dto.LoginDTO;

public interface MemberMapper {

	// 아이디 중복체크
	public int checkIdDuplicate(String mb_id) throws Exception;
	
	// 로그인 인증
	public MemberVO login_ok(LoginDTO dto) throws Exception;
	
	// 회원가입
	public void memberJoin(MemberVO vo);
	
	// 회원수정 폼
	public MemberVO member_info(String mb_id) throws Exception;
	
	// 회원수정 저장
	public int modifyPost(MemberVO vo) throws Exception;
	
	// 비밀번호 찾기
	public MemberVO find_password(@Param("mb_id") String mb_id, @Param("mb_name") String mb_name) throws Exception;
	
	// 아이디 찾기
	public String find_id(@Param("mb_name") String mb_name, @Param("mb_email") String mb_email) throws Exception;
	
	// 회원 삭제
	public void delete_member(String mb_id) throws Exception;
	
	// 임시비밀번호
	public int updatePw(MemberVO vo) throws Exception;
		
	

}
