package com.hmall.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartVOList {
	
	private long cart_code;
	private String pdt_img;
	private String pdt_name;
	private int cart_count_buy;
	private long pdt_price;
	private long pdt_discount;
}
