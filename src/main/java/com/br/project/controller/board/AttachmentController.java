package com.br.project.controller.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import com.br.project.dto.common.AttachmentDto;
import com.br.project.service.common.attachment.AttachmentService;
import com.br.project.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
// @RequestMapping(value="board/attachment")
@RequiredArgsConstructor
@Slf4j
public class AttachmentController {

	private final AttachmentService attachmentService;
	private final FileUtil fileUtil;
	
	/**
	 * @method : 첨부파일 업로드
	 */
	public List<AttachmentDto> uploadFiles(List<MultipartFile> uploadFiles){
		
		List<AttachmentDto> attachmentList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> data = fileUtil.fileUpload(uploadFile, "board");
				
				AttachmentDto attachment = AttachmentDto.builder()
														.originName(data.get("originalName"))
														.modifyName(data.get("filesystemName"))
														.attachPath(data.get("filePath"))
														.refType("BO")
														.build();
				
				attachmentList.add(attachment);
			}
		}
		
		return attachmentList;
	}
	
	
	
	
}
