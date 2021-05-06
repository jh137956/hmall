package com.hmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.MemberVO;
import com.hmall.dto.LoginDTO;
import com.hmall.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	// 아이디 중복체크
	@Override
	public int checkIdDuplicate(String mb_id) throws Exception {

		return mapper.checkIdDuplicate(mb_id);
	}

	// 로그인
	@Override
	public MemberVO login_ok(LoginDTO dto) throws Exception {

		return mapper.login_ok(dto);
	}

	// 회원가입
	@Override
	public void memberJoin(MemberVO vo) throws Exception {
	
		mapper.memberJoin(vo);
	}

	// 회원 정보 가져오기
	@Override
	public MemberVO member_info(String mb_id) throws Exception {
		
		return mapper.member_info(mb_id);
	}

	// 회원 수정 저장
	@Override
	public boolean modifyPost(MemberVO vo) throws Exception {
		
		return mapper.modifyPost(vo) == 1;
	}
	
	// 회원 탈퇴
	@Override
	public void delete_member(String mb_id) throws Exception {
		
		mapper.delete_member(mb_id);
	}

	// 비밀번호 찾기
	@Override
	public MemberVO find_password(String mb_id, String mb_name) throws Exception {
		
		return mapper.find_password(mb_id, mb_name);
	}

	// 아이디 찾기
	@Override
	public String find_id(String mb_name, String mb_email) throws Exception {
		
		return mapper.find_id(mb_name, mb_email);
	}

	@Override
	public int updatePw(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.updatePw(vo);
	}

	
	

}
