package com.br.project.dao.common.attachment;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.AttachmentDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AttachmentDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 첨부파일 등록
	public int insertAttachment(AttachmentDto attachment) {
		return sqlSessionTemplate.insert("attachmentMapper.insertAttachment", attachment);
	}
	
	/* ======================================= "가림" 구역 start ======================================= */
	/**
	 * @return : 등록한 첨부파일 갯수
	 */
	public int insertBoardAttachment(AttachmentDto attachment) {
		return sqlSessionTemplate.insert("attachmentMapper.insertBoardAttachment", attachment);
	}
	
	
	/* ======================================= "가림" 구역 end ======================================= */
	
	
}
