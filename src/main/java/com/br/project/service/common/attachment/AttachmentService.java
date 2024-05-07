package com.br.project.service.common.attachment;

import org.springframework.stereotype.Service;

import com.br.project.dao.common.attachment.AttachmentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttachmentService {

	private final AttachmentDao attachmentDao;
	
	
	
}
