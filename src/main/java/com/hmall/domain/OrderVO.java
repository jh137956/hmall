package com.hmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {

	private long od_code; // 시퀀스
	private String mb_id; // 세션정보 참조	
	private String od_name;
	private int od_post;
	private String od_addr;
	private String od_addr2;
	private String od_phone;
	private String od_email;
	private int od_total_price;
	private Date od_date; // sysdate
	
}
