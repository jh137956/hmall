package com.hmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private	Long  rno;
	private Long  bno;	
	private String reply;
	private String mb_id;
	private Date replydate;
	private Date updateDate;
	private String admin_id;
}
