package com.hmall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hmall.domain.MemberVO;
import com.hmall.domain.UserInfo;
import com.hmall.dto.Criteria;
import com.hmall.dto.LoginDTO;

public interface MemberService {

	// 아이디 중복체크
	public int checkIdDuplicate(String mb_id) throws Exception;
	
	// 로그인 인증
	public MemberVO login_ok(LoginDTO dto) throws Exception;
	
	// 회원 가입
	public void memberJoin(MemberVO vo)throws Exception;
	
	// 회원 수정
	public MemberVO member_info(String mb_id) throws Exception;
	
	// 회원수정 저장
	public boolean modifyPost(MemberVO vo) throws Exception;
	
	// 회원 삭제
	public void delete_member(String mb_id) throws Exception;
	
	// 비밀번호 찾기
	public MemberVO find_password(String mb_id, String mb_name) throws Exception;
	
	// 아이디 찾기
	public String find_id(String mb_name, String mb_email) throws Exception;
	
	// 임시비밀번호
	public int updatePw(MemberVO vo) throws Exception;
	
	
	
}
