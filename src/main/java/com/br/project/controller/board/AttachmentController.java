package com.br.project.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.service.common.attachment.AttachmentService;
import com.br.project.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="board/attachment")
@RequiredArgsConstructor
@Slf4j
public class AttachmentController {

	private final AttachmentService attachmentService;
	private final FileUtil fileUtil;
	
	
	
	
	
}
