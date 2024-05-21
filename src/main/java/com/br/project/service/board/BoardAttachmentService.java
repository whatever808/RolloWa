package com.br.project.service.board;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.common.attachment.AttachmentDao;
import com.br.project.dto.common.AttachmentDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardAttachmentService {

	private final AttachmentDao attachmentDao;

	/**
	 * @param : 
	 * 	  ㄴ case 01) 첨부파일 번호로 첨부파일 조회시 : key값 : delFileNoArr(삭제할 파일번호)
	 * 	  ㄴ case 02) 참조컬럼 번호로 첨부파일 조회시 : key값 : delBoardNoArr(삭제할 공지사항번호)
	 * @return : 조회된 첨부파일 정보가 담긴 파일객체 리스트
	 */
	public List<AttachmentDto> selectAttachmentList(HashMap<String, Object> params){
		return attachmentDao.selectBoardAttachmentList(params);
	}
}
