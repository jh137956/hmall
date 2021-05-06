package com.hmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserInfo {

	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_sex;
	private String user_post;
	private String user_addr;
	private String user_addr2;
	private String user_cp;
	private String user_email;
	private String user_accept_e;
	private String user_authcode;
	private int user_point;
	private Date user_regdate;
	private Date user_update_date;
	private Date user_lastdate;
	
	
}
