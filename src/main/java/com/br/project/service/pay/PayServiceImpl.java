package com.br.project.service.pay;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.pay.PayDao;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.MemberDeptDto;
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
	public int moreDateCount(String userName) {
		return payDao.moreDateCount(userName);
	}
	
	// 결재완료된 목록갯수
	public int successListCount(String userName) {
		return payDao.successListCount(userName);
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
	
	//카테고리별 리스트(문서)
	public List<PayDto> categoryList(Map<String, Object> params, PageInfoDto pi) {
		return payDao.categoryList(params, pi);
	}
	
	
	//결재메인페이지 조회(매출보고서)
	public List<Map<String, Object>> expendDetail(Map<String, Object> map) {	
		return payDao.expendDetail(map);	
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
	
	//결재메인페이지 전체수신결재함-카테고리선택 갯수
	public int userSelectListCount(Map<String, Object> map) {
		return payDao.userSelectListCount(map);
	}
	//결재메인페이지 사용자 결재리스트
	public List<PayDto> allUserList(String userName, PageInfoDto pi) {
		return payDao.allUserList(userName, pi);
	}
	
	//결재 작성 페이지 부서 리스트
	public List<MemberDeptDto> selectDepartment(){
		return payDao.selectDepartment();
	}
	//보고서작성시 로그인한 회원의 부서, 번호, 이름, 팀이름, 직급이 담겨있음
	public List<MemberDeptDto> selectloginUserDept(MemberDto loginMember) {
		return payDao.selectloginUserDept(loginMember);
	}
	
	
	//매출보고서 등록
	public int mReportInsert(Map<String, Object> map, List<Map<String, Object>> list) {
		
		//1.매출보고서테이블 등록
		int result2 = payDao.insertMreport(map);
		//2.품목공동테이블 등록
		int result1 = 1;
			if(!list.isEmpty()) {
				result1 = 0;
				for (Map<String, Object> item : list) { 
					System.out.println("itme : " + item);

					result1 += payDao.insertItems(item);
				}				
			}
		//3.결재이력공동테이블 등록
	    int result3 = payDao.insertApproval(map);
			
		return result1 * result2 * result3;
	}
	
	//반려하기------
	public int updateReject(Map<String, Object> map) {
		return payDao.updateReject(map);		
	}
	
	
	//상세페이지 수정하기-----(첫번째 승인자의 승인날짜값이 null일때 수정가능)
	public List<Map<String, Object>> expendModify(Map<String, Object> map){
		return payDao.expendModify(map);
	}
	
	//로그인한 유저가 승인자일때 전체결재리스트
	public List<PayDto> userSelectList(Map<String, Object> map, PageInfoDto pi){
		return payDao.userSelectList(map, pi);
	}
	
	//ㅇㅇ님의 전체수신함 - 키워드검색시 갯수
	public int userSearchCount(Map<String, Object> map) {
		return payDao.userSearchCount(map);
	}
	
	public List<PayDto> userSearchList(Map<String, Object> map, PageInfoDto pi){
		return payDao.userSearchList(map, pi);
	}
	
	public int mReportUpdate(Map<String, Object> map) {
		return payDao.mReportUpdate(map);
	}
	
	public int mReportUpdate(Map<String, Object> map, List<Map<String, Object>> list){
		
		//1.매출보고서테이블 등록
		int result2 = payDao.updateMreport(map);
		//2-1.아이템품목 등록하기전에 삭제하기..
		int result4 = payDao.deleteReport(map);
		
		//2-2.품목공동테이블 등록
		int result1 = 1;
			if(!list.isEmpty()) {
				result1 = 0;
				for (Map<String, Object> item : list) { 

					result1 += payDao.updateInsertItems(item);
				}				
			}
		//3.결재이력공동테이블 등록
	    int result3 = payDao.updateApproval(map);
			
		return result1 * result2 * result3;
	}
	
		
}
