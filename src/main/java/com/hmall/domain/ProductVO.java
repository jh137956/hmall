package com.hmall.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {

	private int pdt_num;
	private String cg_code;
	private String cg_prt_code;
	private String pdt_name;
	private int pdt_price;
	private int pdt_discount;
	private String pdt_detail;
	private String pdt_img;
	private String pdt_company;
	private int pdt_count_buy;
	private String pdt_buy;
	private Date pdt_date_up;
	private Date pdt_date_edit;
	
	// 업로드 파일
	private MultipartFile file1;
	
}
