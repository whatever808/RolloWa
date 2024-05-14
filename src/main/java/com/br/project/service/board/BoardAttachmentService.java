package com.br.project.service.board;

import java.util.ArrayList;
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
	 * @param delFileList : 삭제할 첨부파일 번호가 담긴 배열객체
	 * @return : 조회된 첨부파일 정보가 담긴 파일객체 리스트
	 */
	public List<AttachmentDto> selectAttachmentList(String[] delFileNoArr){
		return attachmentDao.selectBoardAttachmentList(delFileNoArr);
	}
}
