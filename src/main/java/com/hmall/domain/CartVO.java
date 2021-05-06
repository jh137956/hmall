package com.hmall.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CartVO {

	private long cart_code;
	private long pdt_num;
	private String mb_id;
	private int cart_count_buy;
	
}
