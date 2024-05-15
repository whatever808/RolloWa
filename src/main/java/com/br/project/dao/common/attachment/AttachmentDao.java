package com.br.project.dao.common.attachment;

import java.util.HashMap;
import java.util.List;

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
	 * @param attachment : 등록할 첨부파일 정보가 담긴 파일객체
	 * @return : 등록한 첨부파일 갯수
	 */
	public int insertBoardAttachment(AttachmentDto attachment) {
		return sqlSessionTemplate.insert("attachmentMapper.insertBoardAttachment", attachment);
	}
	
	/**
	 * @param delFileList : 삭제할 첨부파일 번호가 담긴 배열객체
	 * @return : 조회된 첨부파일 정보가 담긴 파일객체 리스트
	 */
	public List<AttachmentDto> selectBoardAttachmentList(String[] delFileNoArr){
		return sqlSessionTemplate.selectList("attachmentMapper.selectBoardAttachmentList", delFileNoArr);
	}
	
	/**
	 * @param delFileNo : 삭제할 첨부파일 번호
	 * @return : 삭제(상태변경)한 첨부파일 갯수
	 */
	public int deleteBoardAttachment(String delFileNo) {
		return sqlSessionTemplate.update("attachmentMapper.deleteBoardAttachment", delFileNo);
	}
	
	/**
	 * @param params : {"refType" : {첨부파일 참조유형}, "no" : {첨부파일 참조번호}, "status" : {수정할 상태값}}
	 * @return : 상태값이 수정된 첨부파일 갯수
	 */
	public int updateBoardAttachmentStatus(HashMap<String, Object> params) {
		return sqlSessionTemplate.update("attachmentMapper.updateBoardAttachmentStatus", params);
	}
	
	/* ======================================= "가림" 구역 end ======================================= */
	
	
}
