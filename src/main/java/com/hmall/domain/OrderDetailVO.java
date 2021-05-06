package com.hmall.domain;

import lombok.Data;

@Data
public class OrderDetailVO {

	private long od_code; // 시퀀스
	private long pdt_num;
	private long od_amount;
	private long od_price;
}
