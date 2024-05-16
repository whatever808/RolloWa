package com.br.project.dao.board;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.AttachmentDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardAttachmentDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @method : 첨부파일 등록
	 */
	public int insertAttachment(AttachmentDto attachment) {
		return sqlSessionTemplate.insert("boardAttachmentMapper.insertAttachment", attachment);
	}
	
}
