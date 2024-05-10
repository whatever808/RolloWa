package com.br.project.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.br.project.service.common.attachment.AttachmentService;
import com.br.project.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/upload")
@RequiredArgsConstructor
@Slf4j
public class FileController {

	private final AttachmentService attachmentService;
	private final FileUtil fileUtil;
	
	
	
	/**
	 * CKEditor 이미지 업로드 (비동기)
	 * 
	 * @param uploadFile : 업로드 이미지파일
	 * @return : 업로드 파일정보가 담긴 JSON 객체
	 */
	@RequestMapping(value="/img.do")
	@ResponseBody
	public Map<String, Object> ckeditorImgUpload(MultipartHttpServletRequest uploadFile
												,HttpServletRequest request
								   				) {
		Map<String, Object> result = new HashMap<>();
		
		MultipartFile file = uploadFile.getFile("upload");
		if(file != null) {
			if(file.getSize() != 0 && file.getName().isEmpty()) {
				Map<String, String> data = fileUtil.fileUpload(file, "board/ckeditor/image/");
				
				result.put("uploadded", 1);
				result.put("filesystemName", data.get("filesystemName"));
				result.put("url", request.getContextPath() + data.get("filePath") + "/" + data.get("filesystemName"));
			}
		}
		
		return result;
	}

	/**
	 * @method : 첨부파일 업로드
	 
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
	*/
	
	
	
}
