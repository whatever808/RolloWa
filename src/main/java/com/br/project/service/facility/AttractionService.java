package com.br.project.service.facility;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.facility.AttractionDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttractionService {

	private final AttractionDao attractionDao;
	
	/**
	 * @return : 총 어트랙션 갯수
	 */
	public int selectTotalAttractionCount() {
		return attractionDao.selectTotalAttractionCount();
	}
	
	/**
	 * @param params : {"pageInfo" : {페이징바정보}}
	 * @return : 조회된 어트랙션 리스트
	 */
	public List<HashMap<String, String>> selectAttractionList(HashMap<String, Object> params){
		return attractionDao.selectAttractionList(params);
	}
	
	/**
	 * @param no : 조회할 어트랙션 번호
	 * @return : 조회된 어트랙션 정보
	 */
	public HashMap<String, String> selectAttraction(HashMap<String, Object> params){
		return attractionDao.selectAttraction(params);
	}
	
	/**
	 * @param attraction : 등록할 어트랙션 정보
	 * @return : 등록된 어트랙션 갯수
	 */
	public int insertAttraction(HashMap<String, Object> params) {
		return attractionDao.insertAttraction(params);
	}
	
	/**
	 * @param params : 수정할 어트랙션 정보
	 * @return : 수정된 어트랙션 갯수
	 */
	public int updateAttraction(HashMap<String, Object> params) {
		return attractionDao.updateAttraction(params);
	}
	
}
