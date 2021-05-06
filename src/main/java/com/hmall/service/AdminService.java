package com.hmall.service;

import java.util.List;

import com.hmall.domain.AdminVO;
import com.hmall.domain.UserInfo;
import com.hmall.dto.Criteria;

public interface AdminService {

	// 관리자 로그인
	public AdminVO login(AdminVO vo) throws Exception;
	
	// 회원수정 폼
	public AdminVO admin_info(String admin_id) throws Exception;
	
	// 회원수정 저장
	public boolean admin_modifyPost(AdminVO vo) throws Exception;
	
	public List<UserInfo> userInfo_list(Criteria cri) throws Exception;
	
	public int getUsertotalCount(Criteria cri) throws Exception;
	
	
	
}
