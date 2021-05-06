package com.hmall.domain;

import lombok.Data;

@Data
public class OrderDetailListVO {

	private long od_code; // 시퀀스
	private long pdt_num;
	private long od_amount;
	private long od_price;
	private String pdt_name;
	private String pdt_img;
	private long pdt_discount;
	
}
