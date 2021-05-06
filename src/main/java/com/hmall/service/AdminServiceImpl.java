package com.hmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.AdminVO;
import com.hmall.domain.UserInfo;
import com.hmall.dto.Criteria;
import com.hmall.mapper.AdminMapper;
import com.hmall.mapper.MemberMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = @Autowired)
	private AdminMapper adminMapper;
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	
	@Override
	public AdminVO login(AdminVO vo) throws Exception {
		
		AdminVO adVO = adminMapper.login(vo);
		
		if(adVO != null) {
			adminMapper.login_update(vo.getAdmin_id()); //로그인 시간 업데이트
		}
		
		return adVO; // 이전 로그인 시간정보
	}
	
	// 관리자수정 폼
	@Override
	public AdminVO admin_info(String admin_id) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.admin_info(admin_id);
	}

	// 관리자수정 저장
	@Override
	public boolean admin_modifyPost(AdminVO vo) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.admin_modifyPost(vo) == 1;
	}
	
	@Override
	public List<UserInfo> userInfo_list(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.userInfo_list(cri);
	}

	@Override
	public int getUsertotalCount(Criteria cri) throws Exception {
		
		return adminMapper.getUsertotalCount(cri);
	}

	
	

	

	

}
