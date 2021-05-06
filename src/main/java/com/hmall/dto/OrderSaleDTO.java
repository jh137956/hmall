package com.hmall.dto;

import lombok.Data;

@Data
public class OrderSaleDTO {

	private String days_order;
	private String day;
	private long days_total_price;
	private long day_total_count;
}
