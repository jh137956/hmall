package com.hmall.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hmall.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Test
	public void memberJoin() {
		MemberVO vo = new MemberVO();
		
		vo.setMb_id("admin");
		vo.setMb_pw("admin");
		vo.setMb_name("admin");
		vo.setMb_sex("m");
		vo.setMb_post("admin");
		vo.setMb_addr("admin");
		vo.setMb_addr2("admin");
		vo.setMb_cp("admin");
		vo.setMb_email("admin");
		
		mapper.memberJoin(vo);
		
	}
}
