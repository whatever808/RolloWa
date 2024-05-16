package com.br.project.dao.facility;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.PageInfoDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AttractionDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @return : 총 어트랙션 갯수
	 */
	public int selectTotalAttractionCount() {
		return sqlSessionTemplate.selectOne("attractionMapper.selectTotalAttractionCount");
	}
	
	/**
	 * @param params : {"pageInfo" : {페이징정보}, ""}
	 * @return : 조회된 어트랙션 리스트
	 */
	public List<HashMap<String, String>> selectAttractionList(HashMap<String, Object> params){
		PageInfoDto pageInfo = (PageInfoDto)params.get("pageInfo");
		RowBounds rowBounds = new RowBounds((pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit()
											,pageInfo.getListLimit());
		return sqlSessionTemplate.selectList("attractionMapper.selectAttractionList", params, rowBounds);
	}
	
	/**
	 * @param params : {"no" : {조회할 어트랙션 번호}}
	 * @return : 조회된 어트랙션 상세정보
	 */
	public HashMap<String, String> selectAttraction(HashMap<String, Object> params){
		return sqlSessionTemplate.selectOne("attractionMapper.selectAttraction", params);
	}
	
	/**
	 * @param attraction : 등록할 어트랙션 정보
	 * @return : 등록된 어트랙션 갯수
	 */
	public int insertAttraction(HashMap<String, Object> params) {
		return sqlSessionTemplate.insert("attractionMapper.insertAttraction", params);
	}
	
	/**
	 * @param attraction : 수정할 어트랙션 정보
	 * @return : 수정된 어트랙션 갯수
	 */
	public int updateAttraction(HashMap<String, Object> params) {
		return sqlSessionTemplate.update("attractionMapper.updateAttraction", params);
	}
	
	
	
	
	
}
