package com.hmall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {
	
	private int pageNum; // 페이지번호. 1  2  3  4  5
	private int amount; // 페이지마다 출력될 게시물개수(예 10개)
	
	// 검색종류 
	// 검색방법? 
	// 1)단일항목검색 제목(T),내용(C),작성자(W)
	// 2)다중항목검색 제목(T),내용(C),작성자(W),제목+내용(TC), 제목+작성자(TW), 제목+내용+작성자(TCW)
	private String type; 
	private String keyword; // 검색어
	
	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	/*
	public String getType() {
		return type;
	}
	*/
	
	public String[] getTypeArr() {
		
//		System.out.println("called getTypeArr");

		return type == null? new String[] {} : type.split("");
	}

	/*
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	*/
	
	
}
