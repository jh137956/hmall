package com.hmall.dto;

import java.util.List;

import com.hmall.domain.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;


@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

	private int replyCnt; // 게시물번호에의한 댓글데이터의 개수
	private List<ReplyVO> list; // 댓글데이타 내용
}
