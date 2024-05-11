package com.br.project.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.board.BoardAttachmentDao;
import com.br.project.dto.common.AttachmentDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardAttachmentService {

	private final BoardAttachmentDao attachmentDao;
	
	/**
	 * @method : 첨부파일 등록
	 * @return : 등록실패 첨부파일 리스트
	 */
	public List<AttachmentDto> insertAttachment(List<AttachmentDto> attachmentList) {
		List<AttachmentDto> failedFiles = new ArrayList<>();
		
		for(AttachmentDto attachment : attachmentList) {
			if(attachmentDao.insertAttachment(attachment) <= 0) {
				failedFiles.add(attachment);
			}
		}
		
		return failedFiles;
	}
}
