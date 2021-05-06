package com.hmall.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private	Long bno;  // 글번호 예> 게시물 조회. 참조형 : 기본형 null. 기본형 long : null
	private String b_title;
	private String b_content;
	private String mb_id;
	private Date b_regdate;
	private Date b_update_date;
	
	private int replyCnt;
	
	// 파일첨부정보(입력데이터, 출력데이터)
	private List<BoardAttachVO> attachList;
	
	/*
	public Long getBno() {
		return bno;
	}
	public void setBno(Long bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", updateDate=" + updateDate + "]";
	}
	*/
	
}
