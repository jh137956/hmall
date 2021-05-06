package com.hmall.domain;

import lombok.Data;

// 첨부된 파일관련 정보를 구성하는 클래스
@Data
public class AttachFileDTO {

	private String fileName; // 클라이언트 파일명
	private String uploadPath; // 날짜별 폴더명
	private String uuid; // 첨부되는 파일명을 중복처리하기위한 유일성 이름에 사용
	private boolean image; // 이미지파일인지 일반파일인지 용도 구분
	
}
