package com.br.project.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.br.project.dto.common.AttachmentDto;

import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@NoArgsConstructor
public class FileUtil {
	
	@Autowired
	private HttpSession session;

	/**
	 * 첨부파일 업로드시 실행될 파일업로드 처리 템플릿 메소드
	 * 
	 * @param uploadFiles : 업로드할 파일들
	 * @param category    : 저장할 파일의 유형
	 */
	public Map<String, String> fileUpload(MultipartFile uploadFile, String category) {
		
		String filePath = "/upload/" + category + new SimpleDateFormat("/yyyy/MM/dd").format(new Date());
		File filePathDir = new File(filePath);
		if(!filePathDir.exists()) {
			filePathDir.mkdirs();
		}
		
		String originalName = uploadFile.getOriginalFilename();
		String ext = originalName.endsWith(".tar.gz") ? ".tar.gz" 
													  : originalName.substring(originalName.lastIndexOf("."));
		String filesystemName = UUID.randomUUID().toString().replace("-", "") + ext;
		
		try {
			uploadFile.transferTo(new File(filePathDir, filesystemName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("originalName", originalName);
		map.put("filesystemName", filesystemName);
		map.put("filePath", filePath);
		
		return map;
		
	}
	
	
	/* ================================================================= "가림" 구역 ================================================================= */
	/**
	 * @param uploadFiles : 업로드할 첨부파일 정보가 담긴 파일객체 리스트
	 * @param fileInfo    : {"category" : {업로드폴더명}, "refType" : {참조유형}, "refNo" : {참조번호}, "status" : {저장상태}}
	 * @return            : 업로드 완료된 파일개체 리스트
	 */
	public List<AttachmentDto> getAttachmentList(List<MultipartFile> uploadFiles, HashMap<String, Object> fileInfo){
		
		List<AttachmentDto> attachmentList = new ArrayList<>();
		
		// 첨부파일 있을경우, 첨부파일 업로드
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> uploadInfo = fileUpload(uploadFile, (String)fileInfo.get("category"));
				
				AttachmentDto attachment = AttachmentDto.builder()
														.attachPath(uploadInfo.get("filePath"))
														.originName(uploadInfo.get("originalName"))
														.modifyName(uploadInfo.get("filesystemName"))
														.refType((String)fileInfo.get("refType"))
														.refNo((String)fileInfo.get("refNo"))
														.status((String)fileInfo.get("status"))
														.build();
				
				attachmentList.add(attachment);
			}
		}
		
		return attachmentList;
	}
	
	/**
	 * @param file : 저장할 이미지파일
	 * @param dir  : resources/images/ 이폴더 안에 어떤폴더에 이미지를 저장할건지 폴더명
	 * @return     : 데이터베이스에 저장할 파일경로 + 수정명을 문자열로 반환
	 */
	public String getFileUrl(MultipartFile file, String dir){
		
		String filePath = "/resources/images/" + dir + "/";
		File fileDir = new File(session.getServletContext().getRealPath(filePath));
		if(!fileDir.exists()) {
			fileDir.mkdir();
		}
		
		String originalName = file.getOriginalFilename();
		String ext = originalName.endsWith(".tar.gz") ? ".tar.gz" : originalName.substring(originalName.lastIndexOf("."));
		String filesystemName = UUID.randomUUID().toString().replace("-", "") + ext;
		
		try {
			file.transferTo(new File(fileDir, filesystemName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return filePath + filesystemName;
		
	}
	/* ================================================================= "가림" 구역 ================================================================= */
}
