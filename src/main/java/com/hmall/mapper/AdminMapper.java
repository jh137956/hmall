package com.hmall.mapper;

import java.util.List;

import com.hmall.domain.AdminVO;
import com.hmall.domain.MemberVO;
import com.hmall.domain.UserInfo;
import com.hmall.dto.Criteria;

public interface AdminMapper {

	// 관리자 로그인
	public AdminVO login(AdminVO vo) throws Exception;
	
	// 관리자 로그인 시간 업데이트
	public void login_update(String admin_id) throws Exception;
	
	// 관리자수정 폼
	public AdminVO admin_info(String admin_id) throws Exception;
	
	// 관리자수정 저장
	public int admin_modifyPost(AdminVO vo) throws Exception;

	// 회원목록
	public List<UserInfo> userInfo_list(Criteria cri) throws Exception;
	
	// 회원목록(페이징)
	public int getUsertotalCount(Criteria cri) throws Exception;
	
	// 회원수정 폼
	public MemberVO member_info(String mb_id) throws Exception;
	
	// 회원수정 저장
	public int modifyPost(MemberVO vo) throws Exception;
	
	// 회원 삭제
	public void user_delete(String mb_id) throws Exception;

	
}
