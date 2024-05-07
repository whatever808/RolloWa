package com.br.project.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class FileUtil {

	/**
	 * 첨부파일 업로드시 실행될 파일업로드 처리 템플릿 메소드
	 * 
	 * @param uploadFiles : 업로드할 파일들
	 * @param category    : 저장할 파일의 유형
	 */
	public Map<String, String> fileUpload(MultipartFile uploadFile, String category) {
		log.debug("업로드 이미지 : {}", uploadFile);
		String filePath = "/upload/" + category + new SimpleDateFormat("/YYYY/MM/DD").format(new Date());
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
	
}
