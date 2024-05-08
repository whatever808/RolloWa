package com.br.project.service.pay;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.pay.PayDao;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.pay.PayDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PayServiceImpl {
	
	private final PayDao payDao;
	
	//결재메인페이지 목록갯수조회용
	public int selectListCount() {
		return payDao.selectListCount();
	}
	
	//결재메인페이지 리스트조회용
	public List<PayDto> paymainPage(PageInfoDto pi){
		return payDao.paymainPage(pi);
	}
	
	//일주일이상승인완료가 안된 게시글총갯수
	public int moreDateCount() {
		return payDao.moreDateCount();
	}
	
	// 결재완료된 목록갯수
	public int successListCount() {
		return payDao.successListCount();
	}
	
	// 카테고리별 '검색한' 총리스트갯수
	public int searchListCount(Map<String, String> map) {
		return payDao.searchListCount(map);
	}
	// 카테고리별 '검색한' 리스트
	public List<PayDto> searchList(PageInfoDto pi, Map<String, String> search){
		return payDao.searchList(pi, search);
	}
	
	//카테고리별 총리스트갯수(문서)
	public int slistCount(Map<String, Object> params) {
		return payDao.slistCount(params);
	}
	
	public int statusCount(String status) {
		return 1;//payDao.slistCount(status);
	}
	
	//카테고리별 리스트(문서)
	public List<PayDto> categoryList(String conditions, PageInfoDto pi) {
		return payDao.categoryList(conditions, pi);
	}
	
	//상태(긴급,보통) 리스트(문서)
	public List<PayDto> statusList(String status, PageInfoDto pi) {
		return payDao.statusList(status, pi);
	}
	
	//결재메인페이지 조회(매출보고서)
	public PayDto mdetail(PayDto pDto) {	
		return payDao.mdetail(pDto);	
	}
	
	//결재메인페이지 조회(비품신청서)
	public PayDto bdetail(PayDto pDto) {		
		return payDao.bdetail(pDto);
	}
	
	//결재메인페이지 조회(지출결의서)
	public PayDto jdetail(PayDto pDto) {	
		return payDao.jdetail(pDto);	
	}
	
	//결재메인페이지 조회(기안서)
	public PayDto gdetail(PayDto pDto) {	
		return payDao.gdetail(pDto);	
	}
		
	//결재메인페이지 조회(휴가신청서)
	public PayDto vdetail(PayDto pDto) {	
		return payDao.vdetail(pDto);	
	}
	
	//결재메인페이지 조회(휴직신청서)
	public PayDto hdetail(PayDto pDto) {	
		return payDao.hdetail(pDto);	
	}
	
	//결재메인페이지 조회(출장보고서)
	public PayDto cdetail(PayDto pDto) {	
		return payDao.cdetail(pDto);	
	}
	
	//결재메인페이지 사용자 결재리스트갯수
	public int allUserCount(String userName) {
		return payDao.allUserCount(userName);
	}
	
	//결재메인페이지 사용자 결재리스트
	public List<PayDto> allUserList(String userName, PageInfoDto pi) {
		return payDao.allUserList(userName, pi);
	}

		
}
