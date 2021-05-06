package com.hmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	private long rv_num;
	private String mb_id;
	private long pdt_num;
	private String rv_content;
	private int rv_score;
	private Date rv_reg_date;
	
}
