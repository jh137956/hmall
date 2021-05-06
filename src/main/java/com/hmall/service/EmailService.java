package com.hmall.service;

import com.hmall.dto.EmailDTO;

public interface EmailService {

	public void sendMail(EmailDTO dto, String message);
}
