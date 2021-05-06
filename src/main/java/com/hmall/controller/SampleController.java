package com.hmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sample/*")
public class SampleController {

	@RequestMapping("/methodA")
	public void methodA() {
		
		log.info("/sample/methodA");
	}
}
